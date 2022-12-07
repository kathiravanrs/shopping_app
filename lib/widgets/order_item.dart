import 'package:flutter/material.dart';

import '../model/product.dart';

class OrderItem extends StatelessWidget {
  final String imgUrl;
  final List<Product> items;
  final DateTime orderDate;
  final DateTime deliveryTime;
  final bool isDelivered;
  final String orderID;

  const OrderItem(
      this.imgUrl, this.items, this.orderDate, this.deliveryTime, this.isDelivered, this.orderID,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: [],
    ));
  }
}
