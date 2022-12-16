import 'package:electron_avenue/data/product_data.dart';
import 'package:electron_avenue/data/user_details.dart';
import 'package:electron_avenue/model/review.dart';
import 'package:electron_avenue/supplemental/product_methods.dart';
import 'package:electron_avenue/widgets/comment_section.dart';
import 'package:flutter/material.dart';

import '../model/product.dart';
import '../supplemental/constants.dart';
import '../widgets/counter_button.dart';

class DetailsScreen extends StatefulWidget {
  final Product product;

  const DetailsScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  var reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    List<Review> productReviews = reviews
        .where((element) => element.productID == widget.product.id)
        .toList();

    var addComment = Column(
      children: [
        TextField(
          controller: reviewController,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                  onPressed: () {
                    Review review = Review(
                      commentDate:
                          DateTime.now().millisecondsSinceEpoch.toString(),
                      productID: widget.product.id,
                      commentID: getRandomString(10),
                      comment: reviewController.text,
                      userName: firstName,
                    );
                    setState(() {
                      addReview(review);
                    });
                    reviewController.clear();
                  },
                  icon: const Icon(Icons.send)),
              border: const OutlineInputBorder(),
              label: const Text(
                "Purchased recently. Add a review?",
                style: TextStyle(color: kElectronBrown900, fontSize: 12),
              )),
        )
      ],
    );

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
                        padding: const EdgeInsets.symmetric(
                            vertical: kDefaultPadding),
                        child: Hero(
                          tag: widget.product.id,
                          child: Image.network(widget.product.imageUrl,
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
                            "\$" + widget.product.price.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 28),
                          )),
                      const SizedBox(height: kDefaultPadding / 2),
                      Text(widget.product.description),
                      const SizedBox(height: kDefaultPadding / 2),
                      CounterWithFavBtn(product: widget.product),
                      const SizedBox(height: kDefaultPadding / 2),
                      CommentArea(reviews: productReviews),
                      const SizedBox(height: kDefaultPadding / 2),
                      if (prevOrder.contains(widget.product)) addComment,
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      title: Text(widget.product.title),
      actions: [
        IconButton(
            onPressed: () => Navigator.pushNamed(context, cartRoute),
            icon: const Icon(Icons.shopping_bag))
      ],
    );
  }
}
