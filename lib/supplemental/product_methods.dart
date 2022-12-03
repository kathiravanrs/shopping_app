import 'package:firebase_database/firebase_database.dart';
import 'package:shrine/data/product_data.dart';
import 'package:shrine/data/user_details.dart';

import '../model/product.dart';

addToCart(Product product) async {
  cartItems.add(product);
  DatabaseReference ref = FirebaseDatabase.instance.ref("cart/$userID/${product.id}");
  final snap = await ref.get();
  int quantity = int.parse((snap.child("quantity").value).toString());
  // DatabaseReference ref = r.push();
  await ref.set({"quantity": quantity + 1});
}
