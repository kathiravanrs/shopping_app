import 'package:electron_avenue/data/product_data.dart';
import 'package:electron_avenue/supplemental/product_methods.dart';
import 'package:electron_avenue/supplemental/theme.dart';
import 'package:electron_avenue/widgets/order_item.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../model/order.dart';
import '../../supplemental/constants.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(orders);
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
      child: FutureBuilder(
        future: getOrders(),
        builder: (BuildContext context, AsyncSnapshot<List<Order>> snapshot) {
          Widget widget;
          if (snapshot.connectionState == ConnectionState.done) {
            if (orders.isEmpty) {
              widget = const Expanded(
                child: Center(
                  child: Text("You haven't ordered anything"),
                ),
              );
            } else {
              orders.sort((a, b) => a.orderDate.compareTo(b.orderDate));
              widget = Expanded(
                child: ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    return OrderItem(order: orders[index]);
                  },
                ),
              );
            }
          } else {
            widget = const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              const SizedBox(height: kDefaultPadding),
              const Text("PREVIOUS ORDERS"),
              const Line(),
              widget,
            ],
          );
        },
      ),
    );
  }
}
