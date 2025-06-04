import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/Achats/panierCuPage.dart';
import 'package:flutter_application_1/features/Auth/AuthProfilePage.dart';
import 'package:flutter_application_1/features/ProductBrands/pages/ProductGrid.dart';
import 'package:flutter_application_1/features/Header/DetailHeader.dart';
import 'package:flutter_application_1/NewaBottomNavBar.dart';
import 'package:flutter_application_1/features/Promotions/PromotionsPage.dart';
import 'package:flutter_application_1/features/categorie/Categories.dart';
import 'package:flutter_application_1/features/home/pages/Home.dart';

class Productsbrand extends StatefulWidget {
  final String brandName;
  final String brandImage;
  final List<dynamic> products;

  const Productsbrand({
    super.key,
    required this.brandName,
    required this.brandImage,
    required this.products,
  });

  @override
  State<Productsbrand> createState() => _ProductsbrandState();
}

class _ProductsbrandState extends State<Productsbrand> {
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

  List<Map<String, dynamic>> _getProducts() {
    return widget.products.map<Map<String, dynamic>>((product) {
      return Map<String, dynamic>.from(product);
    }).toList();
  }

  Widget _buildPage() {
    switch (_selectedIndex) {
      case 0:
        return Home();
      case 1:
        return PromotionsPage();
      case 2:
        if (_isCategoriesPageShown) {
          return CategoriesPage();
        } else {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  DetailHeader(),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  _buildBrandDetailContent(),
                ],
              ),
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

  Widget _buildBrandDetailContent() {
    final products = _getProducts();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(right: 20),
          color: const Color.fromARGB(255, 255, 255, 255),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 35, 
                backgroundColor: Colors.grey.shade200, 
                child: ClipOval(
                  child: Image.asset(
                    width: 60, 
                    height: 60,
                    widget.brandImage,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 4),
              Text(
                '${widget.brandName}',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF243B6A),
                ),
              ),
            ],
          ),
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
    );
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