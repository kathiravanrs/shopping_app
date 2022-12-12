import 'package:flutter/material.dart';

import '../model/review.dart';
import 'comment_tile.dart';

class CommentArea extends StatelessWidget {
  final List<Review> reviews;

  const CommentArea({required this.reviews, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (reviews.isEmpty) {
      return const Text("No Reviews Yet!");
    }
    return Container(
      height: 200,
      decoration: BoxDecoration(border: Border.all()),
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (ctx, index) => CommentTile(
            comment: reviews[index].comment, user: reviews[index].userName),
        itemCount: reviews.length,
      ),
    );
  }
}
