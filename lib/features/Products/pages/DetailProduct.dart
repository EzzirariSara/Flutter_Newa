import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/Achats/panierCuPage.dart';
import 'package:flutter_application_1/features/Auth/AuthProfilePage.dart';
import 'package:flutter_application_1/features/Promotions/PromotionsPage.dart';
import 'package:flutter_application_1/features/categorie/Categories.dart';
import 'package:flutter_application_1/features/home/pages/BrandsPage.dart';
import 'package:flutter_application_1/features/Products/pages/InfoProducts.dart';
import 'package:flutter_application_1/NewaBottomNavBar.dart';
import 'package:flutter_application_1/features/Products/pages/ProductSimilPage.dart';
import 'package:flutter_application_1/features/home/pages/Home.dart';

class ProductDetailPage extends StatefulWidget {
  final String imagePath;
  final String productName;
  final String price;
  final int initialIndex;

  const ProductDetailPage({
    Key? key,
    required this.imagePath,
    required this.productName,
    required this.price,
    this.initialIndex = 0,
  }) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late int _selectedIndex;
  bool _firstTimeHomeTab = true;  

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onTabSelected(int index) {
    setState(() {
      if (index == 0 && _selectedIndex == 0) {
        if (!_firstTimeHomeTab) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Scaffold(
              body: const Home(),
              bottomNavigationBar: NewaBottomNavBar(
                selectedIndex: 0,
                onTabSelected: _onTabSelected,
              ),
            )),
            (Route<dynamic> route) => false,
          );
          return;
        }
      }
      
      _selectedIndex = index;
      
      if (index != 0) {
        _firstTimeHomeTab = false;
      }
    });
  }

  Widget _buildPage() {
    if (_selectedIndex == 0 && _firstTimeHomeTab) {
      _firstTimeHomeTab = false;
      
      return SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 5),
              InfoProducts(
                imagePath: widget.imagePath,
                productName: widget.productName,
                price: widget.price,
              ),
              const SizedBox(height: 20),
              const ProductSimilPage(),
              const BrandsPage(),
            ],
          ),
        ),
      );
    }

    if (_selectedIndex == 0) {
      return const Home();
    }

    switch (_selectedIndex) {
      case 1:
        return const PromotionsPage();
      case 2:
        return const CategoriesPage();
      case 3:
        return const Paniercupage();
      case 4:
        return const Authprofilepage();
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