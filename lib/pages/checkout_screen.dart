import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shrine/data/product_data.dart';
import 'package:shrine/supplemental/constants.dart';

import '../data/user_details.dart';
import '../supplemental/product_methods.dart';
import 'checkout_page.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderConfirmWidget = AlertDialog(
      title: const Center(child: Text("Order Placed Successfully")),
      content: SizedBox(
        height: 180,
        width: 300,
        child: Column(
          children: [
            LottieBuilder.asset(
              "assets/images/orderConfirmed.json",
              repeat: false,
            ),
          ],
        ),
      ),
    );

    final List<PriceItem> priceItems = [
      PriceItem(name: 'Subtotal', quantity: 1, totalPriceCents: 5200),
      PriceItem(name: 'Shipping', quantity: 1, totalPriceCents: 8599),
      PriceItem(name: 'Tax', quantity: 1, totalPriceCents: 2499),
    ];

    return Scaffold(
      body: CheckoutPage(
        priceItems: priceItems,
        payToName: '',
        displayNativePay: false,
        onCardPay: (results) {
          placeOrder(results, selectedAddress);

          Navigator.pushNamedAndRemoveUntil(
              context, homePageRoute, (route) => false);
          showDialog(
              context: context,
              builder: (context) {
                return orderConfirmWidget;
              });
        },
        onBack: () => Navigator.of(context).pop(),
        initEmail: email,
        initBuyerName: "$firstName $lastName",
        initPhone: phone,
        totalPrice: total,
      ),
    );
  }
}
