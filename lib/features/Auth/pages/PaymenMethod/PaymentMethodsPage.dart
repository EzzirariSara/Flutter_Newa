import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/config/theme/Colors.dart';

class PaymentMethodsPage extends StatefulWidget {
  const PaymentMethodsPage({super.key});

  @override
  State<PaymentMethodsPage> createState() => _PaymentMethodsPageState();
}

class _PaymentMethodsPageState extends State<PaymentMethodsPage> {
  List<Map<String, dynamic>> cards = [
    {
      'id': 1,
      'cardHolder': 'Ahmed Ben Ali',
      'cardNumber': '**** **** **** 1234',
      'fullNumber': '1234567890121234',
      'expiry': '12/25',
      'cardType': 'visa',
      'isDefault': true,
    },
    {
      'id': 2,
      'cardHolder': 'Ahmed Ben Ali',
      'cardNumber': '**** **** **** 5678',
      'fullNumber': '5234567890125678',
      'expiry': '11/24',
      'cardType': 'mastercard',
      'isDefault': false,
    },
  ];

  void _showCardDialog({Map<String, dynamic>? card, int? index}) {
    final isEditing = card != null;
    final holderController = TextEditingController(
      text: card?['cardHolder'] ?? '',
    );
    final numberController = TextEditingController();
    final monthController = TextEditingController();
    final yearController = TextEditingController();
    final cvvController = TextEditingController();
    bool acceptTerms = false;

    if (isEditing && card!['expiry'] != null) {
      final parts = card['expiry'].split('/');
      monthController.text = parts[0];
      yearController.text = parts[1];
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 16,
            left: 20,
            right: 20,
          ),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Text(
                  isEditing ? 'Modifier la carte' : 'Nouvelle carte',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                
                TextField(
                  controller: holderController,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_outline, color: AppColors.deepBlue),
                    hintText: 'Titulaire de la carte',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.deepBlue),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                
                TextField(
                  controller: numberController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(16),
                  ],
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.credit_card, color: AppColors.deepBlue),
                    hintText: 'Numéro de carte',
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.deepBlue),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Date d\'expiration',
                      style: TextStyle(
                        color: AppColors.deepBlue,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: DropdownButtonFormField<String>(
                            value: monthController.text.isEmpty ? '01' : monthController.text,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 12),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey[300]!),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey[300]!),
                              ),
                            ),
                            items: List.generate(12, (index) {
                              final month = (index + 1).toString().padLeft(2, '0');
                              return DropdownMenuItem(
                                value: month,
                                child: Text(month),
                              );
                            }),
                            onChanged: (value) {
                              monthController.text = value!;
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        
                        Expanded(
                          flex: 2,
                          child: DropdownButtonFormField<String>(
                            value: yearController.text.isEmpty ? '2025' : yearController.text,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 12),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey[300]!),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey[300]!),
                              ),
                            ),
                            items: List.generate(10, (index) {
                              final year = (2025 + index).toString();
                              return DropdownMenuItem(
                                value: year,
                                child: Text(year),
                              );
                            }),
                            onChanged: (value) {
                              yearController.text = value!;
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        
                        Expanded(
                          flex: 3,
                          child: TextField(
                            controller: cvvController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(4),
                            ],
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock_outline, color: AppColors.deepBlue, size: 20),
                              hintText: 'CVC',
                              hintStyle: TextStyle(color: Colors.grey[600]),
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey[300]!),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey[300]!),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColors.deepBlue),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                
                Row(
                  children: [
                    Checkbox(
                      value: acceptTerms,
                      onChanged: (value) {
                        setModalState(() {
                          acceptTerms = value!;
                        });
                      },
                      activeColor: AppColors.deepBlue,
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setModalState(() {
                            acceptTerms = !acceptTerms;
                          });
                        },
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.black87, fontSize: 14),
                            children: [
                              TextSpan(text: 'Accepter les '),
                              TextSpan(
                                text: 'conditions générales d\'utilisation',
                                style: TextStyle(color: AppColors.deepBlue),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                
                Container(
                  padding: EdgeInsets.all(12),
                  margin: EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Les informations sur la carte vous concernant resteront confidentielles.',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildCardLogo('visa'),
                    const SizedBox(width: 16),
                    _buildCardLogo('mastercard'),
                    const SizedBox(width: 16),
                    _buildCardLogo('maestro'),
                    const SizedBox(width: 16),
                    _buildCardLogo('cmi'),
                  ],
                ),
                const SizedBox(height: 16),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSecurityLogo('verified'),
                    const SizedBox(width: 16),
                    _buildSecurityLogo('norton'),
                    const SizedBox(width: 16),
                    _buildSecurityLogo('pci'),
                  ],
                ),
                
                const SizedBox(height: 24),
                
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: acceptTerms ? () {
                      final cardType = _detectCardType(numberController.text);
                      setState(() {
                        if (isEditing) {
                          cards[index!] = {
                            ...cards[index],
                            'cardHolder': holderController.text,
                            'expiry': '${monthController.text}/${yearController.text.substring(2)}',
                          };
                        } else {
                          cards.add({
                            'id': DateTime.now().millisecondsSinceEpoch,
                            'cardHolder': holderController.text,
                            'cardNumber': '**** **** **** ${numberController.text.substring(numberController.text.length - 4)}',
                            'fullNumber': numberController.text,
                            'expiry': '${monthController.text}/${yearController.text.substring(2)}',
                            'cardType': cardType,
                            'isDefault': cards.isEmpty,
                          });
                        }
                      });
                      Navigator.pop(context);
                    } : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.deepBlue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      disabledBackgroundColor: Colors.grey[300],
                    ),
                    child: Text(
                      isEditing ? 'Enregistrer' : 'Ajouter',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _detectCardType(String cardNumber) {
    if (cardNumber.startsWith('4')) return 'visa';
    if (cardNumber.startsWith('5')) return 'mastercard';
    if (cardNumber.startsWith('3')) return 'amex';
    if (cardNumber.startsWith('6')) return 'maestro';
    return 'visa';
  }

  Widget _buildCardLogo(String cardType) {
    try {
      return Image.asset(
        'assets/images/$cardType.png',
        height: 40,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          IconData iconData = Icons.credit_card;
          Color iconColor = Colors.grey;
          
          if (cardType == 'visa') {
            iconColor = Colors.blue;
          } else if (cardType == 'mastercard') {
            iconColor = Colors.deepOrange;
          } else if (cardType == 'maestro') {
            iconColor = Colors.red;
          } else if (cardType == 'cmi') {
            iconColor = Colors.orange;
          }
          
          return Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(iconData, color: iconColor, size: 24),
          );
        },
      );
    } catch (e) {
      return Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]!),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          Icons.credit_card,
          color: cardType == 'mastercard' ? Colors.deepOrange : Colors.blue,
          size: 24,
        ),
      );
    }
  }

  Widget _buildSecurityLogo(String type) {
    IconData icon;
    Color color;
    
    switch (type) {
      case 'verified':
        icon = Icons.verified_user;
        color = Colors.blue;
        break;
      case 'norton':
        icon = Icons.security;
        color = Colors.orange;
        break;
      case 'pci':
        icon = Icons.shield;
        color = Colors.green;
        break;
      default:
        icon = Icons.security;
        color = Colors.grey;
    }
    
    return Icon(icon, color: color, size: 32);
  }

  Widget _buildCardIcon(String cardType) {
    try {
      return Image.asset(
        'assets/images/$cardType.png',
        width: 40,
        height: 25,
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

  void _deleteCard(int index) {
    setState(() {
      cards.removeAt(index);
      if (cards.isNotEmpty && !cards.any((c) => c['isDefault'])) {
        cards[0]['isDefault'] = true;
      }
    });
  }

  void _setDefaultCard(int index) {
    setState(() {
      for (int i = 0; i < cards.length; i++) {
        cards[i]['isDefault'] = i == index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Mes modes de paiement',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[100],
      body: cards.isEmpty
          ? const Center(child: Text('Aucune carte enregistrée'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: cards.length,
              itemBuilder: (context, index) {
                final card = cards[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: card['isDefault']
                        ? Border.all(color: AppColors.deepBlue, width: 2)
                        : null,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              _buildCardIcon(card['cardType'] ?? 'visa'),
                              const SizedBox(width: 12),
                              Text(
                                card['cardNumber'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          PopupMenuButton<String>(
                            icon: const Icon(Icons.more_vert),
                            onSelected: (value) {
                              switch (value) {
                                case 'edit':
                                  _showCardDialog(card: card, index: index);
                                  break;
                                case 'delete':
                                  _deleteCard(index);
                                  break;
                                case 'default':
                                  _setDefaultCard(index);
                                  break;
                              }
                            },
                            itemBuilder: (_) => [
                              const PopupMenuItem(
                                value: 'edit',
                                child: Text('Modifier'),
                              ),
                              if (!card['isDefault'])
                                const PopupMenuItem(
                                  value: 'default',
                                  child: Text('Définir par défaut'),
                                ),
                              const PopupMenuItem(
                                value: 'delete',
                                child: Text(
                                  'Supprimer',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        card['cardHolder'],
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      Text(
                        'Expire le ${card['expiry']}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      if (card['isDefault']) ...[
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.deepBlue,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            'Carte par défaut',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCardDialog(),
        backgroundColor: AppColors.deepBlue,
        label: const Text(
          'Ajouter une carte',
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}