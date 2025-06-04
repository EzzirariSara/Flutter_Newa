import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/theme/Colors.dart';

class Retourspage extends StatelessWidget {
  const Retourspage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> returns = [
      {
        'orderNumber': '12345',
        'status': 'En cours de traitement',
        'productName': 'DOLOGEL Gel Apaisant',
        'returnDate': '15 Mai 2025',
        'refundAmount': '129.99 DH',
        'reason': 'Taille incorrecte',
        'trackingNumber': 'FR123456789',
        'estimatedRefund': '5-7 jours ouvrables',
      },
      {
        'orderNumber': '67890',
        'status': 'Retour accepté',
        'productName': 'ANIAN Lotion',
        'returnDate': '10 Mai 2025',
        'refundAmount': '149.99 DH',
        'reason': 'Produit défectueux',
        'trackingNumber': 'FR987654321',
        'estimatedRefund': 'Remboursé le 12 Mai 2025',
      },
      {
        'orderNumber': '11223',
        'status': 'Retour refusé',
        'productName': 'PAYOT Crème',
        'returnDate': '5 Mai 2025',
        'refundAmount': '89.99 DH',
        'reason': 'Délai de retour dépassé',
        'trackingNumber': 'FR456789123',
        'estimatedRefund': 'Non applicable',
      },
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Mes retours',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Politique de retour',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Vous avez 30 jours pour retourner vos articles',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: returns.length,
              itemBuilder: (context, index) {
                final returnItem = returns[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () {
                        _showReturnDetails(context, returnItem);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Commande #${returnItem['orderNumber']}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(returnItem['status']).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    returnItem['status'],
                                    style: TextStyle(
                                      color: _getStatusColor(returnItem['status']),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            
                            Text(
                              returnItem['productName'],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            
                            Row(
                              children: [
                                Icon(Icons.calendar_today, size: 16, color: Colors.black),
                                const SizedBox(width: 6),
                                Text(
                                  returnItem['returnDate'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                const SizedBox(width: 6),
                                Text(
                                  returnItem['refundAmount'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            
                            Row(
                              children: [
                                Icon(Icons.info_outline, size: 16, color: Colors.black),
                                const SizedBox(width: 6),
                                Text(
                                  'Raison: ${returnItem['reason']}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showNewReturnDialog(context);
        },
        backgroundColor: AppColors.deepBlue,
        label: const Text('Nouveau retour',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        icon: const Icon(Icons.add,
          color: Colors.white,),
      ),
    );
  }
  Color _getStatusColor(String status) {
    switch (status) {
      case 'En cours de traitement':
        return Colors.orange;
      case 'Retour accepté':
        return Colors.green;
      case 'Retour refusé':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
  
  void _showReturnDetails(BuildContext context, Map<String, dynamic> returnItem) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Détails du retour',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _getStatusColor(returnItem['status']).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _getStatusIcon(returnItem['status']),
                          color: _getStatusColor(returnItem['status']),
                          size: 32,
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              returnItem['status'],
                              style: TextStyle(
                                color: _getStatusColor(returnItem['status']),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Mis à jour le ${returnItem['returnDate']}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  _buildDetailRow('Produit', returnItem['productName']),
                  _buildDetailRow('N° de commande', '#${returnItem['orderNumber']}'),
                  _buildDetailRow('Date de retour', returnItem['returnDate']),
                  _buildDetailRow('Montant à rembourser', returnItem['refundAmount']),
                  _buildDetailRow('Raison du retour', returnItem['reason']),
                  _buildDetailRow('N° de suivi', returnItem['trackingNumber']),
                  _buildDetailRow('Remboursement', returnItem['estimatedRefund']),
                  
                  const SizedBox(height: 24),
                  
                  if (returnItem['status'] == 'En cours de traitement') ...[
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Suivi du colis copié dans le presse-papiers'),
                            ),
                          );
                        },
                        icon: const Icon(Icons.local_shipping,
                          color: Colors.white,
                        ),
                        label: const Text('Suivre mon colis',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.deepBlue,
                          padding: const EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
  
  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'En cours de traitement':
        return Icons.hourglass_empty;
      case 'Retour accepté':
        return Icons.check_circle;
      case 'Retour refusé':
        return Icons.cancel;
      default:
        return Icons.info;
    }
  }
  
  void _showNewReturnDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: const Text('Initier un retour'),
        content: const Text(
          'Pour initier un retour, rendez-vous dans "Mes commandes" et sélectionnez l\'article que vous souhaitez retourner.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Compris'),
          ),
        ],
      ),
    );
  }
}