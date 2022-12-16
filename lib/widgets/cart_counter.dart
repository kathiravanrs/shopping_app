import 'package:flutter/material.dart';

import '../data/product_data.dart';
import '../model/product.dart';
import '../supplemental/constants.dart';
import '../supplemental/product_methods.dart';

class CartCounter extends StatefulWidget {
  final Product product;

  const CartCounter({Key? key, required this.product}) : super(key: key);

  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  @override
  Widget build(BuildContext context) {
    int numOfItemsInCart = cartItems[widget.product] ?? 0;

    if (numOfItemsInCart == 0) {
      return SizedBox(
        width: 200,
        child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: kElectronPink300,
              foregroundColor: kElectronBrown900),
          onPressed: () {
            setState(() {
              addToCart(widget.product);
            });
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Item added to cart!")));
          },
          child: const Center(
            child: Text("Add to Cart"),
          ),
        ),
      );
    } else {
      return SizedBox(
        width: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            OutlinedButton(
              child: const Icon(Icons.remove),
              onPressed: () {
                setState(() {
                  removeFromCart(widget.product);
                });
                if (numOfItemsInCart == 1) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Item removed from cart!")));
                }
              },
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
              child: Text(
                numOfItemsInCart.toString().padLeft(2, "0"),
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            OutlinedButton(
              child: const Icon(Icons.add),
              onPressed: () {
                setState(() {
                  addToCart(widget.product);
                });
              },
            ),
          ],
        ),
      );
    }
  }
}
