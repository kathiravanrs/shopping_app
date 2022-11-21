import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shrine/supplemental/constants.dart';

import '../model/product.dart';
import '../model/product_tile.dart';
import 'details_page.dart';
import 'login.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  List<Product> products = [];

  loadProducts(DataSnapshot data) {}

  @override
  Widget build(BuildContext context) {
    var appBar = AppBar(
      elevation: 0.0,
      titleSpacing: 0.0,
      title: const Center(child: Text("SHRINE")),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.shopping_cart,
            semanticLabel: 'shopping cart',
          ),
          onPressed: () {
            // logout();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) => const LoginPage()),
            );
          },
        ),
      ],
    );

    return Scaffold(
      drawer: const Drawer(),
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        child: FutureBuilder(
          future: FirebaseDatabase.instance.ref("products").get(),
          builder: (BuildContext context, AsyncSnapshot<DataSnapshot> snapshot) {
            Widget widget;
            if (snapshot.connectionState == ConnectionState.done) {
              var snaps = snapshot.data?.children;
              products.clear();
              for (DataSnapshot snap in snaps!) {
                String key = snap.key!;
                double price = double.parse(snap.child("price").value!.toString());
                String desc = snap.child("desc").value!.toString();
                final title = snap.child("title").value!.toString();
                final image = snap.child("imageURL").value!.toString();
                Product p = Product(
                    id: key, title: title, description: desc, price: price, imageUrl: image);
                products.add(p);
              }
              if (kDebugMode) {
                print(products.toString());
              }
              Widget grid = GridView.builder(
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
              widget = grid;
            } else {
              widget = const Center(
                child: CircularProgressIndicator(),
              );
            }
            return widget;
          },
        ),
      ),
    );
  }
}
