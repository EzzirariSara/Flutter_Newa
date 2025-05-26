import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/Auth/pages/order/OrdersPage.dart';
import 'package:flutter_application_1/features/Auth/widgets/MenuItem.dart';

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
        const MenuItem(
          icon: Icons.assignment_return_outlined,
          title: 'Mes retours',
          onTap: _emptyCallback,
        ),
        const MenuItem(
          icon: Icons.local_offer_outlined,
          title: 'Mes coupons',
          onTap: _emptyCallback,
        ),
        const MenuItem(
          icon: Icons.location_on_outlined,
          title: 'Mes adresses',
          onTap: _emptyCallback,
        ),
        const MenuItem(
          icon: Icons.credit_card_outlined,
          title: 'Mes mode de paiement',
          onTap: _emptyCallback,
        ),
        const MenuItem(
          icon: Icons.favorite_border,
          title: 'Ma liste d\'envie',
          onTap: _emptyCallback,
        ),
        const MenuItem(
          icon: Icons.settings_outlined,
          title: 'Mes préférences',
          onTap: _emptyCallback,
        ),
      ],
    );
  }

  static void _emptyCallback() {}
}