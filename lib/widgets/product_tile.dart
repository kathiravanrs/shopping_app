import 'package:flutter/material.dart';
import 'package:shrine/model/product.dart';

import '../supplemental/constants.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final VoidCallback press;

  const ProductTile({required this.product, required this.press, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(kDefaultPadding),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Hero(
                tag: product.id,
                child: FadeInImage.assetNetwork(
                  image: product.imageUrl,
                  placeholder: 'assets/images/Loading_icon.gif',
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 4),
            child: Text(
              product.title,
              style: const TextStyle(color: kTextLightColor),
            ),
          ),
          Text(
            "\$${product.price}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
