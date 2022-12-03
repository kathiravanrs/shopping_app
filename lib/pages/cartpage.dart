import 'package:flutter/material.dart';
import 'package:shrine/supplemental/constants.dart';
import 'package:shrine/widgets/cart_item.dart';

import '../data/product_data.dart';
import '../model/product.dart';
import '../supplemental/theme.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double getSubTotal() {
    double sum = 0;
    for (Product product in cartItems) {
      sum = sum + product.price;
    }
    return sum;
  }

  double getShipping() {
    return 21;
  }

  double getTax() {
    return (getSubTotal() * 0.08875);
  }

  double getTotal() {
    return getShipping() + getSubTotal() + getTax();
  }

  @override
  Widget build(BuildContext context) {
    var showClearCartDialog = AlertDialog(
      title: const Text(
        "Empty your cart?",
        style: TextStyle(color: kShrineErrorRed),
      ),
      actions: [
        TextButton(
            onPressed: () {
              setState(() {
                cartItems.clear();
              });
              Navigator.pop(context);
            },
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
      centerTitle: true,
      title: const Text("CART"),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.delete,
            semanticLabel: 'Clear Cart',
          ),
          onPressed: () {
            showDialog(context: context, builder: (_) => showClearCartDialog);
          },
        ),
      ],
    );

    Widget body = Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Your cart contains ${cartItems.length} items",
              style: const TextStyle(fontSize: 24)),
          const Line(),
          Expanded(
            child: Container(
              color: kShrinePink25,
              child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: ListView.separated(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    return CartItem(product: cartItems[index], quantity: 1);
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Line();
                  },
                ),
              ),
            ),
          ),
          const Line(),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "Total: \$ ${getTotal().toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 30),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "Subtotal: ${getSubTotal().toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "Shipping: ${getShipping().toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "Tax: ${getTax().toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const Line(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 150,
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: kShrinePink50, foregroundColor: kShrineBrown900),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Add More"),
                ),
              ),
              SizedBox(
                width: 150,
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: kShrinePink300, foregroundColor: kShrineBrown900),
                  onPressed: () {
                    Navigator.pushNamed(context, checkoutRoute);
                  },
                  child: const Text("Checkout"),
                ),
              ),
            ],
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: cartAppBar,
      body: body,
    );
  }
}
