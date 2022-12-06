import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shrine/data/product_data.dart';
import 'package:shrine/supplemental/product_methods.dart';

import '../model/product.dart';
import '../supplemental/constants.dart';

class DetailsScreen extends StatelessWidget {
  final Product product;

  const DetailsScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              child: Column(
                children: <Widget>[
                  Hero(
                    tag: product.id,
                    child: Image.network(product.imageUrl, height: screenHeight / 3),
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  Text(product.description),
                  const SizedBox(height: kDefaultPadding / 2),
                  CounterWithFavBtn(product: product),
                  const SizedBox(height: kDefaultPadding / 2),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Text(product.title),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.pushNamed(context, cartRoute);
            },
            icon: const Icon(Icons.shopping_bag))
      ],
    );
  }
}

class CounterWithFavBtn extends StatelessWidget {
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CartCounter(product: product),
          FavoriteButton(
            iconSize: 36,
            valueChanged: (_isFavorite) {
              favItems.add(product);
              if (kDebugMode) {
                print(favItems);
              }
            },
            isFavorite: favItems.contains(product),
          )
        ],
      ),
    );
  }

  const CounterWithFavBtn({Key? key, required this.product}) : super(key: key);
}

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

    return Row(
      children: <Widget>[
        OutlinedButton(
          child: const Icon(Icons.remove),
          onPressed: () {
            if (numOfItemsInCart >= 1) {
              setState(() {
                numOfItemsInCart--;
                removeFromCart(widget.product);
              });
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
          child: Text(
            numOfItemsInCart.toString().padLeft(2, "0"),
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        OutlinedButton(
            child: const Icon(Icons.add),
            onPressed: () {
              setState(() {
                numOfItemsInCart++;
                // cartItems.add(widget.product);
                addToCart(widget.product);
              });
            }),
      ],
    );
  }
}
