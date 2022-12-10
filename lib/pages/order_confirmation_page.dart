import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shrine/widgets/order_summary_item.dart';

import '../model/order.dart';
import '../model/product.dart';
import '../supplemental/constants.dart';
import '../supplemental/theme.dart';

class OrderConfirmationWindow extends StatelessWidget {
  final Order order;
  const OrderConfirmationWindow({Key? key, required this.order})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int count = 0;
    for (int c in order.productsAndCount.values) {
      count += c;
    }
    return AlertDialog(
      title: const Text("Order Details"),
      content: SizedBox(
        height: 600,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Your order contains $count items",
                  style: const TextStyle(fontSize: 16)),
            ),
            Container(
              color: kShrinePink25,
              child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding / 2),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: order.productsAndCount.length,
                  itemBuilder: (context, index) {
                    Product p = order.productsAndCount.keys.toList()[index];
                    int count = order.productsAndCount[p] ?? 0;
                    return OrderSummaryItem(product: p, quantity: count);
                  },
                  separatorBuilder: (context, index) {
                    return const Line();
                  },
                ),
              ),
            ),
            const Line(),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total:",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      order.totalOrderCost.toStringAsFixed(2),
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
            const Line(),
            if (order.orderStatus.toLowerCase() == "delivered")
              Text(
                "Order Delivered on " +
                    DateFormat("MMM dd").format(order.orderDate),
              )
          ],
        ),
      ),
    );
  }
}
