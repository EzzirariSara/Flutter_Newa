import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/Achats/panierCuPage.dart';
import 'package:flutter_application_1/features/Auth/AuthProfilePage.dart';
import 'package:flutter_application_1/features/Auth/pages/auth/login_page.dart';
import 'package:flutter_application_1/features/Products/pages/DetailHeader.dart';
import 'package:flutter_application_1/NewaBottomNavBar.dart';
import 'package:flutter_application_1/features/Products/pages/ProductGridHorizantale.dart';
import 'package:flutter_application_1/features/Promotions/PromotionsPage.dart';
import 'package:flutter_application_1/features/categorie/Categories.dart';
import 'package:flutter_application_1/features/home/pages/Home.dart';

class Productcategories extends StatefulWidget {
  final String categoryName;

  const Productcategories({
    Key? key,
    required this.categoryName,
  }) : super(key: key);

  @override
  State<Productcategories> createState() => _ProductcategoriesState();
}

class _ProductcategoriesState extends State<Productcategories> {
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
        return const Home();
      case 1:
        return const PromotionsPage();
      case 2:
        return _isCategoriesPageShown ? const CategoriesPage() : _buildProductPage();
      case 3:
        return const Paniercupage();
      case 4:
        return const LoginPage();
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget _buildProductPage() {
    return SingleChildScrollView(
      child: Column(
        children: [
          DetailHeader(),
          ProductGridHorizontal(products: _products, categoryName: widget.categoryName),
          const SizedBox(height: 20),
        ],
      ),
    );
  }


  final List<Map<String, dynamic>> _products = [
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
  ];

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