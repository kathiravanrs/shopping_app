import 'package:flutter/material.dart';
import 'package:shrine/widgets/order_item.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrderItem("imgUrl", [], DateTime.now(), DateTime.now(), true, "orderID");
  }
}
