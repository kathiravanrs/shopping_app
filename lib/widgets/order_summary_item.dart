import 'package:flutter/material.dart';
import 'package:shrine/model/product.dart';

import '../pages/details_page.dart';

class OrderSummaryItem extends StatefulWidget {
  const OrderSummaryItem(
      {Key? key, required this.product, required this.quantity})
      : super(key: key);
  final Product product;
  final int quantity;

  @override
  State<OrderSummaryItem> createState() => _OrderSummaryItemState();
}

class _OrderSummaryItemState extends State<OrderSummaryItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          key: ValueKey(widget.product.toString()),
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        widget.product.imageUrl,
                        fit: BoxFit.cover,
                        width: 35.0,
                        height: 35.0,
                      ),
                      const SizedBox(width: 4.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.product.title,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Quantity: ${widget.quantity}',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ),
                                Text(
                                  'x ${(widget.product.price)}',
                                  style: const TextStyle(fontSize: 12),
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
          ],
        ),
      ],
    );
  }
}
