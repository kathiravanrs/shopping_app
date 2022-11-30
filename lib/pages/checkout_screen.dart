import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../supplemental/user_details.dart';
import 'checkout_page.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<PriceItem> _priceItems = [
      PriceItem(name: 'Subtotal', quantity: 1, totalPriceCents: 5200),
      PriceItem(name: 'Shipping', quantity: 1, totalPriceCents: 8599),
      PriceItem(name: 'Tax', quantity: 1, totalPriceCents: 2499),
    ];

    return Scaffold(
      body: CheckoutPage(
        priceItems: _priceItems,
        payToName: '',
        displayNativePay: false,
        onCardPay: (results) {
          if (kDebugMode) {
            print('Credit card form submitted with results: $results');
          }
        },
        onBack: () => Navigator.of(context).pop(),
        initEmail: email,
        initBuyerName: firstName + " " + lastName,
        initPhone: phone,
      ),
    );
  }
}