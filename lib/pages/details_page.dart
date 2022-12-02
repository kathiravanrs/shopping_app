import 'package:flutter/material.dart';

import '../model/product.dart';
import '../supplemental/constants.dart';

class DetailsScreen extends StatelessWidget {
  final Product product;
  const DetailsScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    child: Image.network(product.imageUrl),
                  ),
                  const SizedBox(height: kDefaultPadding / 2),
                  Text(product.description),
                  const SizedBox(height: kDefaultPadding / 2),
                  const CounterWithFavBtn(),
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
    );
  }
}

class CounterWithFavBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const <Widget>[
          CartCounter(),
          SizedBox(
            height: 32,
            width: 32,
            child: Icon(Icons.favorite),
          )
        ],
      ),
    );
  }

  const CounterWithFavBtn({Key? key}) : super(key: key);
}

class CartCounter extends StatefulWidget {
  const CartCounter({Key? key}) : super(key: key);

  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  int numOfItems = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        OutlinedButton(
          child: const Icon(Icons.remove),
          onPressed: () {
            if (numOfItems > 1) {
              setState(() => numOfItems--);
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
          child: Text(
            numOfItems.toString().padLeft(2, "0"),
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        OutlinedButton(child: const Icon(Icons.add), onPressed: () => setState(() => numOfItems++)),
      ],
    );
  }
}
