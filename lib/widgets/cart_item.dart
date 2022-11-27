import 'package:flutter/material.dart';
import 'package:shrine/model/product.dart';
import 'package:shrine/supplemental/theme.dart';

class CartItem extends StatelessWidget {
  const CartItem({Key? key, required this.product, required this.quantity}) : super(key: key);
  final Product product;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      // child: Column(
      //   // children: [
      //   //   Row(
      //   //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   //     children: <Widget>[
      //   //       SizedBox(
      //   //         width: 75,
      //   //         child: Hero(
      //   //           tag: product.id,
      //   //           child: Image.network(product.imageUrl),
      //   //         ),
      //   //       ),
      //   //       Column(
      //   //         mainAxisAlignment: MainAxisAlignment.end,
      //   //         children: [
      //   //           Row(
      //   //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //   //             children: [
      //   //               Text("Quantity: $quantity"),
      //   //               Text(
      //   //                 "x \$${product.price}",
      //   //               )
      //   //             ],
      //   //           ),
      //   //           Padding(
      //   //             padding: const EdgeInsets.all(kDefaultPaddin / 4),
      //   //             child: Text(
      //   //               product.title,
      //   //               style: const TextStyle(color: kShrineBrown900, fontWeight: FontWeight.bold),
      //   //             ),
      //   //           ),
      //   //         ],
      //   //       ),
      //   //     ],
      //   //   ),
      //   //   Line(),
      //   // ],
      //
      // ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Line(),
          Row(
            key: ValueKey(product.id),
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: () {},
              ),
              Expanded(
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(
                            product.imageUrl,
                            fit: BoxFit.cover,
                            width: 75.0,
                            height: 75.0,
                          ),
                          const SizedBox(width: 4.0),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text('Quantity: $quantity'),
                                    ),
                                    Text('x ${(product.price)}'),
                                  ],
                                ),
                                Text(
                                  product.title,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Line()
        ],
      ),
    );
  }
}
