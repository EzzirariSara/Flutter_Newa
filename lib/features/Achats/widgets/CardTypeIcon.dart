import 'package:flutter/material.dart';
class CardTypeIcon extends StatelessWidget {
  final String cardType;

  const CardTypeIcon({
    Key? key,
    required this.cardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      return Image.asset(
        'assets/images/$cardType.png',
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          IconData iconData = Icons.credit_card;
          Color iconColor = Colors.grey;
          
          if (cardType == 'visa') {
            iconColor = Colors.blue;
          } else if (cardType == 'mastercard') {
            iconColor = Colors.deepOrange;
          } else if (cardType == 'amex') {
            iconColor = Colors.indigo;
          }
          
          return Icon(iconData, color: iconColor);
        },
      );
    } catch (e) {
      return Icon(
        Icons.credit_card,
        color: cardType == 'mastercard' ? Colors.deepOrange : Colors.blue,
      );
    }
  }
}