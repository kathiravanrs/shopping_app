import 'package:flutter/material.dart';
import 'package:shrine/model/product.dart';

class CartItem extends StatefulWidget {
  CartItem({Key? key, required this.product, required this.quantity}) : super(key: key);
  final Product product;
  int quantity;

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            key: ValueKey(widget.product.id),
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: () {
                  setState(() {
                    if (widget.quantity > 0) widget.quantity--;
                  });
                },
              ),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          widget.product.imageUrl,
                          fit: BoxFit.cover,
                          width: 75.0,
                          height: 75.0,
                        ),
                        const SizedBox(width: 4.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  widget.product.title,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(height: 10),
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
              IconButton(
                icon: const Icon(Icons.add_circle_outline),
                onPressed: () {
                  setState(() {
                    widget.quantity++;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
