// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/core/widgets/AddToCartBottomSheet.dart';
// import 'package:flutter_application_1/features/Products/pages/DetailProduct.dart';
// import 'package:flutter_application_1/config/theme/Colors.dart';
// import 'package:flutter_application_1/features/home/HomePage.dart';

// class ProductCard extends StatelessWidget {
//   final String imagePath;
//   final String productName;
//   final String price;
//   final String originalPrice;
//   final String brand;

//   const ProductCard({
//     Key? key,
//     required this.imagePath,
//     required this.productName,
//     required this.price,
//     required this.originalPrice,
//     required this.brand,
//   }) : super(key: key);

//   double? safeParseDouble(String value) {
//     try {
//       String normalizedValue = value.replaceAll(',', '.');
//       return double.parse(normalizedValue);
//     } catch (e) {
//       return null;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final cardWidth = (screenWidth - 48) / 2;
//     double? parsedPrice = safeParseDouble(price);

//     bool showDiscount = parsedPrice != null && parsedPrice < 100;

//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder:
//                 (_) => ProductDetailPage(
//                   imagePath: imagePath,
//                   productName: productName,
//                   price: price,
//                 ),
//           ),
//         );
//       },
//       child: Container(
//         width: cardWidth,
//         height: 240,
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(8),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.1),
//               spreadRadius: 1,
//               blurRadius: 3,
//               offset: const Offset(0, 1),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               height: 130,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(8),
//                   topRight: Radius.circular(8),
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(5),
//                 child: Image.asset(imagePath, fit: BoxFit.contain),
//               ),
//             ),

//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 10,
//                   vertical: 6,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       brand,
//                       style: const TextStyle(
//                         fontSize: 11,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.grey,
//                       ),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 2),

//                     Text(
//                       productName,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.w500,
//                         fontSize: 13,
//                       ),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),

//                     Spacer(),

//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Flexible(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Text(
//                                 '$price DHS',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 14,
//                                   color: AppColors.deepBlue,
//                                 ),
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               if (originalPrice != price &&
//                                   originalPrice.isNotEmpty)
//                                 Text(
//                                   '$originalPrice DHS',
//                                   style: const TextStyle(
//                                     fontSize: 12,
//                                     color: Colors.grey,
//                                     decoration: TextDecoration.lineThrough,
//                                   ),
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                             ],
//                           ),
//                         ),

//                         InkWell(
//                           onTap: () {
//                             showModalBottomSheet(
//                               context: context,
//                               backgroundColor: Colors.transparent,
//                               isScrollControlled: true,
//                               builder: (BuildContext context) {
//                                 return AddToCartBottomSheet(
//                                   imagePath: imagePath,
//                                   productName: productName,
//                                   price: price,
//                                   showDiscount:
//                                       parsedPrice != null && parsedPrice < 100,
//                                 );
//                               },
//                             );
//                           },

//                           child: Container(
//                             padding: const EdgeInsets.all(8),
//                             decoration: BoxDecoration(
//                               color: AppColors.deepBlue,
//                               shape: BoxShape.circle,
//                             ),
//                             child: const Icon(
//                               Icons.shopping_cart,
//                               color: Colors.white,
//                               size: 16,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 5),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/widgets/AddToCartBottomSheet.dart';
import 'package:flutter_application_1/features/Products/pages/DetailProduct.dart';
import 'package:flutter_application_1/config/theme/Colors.dart';
import 'package:flutter_application_1/features/home/HomePage.dart';

class ProductCard extends StatefulWidget {
  final String imagePath;
  final String productName;
  final String price;
  final String originalPrice;
  final String brand;

  const ProductCard({
    Key? key,
    required this.imagePath,
    required this.productName,
    required this.price,
    required this.originalPrice,
    required this.brand,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = false;

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
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = (screenWidth - 48) / 2;
    double? parsedPrice = safeParseDouble(widget.price);

    bool showDiscount = parsedPrice != null && parsedPrice < 100;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailPage(
              imagePath: widget.imagePath,
              productName: widget.productName,
              price: widget.price,
            ),
          ),
        );
      },
      child: Container(
        width: cardWidth,
        height: 240,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 130,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Image.asset(widget.imagePath, fit: BoxFit.contain),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.brand,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          widget.productName,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    '${widget.price} DHS',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: AppColors.deepBlue,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  if (widget.originalPrice != widget.price &&
                                      widget.originalPrice.isNotEmpty)
                                    Text(
                                      '${widget.originalPrice} DHS',
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  isScrollControlled: true,
                                  builder: (BuildContext context) {
                                    return AddToCartBottomSheet(
                                      imagePath: widget.imagePath,
                                      productName: widget.productName,
                                      price: widget.price,
                                      showDiscount:
                                          parsedPrice != null && parsedPrice < 100,
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
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            // Icône favorite positionnée en haut à droite
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      size: 20,
                      color: isFavorite ? Colors.red : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}