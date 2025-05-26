import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/Achats/widgets/PaymentMethodOption.dart';
import 'package:flutter_application_1/features/Achats/widgets/SavedCardsSection.dart';
class PaymentMethodsSection extends StatelessWidget {
  final String selectedPaymentMethod;
  final String selectedCardId;
  final List<Map<String, dynamic>> savedCards;
  final bool addingNewCard;
  final Function(String) onPaymentMethodChanged;
  final Function(String) onCardSelected;
  final VoidCallback onAddNewCardToggle;

  const PaymentMethodsSection({
    Key? key,
    required this.selectedPaymentMethod,
    required this.selectedCardId,
    required this.savedCards,
    required this.addingNewCard,
    required this.onPaymentMethodChanged,
    required this.onCardSelected,
    required this.onAddNewCardToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PaymentMethodOption(
            title: 'Carte bancaire',
            subtitle: 'Payer avec votre carte bancaire',
            icon: Icons.credit_card,
            value: 'card',
            groupValue: selectedPaymentMethod,
            onChanged: onPaymentMethodChanged,
          ),
          
          if (selectedPaymentMethod == 'card')
            SavedCardsSection(
              savedCards: savedCards,
              selectedCardId: selectedCardId,
              onCardSelected: onCardSelected,
              onAddNewCardToggle: onAddNewCardToggle,
              addingNewCard: addingNewCard,
            ),
          
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Divider(height: 1),
          ),
          
          PaymentMethodOption(
            title: 'Paiement à la livraison',
            subtitle: 'Payer en espèces à la réception',
            icon: Icons.local_shipping,
            value: 'cash',
            groupValue: selectedPaymentMethod,
            onChanged: onPaymentMethodChanged,
          ),
        ],
      ),
    );
  }
}