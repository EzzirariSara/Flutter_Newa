import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/theme/Colors.dart';
import 'package:flutter_application_1/features/Auth/models/order_model.dart';
import 'package:intl/intl.dart';

class OrderDetailsPage extends StatelessWidget {
  final Order order;
  final DateFormat dateFormatter = DateFormat('dd/MM/yyyy');
  
  OrderDetailsPage({Key? key, required this.order}) : super(key: key);

  Color _getStatusColor(String status) {
    switch (status) {
      case 'En cours de livraison':
        return Colors.blue;
      case 'Livré':
        return Colors.green;
      case 'Annulé':
        return Colors.red;
      case 'Expédié':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Commande #${order.id}',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatusCard(),
            const SizedBox(height: 20),
            _buildOrderInfoSection(),
            const SizedBox(height: 20),
            _buildProductsSection(),
            const SizedBox(height: 20),
            _buildTotalSection(),
            const SizedBox(height: 20),
            _buildDeliverySection(),
            const SizedBox(height: 30),
            // if (order.status != 'Annulé' && order.status != 'Livré')
              // _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    final steps = ['Commandé', 'Expédié', 'En cours de livraison', 'Livré'];
    final currentStep = steps.contains(order.status) 
        ? steps.indexOf(order.status) + 1 
        : order.status == 'Annulé' ? -1 : 0;

    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Statut de la commande',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getStatusColor(order.status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    order.status,
                    style: TextStyle(
                      color: _getStatusColor(order.status),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (currentStep >= 0) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  steps.length,
                  (index) {
                    final isCompleted = index < currentStep;
                    final isCurrent = index == currentStep - 1;
                    
                    return Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isCompleted || isCurrent 
                                  ? AppColors.deepBlue 
                                  : Colors.grey.shade300,
                            ),
                            child: Icon(
                              _getStepIcon(index),
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            steps[index],
                            style: TextStyle(
                              fontSize: 12,
                              color: isCompleted || isCurrent 
                                  ? AppColors.deepBlue 
                                  : Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              LinearProgressIndicator(
                value: currentStep / steps.length,
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.deepBlue),
                minHeight: 5,
                borderRadius: BorderRadius.circular(10),
              ),
            ] else if (order.status == 'Annulé') ...[
              Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.cancel,
                      color: Colors.red,
                      size: 50,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Commande annulée',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  IconData _getStepIcon(int step) {
    switch (step) {
      case 0:
        return Icons.shopping_cart;
      case 1:
        return Icons.inventory_2;
      case 2:
        return Icons.local_shipping;
      case 3:
        return Icons.check_circle;
      default:
        return Icons.circle;
    }
  }

  Widget _buildOrderInfoSection() {
    return Card(
      color: Colors.white,

      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Informations de commande',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow(
              icon: Icons.receipt,
              title: 'Numéro de commande',
              value: order.id,
            ),
            const Divider(height: 16),
            _buildInfoRow(
              icon: Icons.calendar_today,
              title: 'Date de commande',
              value: dateFormatter.format(order.date),
            ),
            const Divider(height: 16),
            _buildInfoRow(
              icon: Icons.credit_card,
              title: 'Méthode de paiement',
              value: 'Carte bancaire **** 5678',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProductsSection() {
    return Card(
      color: Colors.white,

      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Produits',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '${order.items.length} article${order.items.length > 1 ? 's' : ''}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...order.items.map((item) => _buildProductItem(item)).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductItem(OrderItem item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Image.asset(
                item.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.broken_image,
                    color: Colors.white,
                    size: 30,
                  );
                },
              )
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Qté: ${item.quantity}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${(item.price * item.quantity).toStringAsFixed(2)} Dh',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalSection() {
    final subtotal = order.items.fold<double>(
      0.0,
      (total, item) => total + (item.price * item.quantity),
    );
    final shipping = 25.0;
    final discount = subtotal * 0.05;
    final total = subtotal + shipping - discount;

    return Card(
      color: Colors.white,

      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Résumé de la commande',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            _buildPriceRow('Sous-total', subtotal),
            const SizedBox(height: 8),
            _buildPriceRow('Frais de livraison', shipping),
            const SizedBox(height: 8),
            _buildPriceRow('Réduction', -discount),
            const Divider(height: 24),
            _buildPriceRow(
              'Total',
              total,
              isBold: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceRow(String title, double amount, {bool isBold = false}) {
    final TextStyle style = isBold
        ? const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          )
        : TextStyle(
            color: amount < 0 ? Colors.green : Colors.grey[800],
            fontSize: 14,
          );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: style),
        Text(
          amount < 0
              ? '-${amount.abs().toStringAsFixed(2)} Dh'
              : '${amount.toStringAsFixed(2)} Dh',
          style: style,
        ),
      ],
    );
  }

  Widget _buildDeliverySection() {
    return Card(
      color: Colors.white,

      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Livraison',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow(
              icon: Icons.location_on,
              title: 'Adresse de livraison',
              value: order.deliveryAddress,
            ),
            const Divider(height: 16),
            _buildInfoRow(
              icon: Icons.local_shipping,
              title: 'Numéro de suivi',
              value: order.trackingNumber,
            ),
            if (order.status != 'Annulé') ...[
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.track_changes),
                label: const Text('Suivre ma livraison'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.deepBlue,
                  side: const BorderSide(color: AppColors.deepBlue),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: const Size(double.infinity, 0),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}