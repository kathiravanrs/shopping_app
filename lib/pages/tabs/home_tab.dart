import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../model/product.dart';
import '../../supplemental/constants.dart';
import '../../widgets/product_tile.dart';
import '../details_page.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Product> products = [];

    var home = Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: FutureBuilder(
        future: FirebaseDatabase.instance.ref("products").get(),
        builder: (BuildContext context, AsyncSnapshot<DataSnapshot> snapshot) {
          Widget widget;
          if (snapshot.connectionState == ConnectionState.done) {
            var snaps = snapshot.data?.children;
            products.clear();
            for (DataSnapshot snap in snaps!) {
              final key = snap.key!;
              final price = double.parse(snap.child("price").value!.toString());
              final desc = snap.child("desc").value!.toString();
              final title = snap.child("title").value!.toString();
              final image = snap.child("imageURL").value!.toString();
              products.add(
                Product(
                  id: key,
                  title: title,
                  description: desc,
                  price: price,
                  imageUrl: image,
                ),
              );
            }
            if (kDebugMode) {
              print(products.toString());
            }
            widget = ProductGrid(products: products);
          } else {
            widget = const Center(
              child: CircularProgressIndicator(),
            );
          }
          return widget;
        },
      ),
    );

    return home;
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
        // return Text("h");
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
