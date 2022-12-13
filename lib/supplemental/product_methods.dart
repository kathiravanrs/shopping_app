import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:shrine/data/product_data.dart';
import 'package:shrine/data/user_details.dart';
import 'package:shrine/pages/checkout_page.dart';
import 'package:shrine/supplemental/constants.dart';

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

placeOrder(CardFormResults cardFormResults) async {
  DatabaseReference ref =
      FirebaseDatabase.instance.ref("orders/$userID").push();
  Map<String, int> cartProductCount = {};
  for (Product product in cartItems.keys) {
    cartProductCount.putIfAbsent(product.id, () => cartItems[product] ?? 0);
  }
  await ref.set({
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
        productCount.putIfAbsent(getProductFromID(productID),
            () => int.parse(productPair.child(productID).value.toString()));
      }
      // print(productCount);
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
  // final snap = await ref.get();
  if (favItems.contains(product)) {
    await ref.remove();
  } else {
    await ref.set({"fav": 1});
    favItems.add(product);
  }
}

Future<Map<Product, int>> getFavItems() async {
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
