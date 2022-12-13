import 'package:flutter/material.dart';
import 'package:shrine/supplemental/constants.dart';
import 'package:shrine/supplemental/product_methods.dart';
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
  getSubTotal() {
    double sum = 0;
    for (Product p in cartItems.keys) {
      sum = sum + p.price * cartItems[p]!;
    }
    subTotal = sum;
  }

  getShipping() {
    if (subTotal == 0 || subTotal > 75) {
      shipping = 0;
    } else {
      shipping = 21;
    }
  }

  getTax() {
    tax = subTotal * 0.08875;
  }

  getTotal() {
    total = subTotal + tax + shipping;
  }

  @override
  Widget build(BuildContext context) {
    getSubTotal();
    getShipping();
    getTax();
    getTotal();

    List<Product> cartProducts = cartItems.keys.toList();
    var showClearCartDialog = AlertDialog(
      title: const Text(
        "Empty your cart?",
        style: TextStyle(color: kShrineErrorRed),
      ),
      actions: [
        TextButton(
            onPressed: () {
              setState(() {
                clearCart();
              });
              Navigator.pop(context);
            },
            child: const Text("YES", style: TextStyle(color: kShrineBrown900))),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("NO", style: TextStyle(color: kShrineBrown900))),
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
              child: FutureBuilder(
                  future: getCartItems(),
                  builder: (BuildContext context,
                      AsyncSnapshot<Map<Product, int>> snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.all(kDefaultPadding),
                        child: ListView.separated(
                          itemCount: cartItems.length,
                          itemBuilder: (context, index) {
                            return CartItem(
                                key: Key(cartProducts[index].toString()),
                                product: cartProducts[index],
                                quantity: cartItems[cartProducts[index]]!);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Line();
                          },
                        ),
                      );
                    }
                    return const Center(child: CircularProgressIndicator());
                  }),
            ),
          ),
          const Line(),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: 250,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total:",
                    style: TextStyle(fontSize: 30),
                  ),
                  Text(
                    total.toStringAsFixed(2),
                    style: const TextStyle(fontSize: 30),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: 250,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Subtotal:",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    subTotal.toStringAsFixed(2),
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: 250,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Shipping:",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    shipping.toStringAsFixed(2),
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: SizedBox(
              width: 250,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Tax:",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    tax.toStringAsFixed(2),
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
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
                      backgroundColor: kShrinePink50,
                      foregroundColor: kShrineBrown900),
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
                      backgroundColor: kShrinePink300,
                      foregroundColor: kShrineBrown900),
                  onPressed: () {
                    if (total != 0) {
                      Navigator.pushNamed(context, checkoutRoute);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content:
                              Text("Add at least one product to checkout!")));
                    }
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
