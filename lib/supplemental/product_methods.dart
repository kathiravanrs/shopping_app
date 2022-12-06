import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:shrine/data/product_data.dart';
import 'package:shrine/data/user_details.dart';

import '../model/product.dart';

getProducts() async {
  FirebaseDatabase.instance.ref("products").get().then((snapshot) {
    var snaps = snapshot.children;
    for (DataSnapshot snap in snaps) {
      final key = snap.key!;
      final price = double.parse(snap.child("price").value!.toString());
      final desc = snap.child("desc").value!.toString();
      final title = snap.child("title").value!.toString();
      final image = snap.child("imageURL").value!.toString();
      products.add(
        Product(
          id: key,
          title: title,
          description: desc,
          price: price,
          imageUrl: image,
        ),
      );
    }
    if (kDebugMode) {
      print(products.toString());
    }
    getCartItems();
  });
}

addToCart(Product product) async {
  cartItems.update(product, (value) => value + 1, ifAbsent: () => 1);
  DatabaseReference ref = FirebaseDatabase.instance.ref("cart/$userID/${product.id}");
  final snap = await ref.get();
  int quantity = int.parse(((snap.child("quantity").value) ?? 0).toString());
  await ref.set({"quantity": quantity + 1});
}

removeFromCart(Product product) async {
  int prevCount = cartItems[product] ?? 0;
  if (prevCount > 1) {
    cartItems[product] = (cartItems[product] ?? 0) - 1;
  } else {
    cartItems.remove(product);
  }

  DatabaseReference ref = FirebaseDatabase.instance.ref("cart/$userID/${product.id}");
  final snap = await ref.get();
  int quantity = int.parse(((snap.child("quantity").value) ?? 0).toString());
  print(quantity);
  if (quantity > 1) {
    await ref.set({"quantity": quantity - 1});
  } else {
    await ref.remove();
  }
}

clearCart() async {
  cartItems.clear();
  await FirebaseDatabase.instance.ref("cart/$userID").remove();
}

getCartItems() async {
  DatabaseReference ref = FirebaseDatabase.instance.ref("cart/$userID");
  ref.get().then((value) {
    for (DataSnapshot snap in value.children) {
      Product product = getProductFromID(snap.key ?? "");
      int count = int.parse(snap.child("quantity").value!.toString());
      cartItems.putIfAbsent(product, () => count);
      if (kDebugMode) {
        print(products.toString() + " -->" + count.toString() + "\n");
      }
    }
  });
}

finishOrder() async {}

getOrders() async {}

Product getProductFromID(String ID) {
  for (Product product in products) {
    if (product.id == ID) return product;
  }
  return Product(
      id: "-1",
      title: "No Such Product",
      description: "description",
      price: 0.00,
      imageUrl: "https://cdn.pixabay.com/photo/2017/02/12/21/29/false-2061132__340.png");
}
