import 'package:flutter/material.dart';

import '../../supplemental/constants.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var orders = Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPaddin),
      child: Column(
        children: [
          const TextField(),
          const Center(child: Text("Orders")),
        ],
      ),
    );

    return orders;
  }
}
