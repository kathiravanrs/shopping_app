import 'package:flutter/material.dart';

import '../supplemental/constants.dart';
import '../supplemental/theme.dart';
import '../supplemental/user_details.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var shippingInfo = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          firstName,
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
