import 'package:flutter/material.dart';
import 'package:shrine/data/product_data.dart';
import 'package:shrine/supplemental/constants.dart';
import 'package:shrine/widgets/product_grid.dart';

class Favourites extends StatelessWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourites"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: ProductGrid(products: favItems),
      ),
    );
  }
}
