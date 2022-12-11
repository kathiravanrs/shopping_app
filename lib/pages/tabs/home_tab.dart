import 'package:flutter/material.dart';
import 'package:shrine/supplemental/product_methods.dart';

import '../../model/product.dart';
import '../../supplemental/constants.dart';
import '../../widgets/product_tile.dart';
import '../details_page.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: FutureBuilder(
        future: getProducts(),
        builder: (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
          if (snapshot.hasData) {
            return ProductGrid(products: snapshot.data!);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class ProductGrid extends StatelessWidget {
  const ProductGrid({
    Key? key,
    required this.products,
  }) : super(key: key);

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: kDefaultPadding,
        crossAxisSpacing: kDefaultPadding,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        return ProductTile(
          product: products[index],
          press: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsScreen(
                  product: products[index],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
