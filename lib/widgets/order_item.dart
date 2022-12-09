import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shrine/data/product_data.dart';
import 'package:shrine/supplemental/constants.dart';

import '../model/order.dart';

class OrderItem extends StatelessWidget {
  final Order order;

  const OrderItem({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String orderTitle =
        order.productsAndCount.keys.toList().first.title.toUpperCase();

    int count = 0;
    for (int i in order.productsAndCount.values) count += i;
    if (count > 1)
      orderTitle =
          orderTitle + " AND " + (count - 1).toString() + " OTHER ITEMS";

    return GestureDetector(
      onTap: () {},
      child: Card(
        elevation: 2,
        color: kShrinePink25,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: kShrinePink400)),
                            child: Image.network(
                              order.productsAndCount.keys
                                  .toList()
                                  .first
                                  .imageUrl,
                              fit: BoxFit.cover,
                              width: 75.0,
                              height: 75.0,
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  orderTitle,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Text('Ordered on: '),
                                    ),
                                    Text(DateFormat("MMM dd")
                                        .format(order.orderDate)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Expanded(
                                      child: Text('Delivered on: '),
                                    ),
                                    Text(DateFormat("MMM dd")
                                        .format(order.deliveryDate)),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Center(
                                  child: Text(
                                    "Total: ${order.totalOrderCost.toStringAsFixed(2)}",
                                    style: const TextStyle(
                                        fontSize: 8,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
