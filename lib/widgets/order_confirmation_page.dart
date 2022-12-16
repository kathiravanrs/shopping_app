import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shrine/widgets/order_summary_item.dart';

import '../model/order.dart';
import '../model/product.dart';
import '../supplemental/constants.dart';
import '../supplemental/product_methods.dart';
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
        height: 500,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total (Incl. shipping and tax):",
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    order.totalOrderCost.toStringAsFixed(2),
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            const Line(),
            Text(
              "Order Placed on ${DateFormat("MMM dd").format(order.orderDate)}",
            ),
            if (order.orderStatus.toLowerCase() == "delivered")
              Text(
                "Order Delivered on ${DateFormat("MMM dd").format(order.deliveryDate)}",
              )
          ],
        ),
      ),
    );
  }
}

class OrderProcessWindow extends StatefulWidget {
  final Order order;
  const OrderProcessWindow({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderProcessWindow> createState() => _OrderProcessWindowState();
}

class _OrderProcessWindowState extends State<OrderProcessWindow> {
  @override
  Widget build(BuildContext context) {
    int count = 0;
    for (int c in widget.order.productsAndCount.values) {
      count += c;
    }
    return AlertDialog(
      title: const Text("Order Details"),
      content: SizedBox(
        height: 500,
        width: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("This order contains $count items",
                  style: const TextStyle(fontSize: 16)),
            ),
            Container(
              color: kShrinePink25,
              child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding / 2),
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: widget.order.productsAndCount.length,
                  itemBuilder: (context, index) {
                    Product p =
                        widget.order.productsAndCount.keys.toList()[index];
                    int count = widget.order.productsAndCount[p] ?? 0;
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Payment received",
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    widget.order.totalOrderCost.toStringAsFixed(2),
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            const Line(),
            Text(
              "Order Received on ${DateFormat("MMM dd").format(widget.order.orderDate)}",
            ),
            if (widget.order.orderStatus.toLowerCase() == "delivered")
              Text(
                "Order Delivered on ${DateFormat("MMM dd").format(widget.order.deliveryDate)}",
              )
            else
              Text(
                "Delivery by ${DateFormat("MMM dd").format(widget.order.deliveryDate)}",
              ),
            const Line(),
            if (widget.order.orderStatus.toLowerCase() != "delivered")
              TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: kShrinePink300,
                    foregroundColor: kShrineBrown900),
                onPressed: () {
                  setState(
                    () {
                      markOrderDelivered(widget.order);
                      getOrders();
                    },
                  );
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Order marked as delivered!")));
                },
                child: const Text("Mark as Delivered"),
              )
            else
              TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: kShrinePink300,
                    foregroundColor: kShrineBrown900),
                onPressed: () {
                  setState(
                    () {
                      markOrderNotDelivered(widget.order);
                      getOrders();
                    },
                  );

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Order marked as not delivered!")));
                },
                child: const Text("Mark as Not Delivered"),
              )
          ],
        ),
      ),
    );
  }
}
