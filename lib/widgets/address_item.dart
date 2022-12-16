import 'package:electron_avenue/supplemental/constants.dart';
import 'package:flutter/material.dart';

import '../model/address.dart';

class AddressItem extends StatelessWidget {
  final bool isSelected;
  final Address address;
  const AddressItem({required this.isSelected, required this.address, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var bgColor = kElectronPink25;
    if (isSelected) bgColor = kElectronPink100;
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding / 4),
      child: Container(
        padding: const EdgeInsets.all(kDefaultPadding / 4),
        color: bgColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${address.firstName} ${address.lastName}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              address.streetAddress,
              style: const TextStyle(fontSize: 12),
            ),
            Text(
              "${address.city}, ${address.state}",
              style: const TextStyle(fontSize: 12),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "${address.zip}",
                    style: const TextStyle(fontSize: 12),
                  ),
                ),
                if (isSelected)
                  const Text(
                    "SELECTED",
                    style: TextStyle(fontSize: 8),
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
