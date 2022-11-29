import 'package:flutter/material.dart';

import '../supplemental/constants.dart';
import '../supplemental/theme.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double amount = 129.875;
    String name = "First Last",
        addLine = "470 72nd St",
        phone = "646 797 1447",
        city = "Brooklyn",
        state = "New York";
    int zip = 11209;

    var shippingInfo = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(addLine + ", \n" + city + ", " + state),
      ],
    );

    var paymentInfo = Container(
      child: const Text("CARD"),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("CHECK OUT"),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(kDefaultPaddin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: kDefaultPaddin / 8),
              child: Text("Your Information"),
            ),
            shippingInfo,
            const Line(),
            const Text("Payment Information"),
            paymentInfo,
          ],
        ),
      ),
    );
  }
}
