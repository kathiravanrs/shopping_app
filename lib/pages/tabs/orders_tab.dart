import 'package:flutter/material.dart';
import 'package:shrine/data/product_data.dart';
import 'package:shrine/model/order.dart';
import 'package:shrine/widgets/order_item.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Order order = Order(
        address: "470 72nd St",
        orderDate: DateTime.now(),
        deliveryDate: DateTime.now(),
        name: "Kathiravan Sekar",
        isDelivered: true,
        orderID: "OrderID",
        products: cartItems);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        OrderItem(order: order),
        OrderItem(order: order),
      ],
    );
  }
}
