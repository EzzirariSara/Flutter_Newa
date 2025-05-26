import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/Achats/panierCuPage.dart';
import 'package:flutter_application_1/features/Auth/AuthProfilePage.dart';
import 'package:flutter_application_1/features/Auth/pages/auth/login_page.dart';
import 'package:flutter_application_1/features/Promotions/PromotionsPage.dart';
import 'package:flutter_application_1/features/categorie/Categories.dart';
import 'package:flutter_application_1/features/home/pages/Home.dart';
import 'package:flutter_application_1/NewaBottomNavBar.dart';

class Homepage extends StatefulWidget {
  final int initialIndex;

  const Homepage({super.key, this.initialIndex = 0});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onTabSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  Widget _buildPage() {
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
        return LoginPage();

        // return Authprofilepage();
        

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