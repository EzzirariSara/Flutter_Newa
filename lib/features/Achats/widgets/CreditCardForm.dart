import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/theme/Colors.dart';
import 'package:flutter_application_1/features/Achats/widgets/CardFormField.dart';
class CreditCardForm extends StatelessWidget {
  final TextEditingController cardNumberController;
  final TextEditingController cardHolderController;
  final TextEditingController expiryDateController;
  final TextEditingController cvvController;
  final bool isAddingCardInProgress;
  final bool isCreditCardValid;
  final Function(String) onFormChanged;
  final VoidCallback onAddCard;
  final VoidCallback onCancel;

  const CreditCardForm({
    Key? key,
    required this.cardNumberController,
    required this.cardHolderController,
    required this.expiryDateController,
    required this.cvvController,
    required this.isAddingCardInProgress,
    required this.isCreditCardValid,
    required this.onFormChanged,
    required this.onAddCard,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.deepBlue.withOpacity(0.9),
            AppColors.deepBlue.withOpacity(0.7),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Positioned(
              top: -50,
              right: -50,
              child: Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
            Positioned(
              bottom: -60,
              left: -30,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Ajouter une nouvelle carte',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: onCancel,
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  
                  CardFormField(
                    label: 'Numéro de carte',
                    hint: '1234 5678 9012 3456',
                    controller: cardNumberController,
                    keyboardType: TextInputType.number,
                    maxLength: 19,
                    prefixIcon: Icons.credit_card,
                    onChanged: (value) {
                      if (value.length > 0) {
                        value = value.replaceAll(' ', '');
                        String formatted = '';
                        for (int i = 0; i < value.length; i++) {
                          if (i > 0 && i % 4 == 0) {
                            formatted += ' ';
                          }
                          formatted += value[i];
                        }
                        if (formatted != cardNumberController.text) {
                          cardNumberController.value = TextEditingValue(
                            text: formatted,
                            selection: TextSelection.collapsed(offset: formatted.length),
                          );
                        }
                      }
                      onFormChanged(value);
                    },
                  ),
                  
                  const SizedBox(height: 16),
                  
                  CardFormField(
                    label: 'Titulaire de la carte',
                    hint: 'NOM PRÉNOM',
                    controller: cardHolderController,
                    keyboardType: TextInputType.name,
                    prefixIcon: Icons.person,
                    onChanged: onFormChanged,
                  ),
                  
                  const SizedBox(height: 16),
                  
                  Row(
                    children: [
                      Expanded(
                        child: CardFormField(
                          label: 'Date d\'expiration',
                          hint: 'MM/YY',
                          controller: expiryDateController,
                          keyboardType: TextInputType.number,
                          maxLength: 5,
                          prefixIcon: Icons.calendar_today,
                          onChanged: (value) {
                            if (value.length > 0) {
                              value = value.replaceAll('/', '');
                              if (value.length > 2) {
                                value = value.substring(0, 2) + '/' + value.substring(2);
                              }
                              if (value != expiryDateController.text) {
                                expiryDateController.value = TextEditingValue(
                                  text: value,
                                  selection: TextSelection.collapsed(offset: value.length),
                                );
                              }
                            }
                            onFormChanged(value);
                          },
                        ),
                      ),
                      
                      const SizedBox(width: 16),
                      
                      Expanded(
                        child: CardFormField(
                          label: 'CVV',
                          hint: '123',
                          controller: cvvController,
                          keyboardType: TextInputType.number,
                          maxLength: 4,
                          prefixIcon: Icons.lock,
                          obscureText: true,
                          onChanged: onFormChanged,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isCreditCardValid && !isAddingCardInProgress ? onAddCard : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: AppColors.deepBlue,
                        disabledBackgroundColor: Colors.grey.shade300,
                        disabledForegroundColor: Colors.grey.shade500,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: isAddingCardInProgress 
                        ? const SizedBox(
                            width: 20, 
                            height: 20, 
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(AppColors.deepBlue),
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'Ajouter cette carte',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}