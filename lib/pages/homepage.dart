import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shrine/supplemental/constants.dart';
import 'package:shrine/widgets/side_drawer.dart';

import '../model/product.dart';
import '../widgets/product_tile.dart';
import 'details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> products = [];

  @override
  Widget build(BuildContext context) {
    var homeAppBar = AppBar(
      bottom: const TabBar(
        labelColor: kShrineBrown900,
        tabs: [
          Tab(
              icon: Icon(
            Icons.home_filled,
          )),
          Tab(
              icon: Icon(
            Icons.search,
          )),
          Tab(
              icon: Icon(
            Icons.shopping_bag,
          )),
        ],
      ),
      elevation: 0.0,
      titleSpacing: 0.0,
      title: const Center(
        child: Text("SHRINE"),
      ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.shopping_cart,
            semanticLabel: 'shopping cart',
          ),
          onPressed: () {
            Navigator.pushNamed(context, '/cart');
          },
        ),
      ],
    );

    // return DefaultTabController(length: length, child: child)

    var home = Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
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
              Product p =
                  Product(id: key, title: title, description: desc, price: price, imageUrl: image);
              products.add(p);
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

    var search = const Padding(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPaddin),
      child: Center(child: Text("Search")),
    );

    var orders = const Padding(
      padding: EdgeInsets.symmetric(horizontal: kDefaultPaddin),
      child: Center(child: Text("Orders")),
    );

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        drawer: const SideDrawer(),
        appBar: homeAppBar,
        body: TabBarView(
          children: [
            home,
            search,
            orders,
          ],
        ),
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
        mainAxisSpacing: kDefaultPaddin,
        crossAxisSpacing: kDefaultPaddin,
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
