import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/Search/Pages/SearchPage.dart';

class ImageSearchResultPage extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  const ImageSearchResultPage({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Résultats de l'image"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Searchpage(products: products),
    );
  }
}
