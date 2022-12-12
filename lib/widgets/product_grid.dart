import 'package:flutter/material.dart';
import 'package:shrine/widgets/product_tile.dart';

import '../model/product.dart';
import '../pages/details_page.dart';
import '../supplemental/constants.dart';

class ProductGrid extends StatefulWidget {
  const ProductGrid({
    Key? key,
    required this.products,
  }) : super(key: key);

  final List<Product> products;

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: widget.products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: kDefaultPadding,
        crossAxisSpacing: kDefaultPadding,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        return ProductTile(
          product: widget.products[index],
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsScreen(
                  product: widget.products[index],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
