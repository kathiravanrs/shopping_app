import 'package:flutter/material.dart';
import 'package:shrine/model/product.dart';

import '../pages/details_page.dart';

class CartItem extends StatefulWidget {
  const CartItem({Key? key, required this.product, required this.quantity})
      : super(key: key);
  final Product product;
  final int quantity;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(
              product: widget.product,
            ),
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            key: ValueKey(widget.product.toString()),
            children: [
              Expanded(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(widget.product.imageUrl,
                            fit: BoxFit.cover,
                            width: 75.0,
                            height: 75.0, errorBuilder: (ctx, obj, trc) {
                          return const SizedBox(
                              height: 75,
                              width: 75,
                              child: Text("Image coming soon"));
                        }),
                        const SizedBox(width: 4.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.product.title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text('Quantity: ${widget.quantity}'),
                                  ),
                                  Text('x ${(widget.product.price)}'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
