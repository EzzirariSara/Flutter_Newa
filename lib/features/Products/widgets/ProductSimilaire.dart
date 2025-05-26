import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/Products/pages/DetailProduct.dart';

class Productsimilaire extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final double currentPrice;
  final double originalPrice;
  final double rating;
  final int reviewCount;
  final Function()? onTap;

  const Productsimilaire({
    Key? key,
    required this.imageUrl,
    required this.productName,
    required this.currentPrice,
    this.originalPrice = 0,
    this.rating = 0,
    this.reviewCount = 0,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void navigateToProductDetail() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailPage(
            imagePath: imageUrl,
            productName: productName,
            price: currentPrice.toStringAsFixed(2),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: onTap ?? navigateToProductDetail,
      child: Container(
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                // Image cliquable
                GestureDetector(
                  onTap: navigateToProductDetail,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    child: Image.asset(
                      imageUrl,
                      height: 150,
                      fit: BoxFit.contain,
                      width: double.infinity,
                    ),
                  ),
                ),
                // Bouton d'ajout
                Positioned(
                  right: 0,
                  bottom: 8,
                  child: GestureDetector(
                    onTap: navigateToProductDetail,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 0, 0, 0),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ...List.generate(5, (index) {
                        double starValue = index + 1;
                        return Icon(
                          rating >= starValue
                              ? Icons.star
                              : rating >= starValue - 0.5
                                  ? Icons.star_half
                                  : Icons.star_border,
                          size: 16,
                          color: Colors.black,
                        );
                      }),
                      const SizedBox(width: 4),
                      Text(
                        '($reviewCount)',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    productName,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '${currentPrice.toStringAsFixed(0)}\DH',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      if (originalPrice > 0)
                        Text(
                          '${originalPrice.toStringAsFixed(0)}\DH',
                          style: const TextStyle(
                            fontSize: 12,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}