import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shrine/data/product_data.dart';
import 'package:shrine/supplemental/product_methods.dart';
import 'package:shrine/widgets/order_item.dart';

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
            print(orders);
            widget = ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return OrderItem(order: orders[index]);
              },
            );
          } else {
            widget = const Center(child: CircularProgressIndicator());
          }
          return widget;
        },
      ),
    );
  }
}
