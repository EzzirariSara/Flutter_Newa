import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/theme/Colors.dart';
import 'package:flutter_application_1/features/Achats/widgets/CardTypeIcon.dart';
class SavedCardItem extends StatelessWidget {
  final Map<String, dynamic> card;
  final String selectedCardId;
  final Function(String) onCardSelected;

  const SavedCardItem({
    Key? key,
    required this.card,
    required this.selectedCardId,
    required this.onCardSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => onCardSelected(card['id']),
        child: Row(
          children: [
            Radio<String>(
              value: card['id'],
              groupValue: selectedCardId,
              onChanged: (value) => onCardSelected(value!),
              activeColor: AppColors.deepBlue,
            ),
            Container(
              width: 36,
              height: 24,
              margin: const EdgeInsets.only(right: 12),
              child: CardTypeIcon(cardType: card['cardType']),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    card['cardNumber'],
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    card['cardHolder'],
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              card['expiryDate'],
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}