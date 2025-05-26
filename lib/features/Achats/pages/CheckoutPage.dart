
import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/theme/Colors.dart';
import 'package:flutter_application_1/features/Achats/pages/ContactInfo.dart';
import 'package:flutter_application_1/features/Achats/pages/shippingAddress.dart';
import 'package:flutter_application_1/features/Achats/panierCuPage.dart';
import 'package:flutter_application_1/features/Achats/widgets/CheckoutAppBar.dart';
import 'package:flutter_application_1/features/Achats/widgets/CreditCardForm.dart';
import 'package:flutter_application_1/features/Achats/widgets/InformationSection.dart';
import 'package:flutter_application_1/features/Achats/widgets/OrderItemsList.dart';
import 'package:flutter_application_1/features/Achats/widgets/OrderSummary.dart';
import 'package:flutter_application_1/features/Achats/widgets/PaymentButton.dart';
import 'package:flutter_application_1/features/Achats/widgets/PaymentMethodsSection.dart';
import 'package:flutter_application_1/features/Achats/widgets/ProcessingDialog.dart';
import 'package:flutter_application_1/features/Achats/widgets/SectionTitle.dart';
import 'package:flutter_application_1/features/Achats/widgets/SuccessDialog.dart';

class CheckoutPage extends StatefulWidget {
  final List<CartItem> items;
  final double total;
  final double deliveryFee;

  const CheckoutPage({
    Key? key, 
    required this.items,
    required this.total,
    required this.deliveryFee,
  }) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  String shippingAddress = "Magadi Main Rd, Casablanca ,560023";
  String phoneNumber = "+919876543421";
  String email = "email@example.com";
  String country = "Maroc";
  String city = "Casablanca";
  String postcode = "70000";
  String selectedPaymentMethod = "card";
  String selectedCardId = "card1";
  
  List<Map<String, dynamic>> savedCards = [
    {
      'id': 'card1',
      'cardNumber': '•••• •••• •••• 1579',
      'cardHolder': 'Moha Tazi',
      'expiryDate': '12/27',
      'cardType': 'mastercard',
      'isDefault': true,
    },
  ];
  
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _cardHolderController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  bool _isCreditCardValid = false;
  bool _addingNewCard = false;
  bool _isAddingCardInProgress = false;

  @override
  void dispose() {
    _cardNumberController.dispose();
    _cardHolderController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }
  
  void _validateCreditCardForm(String? _ ) {
    final cardNumber = _cardNumberController.text.trim();
    final cardHolder = _cardHolderController.text.trim();
    final expiryDate = _expiryDateController.text.trim();
    final cvv = _cvvController.text.trim();
    
    setState(() {
      _isCreditCardValid = cardNumber.length >= 16 && 
                         cardHolder.isNotEmpty && 
                         expiryDate.length == 5 && 
                         cvv.length >= 3;
    });
  }

  void _addNewCard() {
    if (!_isCreditCardValid) return;
    
    setState(() {
      _isAddingCardInProgress = true;
    });
    
    Future.delayed(const Duration(milliseconds: 800), () {
      final cardNumber = _cardNumberController.text.trim();
      final cardHolder = _cardHolderController.text.trim();
      final expiryDate = _expiryDateController.text.trim();
      
      String cardType = 'unknown';
      if (cardNumber.startsWith('4')) {
        cardType = 'visa';
      } else if (cardNumber.startsWith('5')) {
        cardType = 'mastercard';
      } else if (cardNumber.startsWith('3')) {
        cardType = 'amex';
      }
      
      final String maskedNumber = '•••• •••• •••• ' + cardNumber.substring(cardNumber.length - 4);
      final String newCardId = 'card${savedCards.length + 1}';
      
      final newCard = {
        'id': newCardId,
        'cardNumber': maskedNumber,
        'cardHolder': cardHolder.toUpperCase(),
        'expiryDate': expiryDate,
        'cardType': cardType,
        'isDefault': false,
      };
      
      setState(() {
        savedCards.add(newCard);
        selectedCardId = newCardId;
        _addingNewCard = false;
        _isAddingCardInProgress = false;
        
        _cardNumberController.clear();
        _cardHolderController.clear();
        _expiryDateController.clear();
        _cvvController.clear();
        _isCreditCardValid = false;
      });
      
      _showCardAddedDialog();
    });
  }
  
  void _showCardAddedDialog() {
    showDialog(
      context: context,
      builder: (context) => SuccessDialog(
        title: 'Carte ajoutée',
        content: 'Votre nouvelle carte a été ajoutée avec succès et sélectionnée comme moyen de paiement.',
      ),
    );
  }

  void _showAddressEditDialog() {
    final addressModel = Shippingaddress(
      address: shippingAddress,
      city: city,
      postcode: postcode,
      country: country,
    );
    
    showAddressEditSheet(
      context, 
      addressModel,
      (updatedAddress) {
        setState(() {
          shippingAddress = updatedAddress.address;
          city = updatedAddress.city;
          postcode = updatedAddress.postcode;
          country = updatedAddress.country;
        });
        
        Future.delayed(Duration.zero, () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext dialogContext) {
              return SuccessDialog(
                title: 'Adresse de livraison mise à jour',
                content: '',
              );
            },
          );
        });
      },
    );
  }

  void _showContactEditDialog() {
    final contactModel = ContactInfo(
      phoneNumber: phoneNumber,
      email: email,
    );
    
    showContactEditSheet(
      context,
      contactModel,
      (updatedContact) {
        setState(() {
          phoneNumber = updatedContact.phoneNumber;
          email = updatedContact.email;
        });
        Future.delayed(Duration.zero, () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext dialogContext) {
              return SuccessDialog(
                title: 'Informations de contact mises à jour',
                content: '',
              );
            },
          );
        });
      },
    );
  }

  void _showCardProcessingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return ProcessingDialog(
          title: 'Traitement du paiement',
          content: 'Veuillez patienter pendant que nous traitons votre paiement...',
        );
      },
    );

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context); 
      _showOrderConfirmationDialog();
    });
  }

  void _showOrderConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => SuccessDialog(
        title: selectedPaymentMethod == 'card' ? 'Paiement réussi' : 'Commande confirmée',
        content: selectedPaymentMethod == 'card' 
          ? 'Votre paiement par carte a été accepté. Votre commande a été confirmée et sera bientôt expédiée.'
          : 'Votre commande a été confirmée et sera bientôt expédiée. Le paiement sera effectué à la livraison.',
        onOkPressed: () {
          Navigator.pop(context);
          Navigator.popUntil(
            context, 
            (route) => route.isFirst || route.settings.name == '/cart',
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CheckoutAppBar(
        title: 'Finaliser la commande',
        onBackPressed: () => Navigator.of(context).pop(),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InformationSection(
                      title: 'Adresse de livraison',
                      content: '$shippingAddress\n$city, $country\n$postcode',
                      onEdit: _showAddressEditDialog,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    InformationSection(
                      title: 'Informations de contact',
                      content: '$phoneNumber\n$email',
                      onEdit: _showContactEditDialog,
                    ),
                    
                    const SizedBox(height: 24),
                    
                    const SectionTitle(title: 'Mode de paiement'),
                    
                    const SizedBox(height: 16),
                    
                    PaymentMethodsSection(
                      selectedPaymentMethod: selectedPaymentMethod,
                      selectedCardId: selectedCardId,
                      savedCards: savedCards,
                      addingNewCard: _addingNewCard,
                      onPaymentMethodChanged: (value) {
                        setState(() {
                          selectedPaymentMethod = value;
                          if (selectedPaymentMethod != 'card') {
                            _addingNewCard = false;
                          }
                        });
                      },
                      onCardSelected: (cardId) {
                        setState(() {
                          selectedCardId = cardId;
                          _addingNewCard = false;
                        });
                      },
                      onAddNewCardToggle: () {
                        setState(() {
                          _addingNewCard = !_addingNewCard;
                          if (_addingNewCard) {
                            selectedCardId = '';
                          } else {
                            selectedCardId = savedCards.isNotEmpty ? savedCards[0]['id'] : '';
                          }
                          
                          _cardNumberController.clear();
                          _cardHolderController.clear();
                          _expiryDateController.clear();
                          _cvvController.clear();
                          _isCreditCardValid = false;
                        });
                      },
                    ),
                    
                    if (selectedPaymentMethod == 'card' && _addingNewCard)
                      Padding(
                        padding: const EdgeInsets.only(top: 16, bottom: 8),
                        child: CreditCardForm(
                          cardNumberController: _cardNumberController,
                          cardHolderController: _cardHolderController,
                          expiryDateController: _expiryDateController,
                          cvvController: _cvvController,
                          isAddingCardInProgress: _isAddingCardInProgress,
                          isCreditCardValid: _isCreditCardValid,
                          onFormChanged: _validateCreditCardForm,
                          onAddCard: _addNewCard,
                          onCancel: () {
                            setState(() {
                              _addingNewCard = false;
                              selectedCardId = savedCards.isNotEmpty ? savedCards[0]['id'] : '';
                            });
                          },
                        ),
                      ),
                    
                    const SizedBox(height: 24),
                    
                    const SectionTitle(title: 'Récapitulatif de la commande'),
                    
                    const SizedBox(height: 16),
                    
                    OrderItemsList(items: widget.items),
                    
                    const SizedBox(height: 24),
                    
                    OrderSummary(
                      items: widget.items,
                      deliveryFee: widget.deliveryFee,
                      total: widget.total,
                    ),
                  ],
                ),
              ),
            ),
            
            PaymentButton(
              selectedPaymentMethod: selectedPaymentMethod,
              selectedCardId: selectedCardId,
              addingNewCard: _addingNewCard,
              isCreditCardValid: _isCreditCardValid,
              onPressed: () {
                if (selectedPaymentMethod == 'card') {
                  _showCardProcessingDialog();
                } else {
                  _showOrderConfirmationDialog();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}