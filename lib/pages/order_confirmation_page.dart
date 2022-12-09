import 'package:flutter/material.dart';

import '../model/order.dart';
import '../supplemental/constants.dart';
import '../supplemental/theme.dart';
import '../widgets/cart_item.dart';

class OrderConfirmationWindow extends StatelessWidget {
  final Order order;
  const OrderConfirmationWindow({Key? key, required this.order})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Order Details"),
      content: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text("Your cart contains items",
                style: TextStyle(fontSize: 24)),
            const Line(),
            Expanded(
              child: Container(
                color: kShrinePink25,
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: ListView.separated(
                    itemCount: order.productsAndCount.length,
                    itemBuilder: (context, index) {
                      return CartItem(
                        product: order.productsAndCount.keys.toList()[index],
                        quantity: order.productsAndCount[
                                order.productsAndCount.keys.toList()[index]] ??
                            0,
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const Line();
                    },
                  ),
                ),
              ),
            ),
            const Line(),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 175,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total:",
                      style: TextStyle(fontSize: 30),
                    ),
                    Text(
                      order.totalOrderCost.toStringAsFixed(2),
                      style: const TextStyle(fontSize: 30),
                    ),
                  ],
                ),
              ),
            ),
            const Line(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 150,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: kShrinePink50,
                        foregroundColor: kShrineBrown900),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Add More"),
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
