import 'package:flutter/material.dart';
import 'package:shrine/supplemental/constants.dart';
import 'package:shrine/widgets/cart_item.dart';

import '../model/product.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    var showClearCartDialog = AlertDialog(
      title: const Text(
        "Empty your cart?",
        style: TextStyle(color: kShrineErrorRed),
      ),
      actions: [
        TextButton(
            onPressed: () {},
            child: const Text(
              "YES",
              style: TextStyle(color: kShrineBrown900),
            )),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "NO",
              style: TextStyle(color: kShrineBrown900),
            )),
      ],
    );

    var cartAppBar = AppBar(
      elevation: 0.0,
      titleSpacing: 0.0,
      title: const Center(child: Text("CART")),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.delete,
            semanticLabel: 'Clear Cart',
          ),
          onPressed: () {
            // logout();
            showDialog(context: context, builder: (_) => showClearCartDialog);
          },
        ),
      ],
    );
    var cartItems = [
      Product(
          id: "p1",
          title: "Red Shirt",
          description: "A red shirt - it is pretty red!",
          price: 29.99,
          imageUrl: "https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg"),
      Product(
          id: "p1",
          title: "Red Shirt",
          description: "A red shirt - it is pretty red!",
          price: 29.99,
          imageUrl: "https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg"),
    ];
    var line = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: kDefaultPaddin / 2),
      child: Container(color: kShrineBrown900, height: 1),
    );

    String numberOfItemText = "Your cart contains ${cartItems.length} items";
    Widget body = Padding(
      padding: const EdgeInsets.all(kDefaultPaddin),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(numberOfItemText, style: const TextStyle(fontSize: 30)),
          line,
          Container(
            height: MediaQuery.of(context).size.height / 2,
            color: kShrinePink100,
            child: Padding(
              padding: const EdgeInsets.all(kDefaultPaddin),
              child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    return CartItem(product: cartItems[index], quantity: 1);
                  }),
            ),
          ),
          line,
          Align(
              alignment: Alignment.centerLeft,
              child: Text("Total:", style: const TextStyle(fontSize: 30))),
        ],
      ),
    );

    return Scaffold(
      appBar: cartAppBar,
      body: body,
    );
  }
}
