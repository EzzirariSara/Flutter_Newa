import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/Achats/widgets/AddNewCardButton.dart';
import 'package:flutter_application_1/features/Achats/widgets/SavedCardItem.dart';
class SavedCardsSection extends StatelessWidget {
  final List<Map<String, dynamic>> savedCards;
  final String selectedCardId;
  final Function(String) onCardSelected;
  final VoidCallback onAddNewCardToggle;
  final bool addingNewCard;

  const SavedCardsSection({
    Key? key,
    required this.savedCards,
    required this.selectedCardId,
    required this.onCardSelected,
    required this.onAddNewCardToggle,
    required this.addingNewCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, left: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...savedCards.map((card) => SavedCardItem(
            card: card,
            selectedCardId: selectedCardId,
            onCardSelected: onCardSelected,
          )),
          
          const SizedBox(height: 12),
          AddNewCardButton(
            addingNewCard: addingNewCard,
            onPressed: onAddNewCardToggle,
          ),
        ],
      ),
    );
  }
}