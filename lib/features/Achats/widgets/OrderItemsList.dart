import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/Achats/panierCuPage.dart';
import 'package:flutter_application_1/features/Achats/widgets/OrderItemCard.dart';

class OrderItemsList extends StatelessWidget {
  final List<CartItem> items;

  const OrderItemsList({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((item) => OrderItemCard(item: item)).toList(),
    );
  }
}