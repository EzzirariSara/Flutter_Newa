import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/Achats/panierCuPage.dart';
import 'package:flutter_application_1/features/Achats/widgets/PriceRow.dart';
class OrderSummary extends StatelessWidget {
  final List<CartItem> items;
  final double deliveryFee;
  final double total;

  const OrderSummary({
    Key? key,
    required this.items,
    required this.deliveryFee,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final subtotal = items.fold(
      0.0, 
      (sum, item) => sum + (item.price * item.quantity)
    );
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          PriceRow(label: 'Sous-total', value: '${subtotal.toStringAsFixed(2)} DH'),
          const SizedBox(height: 8),
          PriceRow(label: 'Frais de livraison', value: '${deliveryFee.toStringAsFixed(2)} DH'),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(),
          ),
          PriceRow(
            label: 'Total', 
            value: '${total.toStringAsFixed(2)} DH',
            isBold: true,
          ),
        ],
      ),
    );
  }
}