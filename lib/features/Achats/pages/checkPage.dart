// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/features/Achats/panierCuPage.dart';
// import 'package:flutter_application_1/features/Auth/AuthProfilePage.dart';
// import 'package:flutter_application_1/features/Promotions/PromotionsPage.dart';
// import 'package:flutter_application_1/features/categorie/Categories.dart';
// import 'package:flutter_application_1/features/home/pages/Home.dart';
// import 'package:flutter_application_1/NewaBottomNavBar.dart';

// class Checkpage extends StatefulWidget {
//   const Checkpage({super.key});

//   @override
//   State<Checkpage> createState() => _CheckpageState();
// }

// class _CheckpageState extends State<Checkpage> {
//   int _selectedIndex = 0;

//   void _onTabSelected(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   Widget _buildPage() {
//     switch (_selectedIndex) {
//       case 0:
//          return Home();
//       case 1:
//         return PromotionsPage();
//       case 2:
//         return CategoriesPage();

//       case 3:
//         return Paniercupage();

//       case 4:
//         return Authprofilepage();

//       default:
//         return const SizedBox.shrink();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: _buildPage(),
//       bottomNavigationBar: NewaBottomNavBar(
//         selectedIndex: _selectedIndex,
//         onTabSelected: _onTabSelected,
//       ),
//     );
//   }
// }
