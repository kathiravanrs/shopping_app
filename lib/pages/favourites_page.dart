import 'package:electron_avenue/data/product_data.dart';
import 'package:electron_avenue/supplemental/constants.dart';
import 'package:electron_avenue/widgets/product_grid.dart';
import 'package:flutter/material.dart';

class Favourites extends StatelessWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (favItems.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Favourites"),
        ),
        body: const Padding(
          padding: EdgeInsets.all(kDefaultPadding),
          child: Center(child: Text("You do not have any favourite items yet")),
        ),
      );
    }
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
