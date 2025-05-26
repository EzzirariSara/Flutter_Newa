import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/Brands/widgets/brandList.dart';

class BrandsScreen extends StatelessWidget {
  final String subcategoryName;
  final String subcategoryImage;
  final List<dynamic> brands;

  const BrandsScreen({
    Key? key,
    required this.subcategoryName,
    required this.subcategoryImage,
    required this.brands,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
            Navigator.pop(context);
            },
       ),
        BrandsList(brands: brands),
      ],
    );
  }
}