import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/Achats/panierCuPage.dart';
import 'package:flutter_application_1/features/Auth/AuthProfilePage.dart';
import 'package:flutter_application_1/features/Brands/pages/BrandsScreen.dart';
import 'package:flutter_application_1/features/ProductBrands/pages/ProductGrid.dart';
import 'package:flutter_application_1/features/Products/pages/DetailHeader.dart';
import 'package:flutter_application_1/NewaBottomNavBar.dart';
import 'package:flutter_application_1/features/Promotions/PromotionsPage.dart';
import 'package:flutter_application_1/features/categorie/Categories.dart';
import 'package:flutter_application_1/features/home/pages/Home.dart';

class Brandcategorie extends StatefulWidget {
  final String subcategoryName;
  final String subcategoryImage;
  final List<dynamic> brands;

  const Brandcategorie({
    super.key,
    required this.subcategoryName,
    required this.subcategoryImage,
    required this.brands,
  });

  @override
  State<Brandcategorie> createState() => _BrandcategorieState();
}

class _BrandcategorieState extends State<Brandcategorie> {
  int _selectedIndex = 2;
  bool _isCategoriesPageShown = false;

  void _onTabSelected(int index) {
    setState(() {
      if (_selectedIndex == 2 && index == 2) {
        _isCategoriesPageShown = !_isCategoriesPageShown;
      } else {
        _selectedIndex = index;
        _isCategoriesPageShown = false; 
      }
    });
  }

  Widget _buildPage() {
    switch (_selectedIndex) {
      case 0:
        return Home();
      case 1:
        return Stack(children: [PromotionsPage(), const SizedBox(height: 24)]);
      case 2:
        if (_isCategoriesPageShown) {
          return CategoriesPage();
        } else {
          return SingleChildScrollView(
              child: Column(
                children: [
                  DetailHeader(),
                  // const SizedBox(height: 8),
                  BrandsScreen(
                    subcategoryName: widget.subcategoryName,
                    subcategoryImage: widget.subcategoryImage,
                    brands: widget.brands,
                  ),
                  ProductGrid(
                    products: [
                      {
                        'brand': 'CERAVE',
                        "productName": "PAYOT Crème",
                        "imagePath": "assets/Products/Product4.png",
                        "price": 35.0,
                        'originalPrice': 35.0,
                      },
                      {
                        'brand': 'CERAVE',
                        "productName": "ANIAN Lotion",
                        "imagePath": "assets/Products/Product5.png",
                        "price": 15.0,
                        'originalPrice': 35.0,
                      },
                      {
                        'brand': 'CERAVE',
                        "productName": "PAYOT Crème",
                        "imagePath": "assets/Products/Product6.png",
                        "price": 35.0,
                        'originalPrice': 35.0,
                      },
                      {
                        'brand': 'CERAVE',
                        "productName": "ANIAN Lotion",
                        "imagePath": "assets/Products/Product7.png",
                        "price": 15.0,
                        'originalPrice': 35.0,
                      },
                      {
                        'brand': 'CERAVE',
                        "productName": "DOLOGEL Gel Apaisant",
                        "imagePath": "assets/Products/Product1.png",
                        "price": 30.0,
                        'originalPrice': 35.0,
                      },
                      {
                        'brand': 'CERAVE',
                        "productName": "CERAVE Hydratant",
                        "imagePath": "assets/Products/Product2.png",
                        "price": 25.0,
                        'originalPrice': 35.0,
                      },
                      {
                        'brand': 'CERAVE',
                        "productName": "PHYSIODOSE Solution",
                        "imagePath": "assets/Products/Product3.png",
                        "price": 20.0,
                        'originalPrice': 35.0,
                      },
                      {
                        'brand': 'CERAVE',
                        "productName": "PAYOT Crème",
                        "imagePath": "assets/Products/Product4.png",
                        "price": 35.0,
                        'originalPrice': 35.0,
                      },
                      {
                        'brand': 'CERAVE',
                        "productName": "ANIAN Lotion",
                        "imagePath": "assets/Products/Product5.png",
                        "price": 15.0,
                        'originalPrice': 35.0,
                      },
                    ],
                  ),
                ],
            ),
          );
        }
      case 3:
        return Paniercupage();
      case 4:
        return Authprofilepage();
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildPage(),
      bottomNavigationBar: NewaBottomNavBar(
        selectedIndex: _selectedIndex,
        onTabSelected: _onTabSelected,
      ),
    );
  }
}