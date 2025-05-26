import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/theme/Colors.dart';
class PaymentButton extends StatelessWidget {
  final String selectedPaymentMethod;
  final String selectedCardId;
  final bool addingNewCard;
  final bool isCreditCardValid;
  final VoidCallback onPressed;

  const PaymentButton({
    Key? key,
    required this.selectedPaymentMethod,
    required this.selectedCardId,
    required this.addingNewCard,
    required this.isCreditCardValid,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPaymentEnabled = selectedPaymentMethod == 'cash' || 
                         (selectedPaymentMethod == 'card' && 
                          ((!addingNewCard && selectedCardId.isNotEmpty) || 
                           (addingNewCard && isCreditCardValid)));
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, -4),
            blurRadius: 8,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: isPaymentEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.deepBlue,
          foregroundColor: Colors.white,
          disabledBackgroundColor: Colors.grey.shade300,
          disabledForegroundColor: Colors.grey.shade500,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          minimumSize: const Size(double.infinity, 0),
          elevation: 0,
        ),
        child: Text(
          selectedPaymentMethod == 'card' ? 'Confirmer et payer' : 'Confirmer la commande',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}