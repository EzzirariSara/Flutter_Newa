import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double price;
  final int quantity;
  final Function(int) onQuantityChanged;

  const ProductItem({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.quantity,
    required this.onQuantityChanged,
  }) : super(key: key);

@override
Widget build(BuildContext context) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Container(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          "assets/Products/product1.png",
          height: 60,
          width: 60,
          fit: BoxFit.contain,
        ),
      ),
      const SizedBox(width: 8),
      Expanded( 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis, 
            ),
            const SizedBox(height: 4),
            Text(
              '${price.toStringAsFixed(2)} DHS',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove, color: Colors.black),
            onPressed: () {
              if (quantity > 1) onQuantityChanged(quantity - 1);
            },
          ),
          Text(
            '$quantity',
            style: const TextStyle(fontSize: 16),
          ),
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            onPressed: () {
              onQuantityChanged(quantity + 1);
            },
          ),
        ],
      ),
    
    ],
  );
}}

