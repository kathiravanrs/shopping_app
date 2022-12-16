import 'package:electron_avenue/widgets/process_order_item.dart';
import 'package:flutter/material.dart';

import '../data/product_data.dart';
import '../model/order.dart';
import '../supplemental/constants.dart';
import '../supplemental/product_methods.dart';
import '../supplemental/theme.dart';

class ProcessOrders extends StatelessWidget {
  const ProcessOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Process Orders")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
        child: FutureBuilder(
          future: getOrders(),
          builder: (BuildContext context, AsyncSnapshot<List<Order>> snapshot) {
            Widget receiverOrderList;
            if (snapshot.connectionState == ConnectionState.done) {
              if (orders.isEmpty) {
                receiverOrderList = const Expanded(
                  child: Center(
                    child: Text("You haven't received any orders"),
                  ),
                );
              } else {
                receiverOrderList = Expanded(
                  child: ListView.builder(
                    itemCount: orders.length,
                    itemBuilder: (context, index) {
                      return ProcessOrderItem(order: orders[index]);
                    },
                  ),
                );
              }
            } else {
              receiverOrderList =
                  const Center(child: CircularProgressIndicator());
            }
            return Column(
              children: [
                const SizedBox(height: kDefaultPadding),
                const Text("RECEIVED ORDERS"),
                const Line(),
                receiverOrderList,
              ],
            );
          },
        ),
      ),
    );
  }
}
