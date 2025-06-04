import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/Auth/pages/Adresses/AddressesPage.dart';
import 'package:flutter_application_1/features/Auth/pages/PaymenMethod/PaymentMethodsPage.dart';
import 'package:flutter_application_1/features/Auth/pages/order/OrdersPage.dart';
import 'package:flutter_application_1/features/Auth/pages/retours/RetoursPage.dart';
import 'package:flutter_application_1/features/Auth/widgets/MenuItem.dart';
import 'package:flutter_application_1/features/Auth/pages/ListeDEnvie/FavoriteProductsPage.dart';
class Menusection extends StatelessWidget {
  const Menusection({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: _buildMenuSection(context),
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    return Column(
      children: [
        MenuItem(
          icon: Icons.shopping_bag_outlined,
          title: 'Mes commandes',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const OrdersPage()),
            );
          },
        ),
        MenuItem(
          icon: Icons.assignment_return_outlined,
          title: 'Mes retours',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Retourspage()),
            );
          },
        ),
       MenuItem(
          icon: Icons.location_on_outlined,
          title: 'Mes adresses',
          onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddressesPage()),
          );
        },
        ),
        MenuItem(
          icon: Icons.credit_card_outlined,
          title: 'Mes modes de paiement',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const PaymentMethodsPage()),
            );
          },
        ),
        MenuItem(
          icon: Icons.favorite_border,
          title: 'Ma liste d\'envie',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FavoriteProductsPage()),
            );
          },
        ),      
        // MenuItem(
        //   icon: Icons.settings_outlined,
        //   title: 'Mes préférences',
        //   onTap: _emptyCallback,
        // ),
      ],
    );
  }

  // static void _emptyCallback() {}
}