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
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          kDefaultPadding / 4, kDefaultPadding / 8, kDefaultPadding / 4, 0),
      child: GestureDetector(
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
                              decoration: BoxDecoration(border: Border.all(color: kShrinePink400)),
                              child: Image.network(
                                products[3].imageUrl,
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
                                    order.products.keys.toList()[0].title.toUpperCase() +
                                        " AND ${order.products.length} OTHER ITEMS",
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    children: [
                                      const Expanded(
                                        child: Text('Order placed: '),
                                      ),
                                      Text(DateFormat("MMM dd").format(order.orderDate)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Expanded(
                                        child: Text('Delivered on: '),
                                      ),
                                      Text(DateFormat("MMM dd").format(order.deliveryDate)),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  const Center(
                                    child: Text(
                                      "Tap for more info",
                                      style: TextStyle(fontSize: 8),
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
      ),
    );
  }
}
