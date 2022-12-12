import 'package:flutter/material.dart';
import 'package:shrine/data/product_data.dart';
import 'package:shrine/model/review.dart';
import 'package:shrine/widgets/comment_section.dart';

import '../model/product.dart';
import '../supplemental/constants.dart';
import '../widgets/counter_button.dart';

class DetailsScreen extends StatelessWidget {
  final Product product;

  const DetailsScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    List<Review> productReviews =
        reviews.where((element) => element.productID == product.id).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            children: <Widget>[
              SizedBox(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: kDefaultPadding),
                      child: Hero(
                        tag: product.id,
                        child: Image.network(product.imageUrl,
                            height: screenHeight / 3,
                            errorBuilder: (ctx, obj, trc) {
                          return Container(
                              decoration: BoxDecoration(border: Border.all()),
                              height: screenHeight / 3,
                              child: const Center(
                                  child: Text("Image coming soon")));
                        }),
                      ),
                    ),
                    const SizedBox(height: kDefaultPadding / 2),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "\$" + product.price.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 28),
                        )),
                    const SizedBox(height: kDefaultPadding / 2),
                    Text(product.description),
                    const SizedBox(height: kDefaultPadding / 2),
                    CounterWithFavBtn(product: product),
                    const SizedBox(height: kDefaultPadding / 2),
                    CommentArea(reviews: productReviews),
                    const SizedBox(height: kDefaultPadding / 2),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Text(product.title),
      actions: [
        IconButton(
            onPressed: () => Navigator.pushNamed(context, cartRoute),
            icon: const Icon(Icons.shopping_bag))
      ],
    );
  }
}
