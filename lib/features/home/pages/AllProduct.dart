import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/Achats/panierCuPage.dart';
import 'package:flutter_application_1/features/Auth/AuthProfilePage.dart';
import 'package:flutter_application_1/features/Promotions/PromotionsPage.dart';
import 'package:flutter_application_1/features/categorie/Categories.dart';
import 'package:flutter_application_1/features/home/pages/AllProductsPage.dart';
import 'package:flutter_application_1/features/home/pages/Home.dart';
import 'package:flutter_application_1/NewaBottomNavBar.dart';
import 'package:flutter_application_1/model/Products.dart';

class Allproduct extends StatefulWidget {
  final int initialIndex;
  final String? title;
  final List<Product>? products;
  final bool showAllProducts;  

  const Allproduct({
    super.key, 
    this.initialIndex = 0,
    this.title,
    this.products,
    this.showAllProducts = false, 
  });

  @override
  State<Allproduct> createState() => _AllproductState();
}

class _AllproductState extends State<Allproduct> {
  late int _selectedIndex;
  late bool _showAllProducts;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
    _showAllProducts = widget.showAllProducts;
  }

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
      _showAllProducts = false;
    });
  }

  Widget _buildPage() {
    if (_selectedIndex == 0 && _showAllProducts && widget.title != null && widget.products != null) {
      return AllProductsPage(
        title: widget.title!,
        products: widget.products!,
      );
    }

    switch (_selectedIndex) {
      case 0:
        return Home();
      case 1:
        return PromotionsPage();
      case 2:
        return CategoriesPage(); 
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