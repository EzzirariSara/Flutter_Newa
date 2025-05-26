// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/features/Brands/ProductsBrand.dart';

// class BrandsList extends StatelessWidget {
//   final List<dynamic> brands;

//   const BrandsList({
//     Key? key,
//     required this.brands,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     if (brands.isEmpty) {
//       return const Center(
//         // child: Padding(
//         //   padding: EdgeInsets.all(24.0),
//         //   child: Text(
//         //     "Aucune marque disponible.",
//         //     style: TextStyle(color: Colors.grey),
//         //   ),
//         // ),
//       );
//     }

//     return SizedBox(
//       height: 100, 
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         padding: const EdgeInsets.symmetric(horizontal: 19),
//         itemCount: brands.length,
//         itemBuilder: (context, index) {
//           final brand = brands[index];
//           return GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => Productsbrand(
//                     brandName: brand['name'],
//                     brandImage: brand['image'],
//                     products: brand['products'] ?? [],
//                   ),
//                 ),
//               );
//             },
//             child: Padding(
//               padding: const EdgeInsets.only(right: 16),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.min, 
//                 children: [
//                   CircleAvatar(
//                     radius: 50, 
//                     backgroundColor: Colors.grey.shade200,
//                     child: Padding(
//                       padding: const EdgeInsets.all(8),
//                       child: SizedBox(
//                         width: 60, 
//                         height: 60,
//                         child: Image.asset(
//                           brand['image'],
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                     ),

//                   ),
//                   const SizedBox(height: 4), 
//                   Text(
//                     brand['name'],
//                     textAlign: TextAlign.center,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 10, 
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/Brands/ProductsBrand.dart';

class BrandsList extends StatelessWidget {
  final List<dynamic> brands;

  const BrandsList({
    Key? key,
    required this.brands,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (brands.isEmpty) {
      // return const Center(
      //   child: Padding(
      //     padding: EdgeInsets.all(24.0),
      //     child: Text(
      //       "Aucune marque disponible.",
      //       style: TextStyle(color: Colors.grey),
      //     ),
      //   ),
      // );
    }

    return SizedBox(
      height: 100, 
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 19),
        itemCount: brands.length,
        itemBuilder: (context, index) {
          final brand = brands[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Productsbrand(
                    brandName: brand['name'],
                    brandImage: brand['image'],
                    products: brand['products'] ?? [],
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    radius: 35, 
                    backgroundColor: Colors.grey.shade200,
                    child: ClipOval(
                      child: Image.asset(
                        brand['image'],
                        fit: BoxFit.cover, 
                        width: 60, 
                        height: 60,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4), 
                  Text(
                    brand['name'],
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}