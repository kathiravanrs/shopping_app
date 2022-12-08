import 'package:flutter/material.dart';
import 'package:shrine/data/product_data.dart';
import 'package:shrine/model/order.dart';
import 'package:shrine/widgets/order_item.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Order order = Order(
        totalOrderCost: 500,
        deliveryAddress: "470 72nd St",
        orderDate: DateTime.now(),
        deliveryDate: DateTime.now(),
        buyer: "Kathiravan Sekar",
        orderStatus: "Delivered",
        orderID: "OrderID",
        productsAndCount: cartItems,
        cardUsed: 'xxxx xxxx xxxx 1234');

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        OrderItem(order: order),
        OrderItem(order: order),
      ],
    );
  }
}
