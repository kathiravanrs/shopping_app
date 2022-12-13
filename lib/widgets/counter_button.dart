import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shrine/supplemental/product_methods.dart';

import '../data/product_data.dart';
import '../model/product.dart';
import '../supplemental/constants.dart';
import 'cart_counter.dart';

class CounterWithFavBtn extends StatelessWidget {
  final Product product;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushNamedAndRemoveUntil(
            context, homePageRoute, (route) => false);
        return true;
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CartCounter(product: product),
          FavoriteButton(
            iconSize: 36,
            valueChanged: (_isFavorite) {
              toggleFav(product);
            },
            isFavorite: favItems.contains(product),
          )
        ],
      ),
    );
  }

  const CounterWithFavBtn({Key? key, required this.product}) : super(key: key);
}
