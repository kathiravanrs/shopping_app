import 'package:flutter/material.dart';
import 'package:shrine/model/product.dart';

class CartItem extends StatelessWidget {
  const CartItem({Key? key, required this.product, required this.quantity}) : super(key: key);
  final Product product;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Item"),
    );
  }
}
