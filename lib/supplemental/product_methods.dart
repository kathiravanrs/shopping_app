import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:shrine/data/product_data.dart';
import 'package:shrine/data/user_details.dart';
import 'package:shrine/model/review.dart';
import 'package:shrine/pages/checkout_page.dart';
import 'package:shrine/supplemental/constants.dart';

import '../model/address.dart';
import '../model/order.dart';
import '../model/product.dart';

Future<List<Product>> getProducts() async {
  if (products.isNotEmpty) return products;
  await FirebaseDatabase.instance.ref("products").get().then((snapshot) {
    var snaps = snapshot.children;
    for (DataSnapshot snap in snaps) {
      final key = snap.key!;
      final price = double.parse(snap.child("price").value!.toString());
      final desc = snap.child("desc").value!.toString();
      final title = snap.child("title").value!.toString();
      final image = snap.child("imageURL").value!.toString();
      final category = snap.child("category").value!.toString();

      Product p = Product(
          id: key,
          title: title,
          description: desc,
          price: price,
          category: category,
          imageUrl: image);
      products.firstWhere((element) => element.id == key, orElse: () {
        products.add(p);
        return p;
      });
    }
  });
  getCartItems();
  getFavItems();
  getOrders();
  getReviews();
  getUserData();
  getAddress();
  return products;
}

Future<void> addToCart(Product product) async {
  cartItems.update(product, (value) => value + 1, ifAbsent: () => 1);
  DatabaseReference ref =
      FirebaseDatabase.instance.ref("cart/$userID/${product.id}");
  final snap = await ref.get();
  int quantity = int.parse(((snap.child("quantity").value) ?? 0).toString());
  await ref.set({"quantity": quantity + 1});
}

Future<void> removeFromCart(Product product) async {
  int prevCount = cartItems[product] ?? 0;
  if (prevCount > 1) {
    cartItems[product] = (cartItems[product] ?? 0) - 1;
  } else {
    cartItems.remove(product);
  }

  DatabaseReference ref =
      FirebaseDatabase.instance.ref("cart/$userID/${product.id}");
  final snap = await ref.get();
  int quantity = int.parse(((snap.child("quantity").value) ?? 0).toString());
  if (kDebugMode) {
    print(quantity);
  }
  if (quantity > 1) {
    await ref.set({"quantity": quantity - 1});
  } else {
    await ref.remove();
  }
}

Future<void> clearCart() async {
  cartItems.clear();
  await FirebaseDatabase.instance.ref("cart/$userID").remove();
}

Future<Map<Product, int>> getCartItems() async {
  if (cartItems.isNotEmpty) return cartItems;
  DatabaseReference ref = FirebaseDatabase.instance.ref("cart/$userID");
  await ref.get().then((value) {
    cartItems.clear();
    for (DataSnapshot snap in value.children) {
      Product product = getProductFromID(snap.key ?? "");
      int count = int.parse(snap.child("quantity").value!.toString());
      cartItems.putIfAbsent(product, () => count);
    }
  });
  return cartItems;
}

Product getProductFromID(String id) {
  for (Product product in products) {
    if (product.id == id) return product;
  }
  return Product(
      id: "-1",
      title: "No Such Product",
      description: "description",
      price: 0.00,
      imageUrl:
          "https://cdn.pixabay.com/photo/2017/02/12/21/29/false-2061132__340.png",
      category: 'Not Available');
}

placeOrder(CardFormResults cardFormResults, Address address) async {
  DatabaseReference ref =
      FirebaseDatabase.instance.ref("orders/$userID").push();
  Map<String, int> cartProductCount = {};
  for (Product product in cartItems.keys) {
    cartProductCount.putIfAbsent(product.id, () => cartItems[product] ?? 0);
  }
  await ref.set({
    "addressID": address.addID,
    "status": "Delivered",
    "id": getRandomString(10),
    "email": cardFormResults.email,
    "buyer": cardFormResults.name,
    "products": cartProductCount,
    "card": cardFormResults.cardNumber,
    "deliveryAddress": "470 72nd St",
    "amount": total,
    "order date": DateTime.now().millisecondsSinceEpoch.toString(),
    "delivery date": DateTime.now()
        .add(const Duration(days: 4))
        .millisecondsSinceEpoch
        .toString(),
  }).then((value) {
    clearCart();
  });
  return false;
}

Future<List<Order>> getOrders() async {
  await FirebaseDatabase.instance.ref("orders/$userID").get().then((value) {
    for (DataSnapshot snap in value.children) {
      Map<Product, int> productCount = {};
      for (DataSnapshot productPair in snap.child("products").children) {
        String productID = productPair.key.toString();
        // print(productID);
        productCount.putIfAbsent(getProductFromID(productID), () {
          prevOrder.add(getProductFromID(productID));
          return int.parse(productPair.child(productID).value.toString());
        });
      }

      String orderID = snap.child("id").value.toString();
      String cardUsed = snap.child("card").value.toString();
      String orderStatus = snap.child("status").value.toString();
      String buyer = snap.child("buyer").value.toString();
      String deliveryAddress = snap.child("deliveryAddress").value.toString();
      int deliveryDate =
          int.parse(snap.child("delivery date").value.toString());
      int orderDate = int.parse(snap.child("order date").value.toString());
      double orderCost = double.parse(snap.child("amount").value.toString());

      Order order = Order(
        orderID: orderID,
        cardUsed: cardUsed,
        orderStatus: orderStatus,
        buyer: buyer,
        deliveryAddress: deliveryAddress,
        deliveryDate: DateTime.fromMillisecondsSinceEpoch(deliveryDate),
        orderDate: DateTime.fromMillisecondsSinceEpoch(orderDate),
        productsAndCount: productCount,
        totalOrderCost: orderCost,
      );
      orders.firstWhere((element) => element.orderID == orderID, orElse: () {
        orders.add(order);
        return order;
      });
    }
  });
  return orders;
}

Future<void> toggleFav(Product product) async {
  DatabaseReference ref =
      FirebaseDatabase.instance.ref("favourites/$userID/${product.id}");
  if (favItems.contains(product)) {
    await ref.remove();
    favItems.remove(product);
  } else {
    await ref.set({"fav": 1});
    favItems.add(product);
  }
}

Future<List<Product>> getFavItems() async {
  if (favItems.isNotEmpty) return favItems;
  DatabaseReference ref = FirebaseDatabase.instance.ref("favourites/$userID");
  await ref.get().then((value) {
    for (DataSnapshot snap in value.children) {
      Product product = getProductFromID(snap.key ?? "");
      favItems.firstWhere((element) => element.id == product.id, orElse: () {
        favItems.add(product);
        return product;
      });
    }
  });
  return favItems;
}

Future<void> addReview(Review review) async {
  reviews.add(review);
  DatabaseReference ref =
      FirebaseDatabase.instance.ref("reviews/${review.productID}").push();
  await ref.set({
    "date": review.commentDate.toString(),
    "comment": review.comment,
    "user": review.userName,
    "commentID": review.commentID
  });
}

Future<List<Review>> getReviews() async {
  if (reviews.isNotEmpty) return reviews;
  await FirebaseDatabase.instance.ref("reviews").get().then((snapshot) {
    var snaps = snapshot.children;
    for (DataSnapshot s in snaps) {
      final productID = s.key!;
      for (DataSnapshot snap in s.children) {
        final comment = snap.child("comment").value!.toString();
        final commentID = snap.child("commentID").value!.toString();
        final user = snap.child("user").value!.toString();
        final date = (snap.child("date").value!.toString());

        Review review = Review(
          commentDate: date,
          productID: productID,
          commentID: commentID,
          comment: comment,
          userName: user,
        );
        reviews.firstWhere((element) => element.commentID == commentID,
            orElse: () {
          reviews.add(review);
          return review;
        });
      }
    }
  });
  return reviews;
}

Future<void> getUserData() async {
  await FirebaseDatabase.instance.ref("users/$userID").get().then((snapshot) {
    firstName = snapshot.child("firstName").value.toString();
    lastName = snapshot.child("lastName").value.toString();
    email = snapshot.child("email").value.toString();
    phone = snapshot.child("phone").value.toString();
  });
}

Future<void> saveAddress(Address address) async {
  addresses.add(address);
  DatabaseReference ref =
      FirebaseDatabase.instance.ref("users/$userID/address").push();
  await ref.set({
    "addressID": address.addID,
    "fName": address.firstName,
    "lName": address.lastName,
    "street": address.streetAddress,
    "city": address.city,
    "state": address.state,
    "zip": address.zip,
    "phone": address.phone
  });
}

Future<List<Address>> getAddress() async {
  if (reviews.isNotEmpty) return addresses;
  await FirebaseDatabase.instance
      .ref("users/$userID/address")
      .get()
      .then((snapshot) {
    var snaps = snapshot.children;
    for (DataSnapshot snap in snaps) {
      final id = snap.child("addressID").value!.toString();

      final firstName = snap.child("fName").value!.toString();
      final lastName = snap.child("lName").value!.toString();
      final streetAddress = snap.child("street").value!.toString();
      final city = (snap.child("city").value!.toString());
      final state = (snap.child("state").value!.toString());
      final zip = (snap.child("zip").value!.toString());
      final phone = (snap.child("phone").value!.toString());

      Address address = Address(
          addID: id,
          firstName: firstName,
          lastName: lastName,
          streetAddress: streetAddress,
          city: city,
          state: state,
          zip: int.parse(zip),
          phone: phone);
      addresses.firstWhere((element) => element.addID == id, orElse: () {
        addresses.add(address);
        return address;
      });
    }
  });
  return addresses;
}

Address getAddressFromID(String id) {
  getAddress();
  return addresses.firstWhere((element) => element.addID == id);
}
