import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/theme/Colors.dart';
import 'package:flutter_application_1/features/ProductBrands/widgets/ProductCard.dart';


class FavoriteProductsPage extends StatefulWidget {
  const FavoriteProductsPage({Key? key}) : super(key: key);

  @override
  State<FavoriteProductsPage> createState() => _FavoriteProductsPageState();
}

class _FavoriteProductsPageState extends State<FavoriteProductsPage> {
  final List<Map<String, dynamic>> allProducts = [
    {
      'imagePath': 'assets/Products/Product1.png',
      'productName': 'Produit 1',
      'price': '80',
      'originalPrice': '100',
      'brand': 'Marque A',
      "isFavorite": true,
    },
    {
      'imagePath': 'assets/Products/Product2.png',
      'productName': 'Produit 2',
      'price': '150',
      'originalPrice': '200',
      'brand': 'Marque B',
      "isFavorite": true,
    },
    {
      'imagePath': 'assets/Products/Product3.png',
      'productName': 'Produit 3',
      'price': '50',
      'originalPrice': '70',
      'brand': 'Marque C',
      "isFavorite": true,
    },
    {
      'imagePath': 'assets/Products/Product4.png',
      'productName': 'Produit 4',
      'price': '120',
      'originalPrice': '150',
      'brand': 'Marque D',
      "isFavorite": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final favoriteProducts = allProducts.where((product) => product['isFavorite'] == true).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Favoris'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black, 
        elevation: 1,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: favoriteProducts.isEmpty
            ? const Center(
                child: Text(
                  'Aucun produit favori pour le moment.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              )
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.75,
                ),
                itemCount: favoriteProducts.length,
                itemBuilder: (context, index) {
                  final product = favoriteProducts[index];
                  return ProductCard(
                    imagePath: product['imagePath'],
                    productName: product['productName'],
                    price: product['price'],
                    originalPrice: product['originalPrice'],
                    brand: product['brand'],
                    Favorie: true,

                  );
                },
              ),
      ),
    );
  }
}
