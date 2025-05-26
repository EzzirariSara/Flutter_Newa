import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/theme/Colors.dart';
class AddNewCardButton extends StatelessWidget {
  final bool addingNewCard;
  final VoidCallback onPressed;

  const AddNewCardButton({
    Key? key,
    required this.addingNewCard,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.deepBlue.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: AppColors.deepBlue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                addingNewCard ? Icons.close : Icons.add,
                color: Colors.white,
                size: 16,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              addingNewCard ? 'Annuler' : 'Ajouter une carte',
              style: TextStyle(
                color: AppColors.deepBlue,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}