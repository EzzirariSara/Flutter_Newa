import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/theme/Colors.dart';
import 'package:flutter_application_1/core/widgets/AddToCartBottomSheet.dart';
import 'package:flutter_application_1/features/Products/pages/DetailProduct.dart';
import 'package:flutter_application_1/features/home/HomePage.dart';

class Productcardhorizantale extends StatelessWidget {
  final String imagePath;
  final String productName;
  final String price;
  final String originalPrice;
  final String brand;
  // final String categoryName;


  const Productcardhorizantale({
    Key? key,
    required this.imagePath,
    required this.productName,
    required this.price,
    required this.originalPrice,
    required this.brand,
    // required this.categoryName,

  }) : super(key: key);

  double? safeParseDouble(String value) {
    try {
      String normalizedValue = value.replaceAll(',', '.');
      return double.parse(normalizedValue);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    double? parsedPrice = safeParseDouble(price);
    bool showDiscount = parsedPrice != null && parsedPrice < 100;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailPage(
              imagePath: imagePath,
              productName: productName,
              price: price,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
              child: Container(
                width: 120,
                height: double.infinity,
                color: Colors.white,
                padding: const EdgeInsets.all(10),
                child: Image.asset(imagePath, fit: BoxFit.contain,width: 100,),
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      brand,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      productName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              '$price DHS',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: AppColors.deepBlue,
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (originalPrice != price && originalPrice.isNotEmpty)
                              Text(
                                '$originalPrice DHS',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                          ],
                        ),

                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return AddToCartBottomSheet(
                                  imagePath: imagePath,
                                  productName: productName,
                                  price: price,
                                  showDiscount: parsedPrice != null && parsedPrice < 100,
                                );
                              },
                            );
                          },

                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.deepBlue,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
