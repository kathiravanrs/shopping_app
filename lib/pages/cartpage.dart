import 'package:flutter/material.dart';
import 'package:shrine/supplemental/constants.dart';
import 'package:shrine/widgets/side_drawer.dart';

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
      title: const Center(child: Text("Shopping Cart")),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.delete,
            semanticLabel: 'Empty Cart',
          ),
          onPressed: () {
            // logout();
            showDialog(context: context, builder: (_) => showClearCartDialog);
          },
        ),
      ],
    );

    return Scaffold(
      drawer: const SideDrawer(),
      appBar: cartAppBar,
      body: const Center(
        child: Text(
          "Your cart is currently empty!",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
