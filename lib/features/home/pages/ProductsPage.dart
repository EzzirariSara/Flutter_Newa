import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/home/pages/AllProduct.dart';
import 'package:flutter_application_1/features/home/pages/AllProductsPage.dart';
import 'package:flutter_application_1/features/Header/HomeHeader.dart';
import 'package:flutter_application_1/features/home/widgets/ProductCart.dart';
import 'package:flutter_application_1/model/Products.dart';

class Productspage extends StatelessWidget {
  final String title;
  final List<Product> products;

  const Productspage({
    super.key,
    this.title = 'New Items',
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Allproduct(
                        initialIndex: 0,
                        title: title,
                        products: products,
                        showAllProducts: true,
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  minimumSize: Size.zero,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'VOIR PLUS',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 12,
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children:
                  products
                      .map(
                        (product) => ProductCard(
                          imagePath: product.imagePath,
                          productName: product.productName,
                          price: product.price,
                          type: product.type,
                        ),
                      )
                      .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
