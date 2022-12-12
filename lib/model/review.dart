class Review {
  final String commentID;
  final String comment;
  final String userName;
  final String productID;
  final DateTime commentDate;

  Review({
    required this.commentDate,
    required this.productID,
    required this.commentID,
    required this.comment,
    required this.userName,
  });
}
