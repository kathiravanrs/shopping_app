import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shrine/constants.dart';
import 'package:shrine/product.dart';
import 'package:shrine/product_tile.dart';

import 'details_page.dart';
import 'login.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  List<Product> products = [];

  loadProducts() async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("products");
    DataSnapshot data = await ref.get();
    for (DataSnapshot snap in data.children) {
      String key = snap.key!;
      double price = double.parse(snap.child("price").value!.toString());
      String desc = snap.child("desc").value!.toString();
      final title = snap.child("title").value!.toString();
      final image = snap.child("imageURL").value!.toString();
      Product p = Product(id: key, title: title, description: desc, price: price, imageUrl: image);
      products.add(p);
    }
    print(products.toString());
  }

  @override
  Widget build(BuildContext context) {
    loadProducts();
    var appBar = AppBar(
      elevation: 0.0,
      titleSpacing: 0.0,
      title: const Center(child: Text("SHRINE")),
      actions: <Widget>[
        // const SizedBox(
        //   width: 150,
        //   child: Padding(
        //     padding: EdgeInsets.fromLTRB(2, 8, 2, 8),
        //     child: TextField(
        //       // controller: ,
        //       decoration: InputDecoration(prefixIcon: Icon(Icons.search), labelText: "Search"),
        //     ),
        //   ),
        // ),
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
      drawer: Drawer(),
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
        child: GridView.builder(
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: kDefaultPaddin,
              crossAxisSpacing: kDefaultPaddin,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (context, index) => ProductTile(
                  product: products[index],
                  press: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(
                        product: products[index],
                        key: Key("sn"),
                      ),
                    ),
                  ),
                  key: Key("iosnd"),
                )),

        // child: GridView.count(
        //   crossAxisCount: 2,
        //   crossAxisSpacing: kDefaultPaddin,
        //   mainAxisSpacing: kDefaultPaddin,
        //   childAspectRatio: 0.75,
        //   children: [
        //     ProductTile(products.elementAt(0), () {}),
        //     ProductTile(products.elementAt(1), () {}),
        //     ProductTile(products.elementAt(2), () {}),
        //     ProductTile(products.elementAt(3), () {}),
        //   ],
        // ),
      ),
    );
  }
}
