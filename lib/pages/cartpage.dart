import 'package:flutter/material.dart';
import 'package:shrine/supplemental/constants.dart';
import 'package:shrine/widgets/cart_item.dart';

import '../model/product.dart';
import '../supplemental/theme.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
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

    Widget body = Padding(
      padding: const EdgeInsets.all(kDefaultPaddin),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text("Your cart contains ${cartItems.length} items",
              style: const TextStyle(fontSize: 24)),
          const Line(),
          Container(
            height: MediaQuery.of(context).size.height / 2,
            color: kShrinePink50,
            child: Padding(
              padding: const EdgeInsets.all(kDefaultPaddin),
              child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    return CartItem(product: cartItems[index], quantity: 1);
                  }),
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
                    Navigator.pushNamed(context, '/checkout');
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
