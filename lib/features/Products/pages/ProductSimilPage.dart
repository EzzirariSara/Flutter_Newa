import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/Products/widgets/ProductSimilaire.dart';

class ProductSimilPage extends StatelessWidget {
  const ProductSimilPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> similarProducts = [
      {
        'imageUrl': 'assets/Products/Product1.png',
        'productName': 'Wooden chair',
        'currentPrice': 35,
        'originalPrice': 45,
        'rating': 4.5,
        'reviewCount': 49,
      },
      {
        'imageUrl': 'assets/Products/Product2.png',
        'productName': 'Wooden chair',
        'currentPrice': 35,
        'originalPrice': 45,
        'rating': 4.5,
        'reviewCount': 49,
      },
      {
        'imageUrl': 'assets/Products/Product3.png',
        'productName': 'Wooden chair',
        'currentPrice': 35,
        'originalPrice': 0,
        'rating': 5.0,
        'reviewCount': 0,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Produits similaires',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // TextButton(
              //   onPressed: () {
                 
              //   },
              //   child: const Text(
              //     'Voir plus',
              //     style: TextStyle(
              //       color: Colors.grey,
              //       fontSize: 14,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
        SizedBox(
          height: 270,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: similarProducts.length,
            itemBuilder: (context, index) {
              final product = similarProducts[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Productsimilaire(
                  imageUrl: product['imageUrl'],
                  productName: product['productName'],
                  currentPrice: product['currentPrice'].toDouble(),
                  originalPrice: product['originalPrice'].toDouble(),
                  rating: product['rating'].toDouble(),
                  reviewCount: product['reviewCount'],
                  onTap: () {
                    print('Produit sélectionné: ${product['productName']}');
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
