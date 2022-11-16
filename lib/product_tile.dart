import 'package:flutter/material.dart';

import 'constants.dart';
import 'product.dart';

class ProductTile extends StatelessWidget {
  final Product product;
  final VoidCallback press;

  const ProductTile({required this.product, required this.press, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(kDefaultPaddin),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Hero(
                tag: "${product.id}",
                child: Image.network(product.imageUrl),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPaddin / 4),
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

    // return Container(
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: [
    //       Image.network(
    //         product.imageUrl,
    //         fit: BoxFit.scaleDown,
    //       ),
    //       GridTileBar(
    //         backgroundColor: Colors.black87,
    //         leading: IconButton(
    //           icon: Icon(product.isFavourite ? Icons.favorite : Icons.favorite_border),
    //           color: Theme.of(context).colorScheme.secondary,
    //           onPressed: () {
    //             product.toggleFavorite();
    //           },
    //         ),
    //         title: Text(
    //           product.title,
    //           textAlign: TextAlign.center,
    //         ),
    //         trailing: IconButton(
    //           icon: const Icon(Icons.shopping_cart),
    //           onPressed: () {},
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
