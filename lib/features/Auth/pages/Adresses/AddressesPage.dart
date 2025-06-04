import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/theme/Colors.dart';

class AddressesPage extends StatefulWidget {
  const AddressesPage({super.key});

  @override
  State<AddressesPage> createState() => _AddressesPageState();
}

class _AddressesPageState extends State<AddressesPage> {
  List<Map<String, dynamic>> addresses = [
    {
      'id': 1,
      'name': 'Maison',
      'fullName': 'Ahmed Ben Ali',
      'phone': '+212 6 12 34 56 78',
      'address': '123 Avenue Mohammed V',
      'city': 'Casablanca',
      'postalCode': '20000',
      // 'country': 'Maroc',
      'isDefault': true,
    },
    {
      'id': 2,
      'name': 'Bureau',
      'fullName': 'Ahmed Ben Ali',
      'phone': '+212 5 22 11 22 33',
      'address': '45 Rue des Entreprises, Quartier des Affaires',
      'city': 'Rabat',
      'postalCode': '10000',
      // 'country': 'Maroc',
      'isDefault': false,
    },
  ];
  int? defaultAddressId;

  @override
  void initState() {
    super.initState();
    final defaultAddress = addresses.firstWhere((a) => a['isDefault'], orElse: () => {});
    defaultAddressId = defaultAddress['id'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Mes adresses',
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
      body: addresses.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                final address = addresses[index];
                return _buildAddressCard(address, index);
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddressDialog(context),
        backgroundColor: AppColors.deepBlue,
        label: const Text(
          'Nouvelle adresse',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_off_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Aucune adresse enregistrée',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Ajoutez une adresse pour faciliter vos commandes',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressCard(Map<String, dynamic> address, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: address['isDefault']
            ? Border.all(color: AppColors.deepBlue, width: 2)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
     child: Padding(
  padding: const EdgeInsets.all(16),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.deepBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  address['name'] == 'Maison'
                      ? Icons.home
                      : address['name'] == 'Bureau'
                          ? Icons.work
                          : Icons.location_on,
                  color: AppColors.deepBlue,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        address['name'],
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (address['isDefault']) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.deepBlue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Par défaut',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address['fullName'],
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
          PopupMenuButton<String>(
            color: Colors.white,
            icon: Icon(Icons.more_vert, color: Colors.grey[600]),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onSelected: (value) {
              switch (value) {
                case 'edit':
                  _showAddressDialog(context, address: address, index: index);
                  break;
                case 'delete':
                  _showDeleteDialog(context, index);
                  break;
                case 'default':
                  _setDefaultAddress(index);

                  break;
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit, size: 20),
                    SizedBox(width: 8),
                    Text('Modifier'),
                  ],
                ),
              ),
              if (!address['isDefault'])
                const PopupMenuItem<String>(
                  value: 'default',
                  child: Row(
                    children: [
                      Icon(Icons.check_circle_outline, size: 20),
                      SizedBox(width: 8),
                      Text('Définir par défaut'),
                    ],
                  ),
                ),
              const PopupMenuItem<String>(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, size: 20, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Supprimer', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      const SizedBox(height: 16),
      Text(
        address['address'],
        style: const TextStyle(fontSize: 14),
      ),
      const SizedBox(height: 4),
      Text(
        '${address['postalCode']} ${address['city']}, ${address['country']}',
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[600],
        ),
      ),
      const SizedBox(height: 8),
      Row(
        children: [
          Icon(Icons.phone, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 6),
          Text(
            address['phone'],
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    ],
  ),
),

    );
  }

  void _showAddressDialog(BuildContext context, {Map<String, dynamic>? address, int? index}) {
  final isEditing = address != null;
  final titleController = TextEditingController(text: address?['name'] ?? '');
  final fullNameController = TextEditingController(text: address?['fullName'] ?? '');
  final phoneController = TextEditingController(text: address?['phone'] ?? '');
  final addressController = TextEditingController(text: address?['address'] ?? '');
  final cityController = TextEditingController(text: address?['city'] ?? '');
  final postalCodeController = TextEditingController(text: address?['postalCode'] ?? '');
  final countryController = TextEditingController(text: address?['country'] ?? 'Maroc');

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => Container(
      height: MediaQuery.of(context).size.height * 0.7, 
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isEditing ? 'Modifier l\'adresse' : 'Nouvelle adresse',
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildTextField(controller: titleController, label: 'Nom adresse', hint: 'Maison, Bureau', icon: Icons.label_outline, simple: true),
                  const SizedBox(height: 12),
                  _buildTextField(controller: fullNameController, label: 'Nom complet', hint: 'Prénom Nom', icon: Icons.person_outline, simple: true),
                  const SizedBox(height: 12),
                  _buildTextField(controller: phoneController, label: 'Téléphone', hint: '+212 6 00 00 00 00', icon: Icons.phone_outlined, keyboardType: TextInputType.phone, simple: true),
                  const SizedBox(height: 12),
                  _buildTextField(controller: addressController, label: 'Adresse', hint: 'Numéro et rue', icon: Icons.location_on_outlined, maxLines: 2, simple: true),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(controller: cityController, label: 'Ville', hint: 'Casablanca', icon: Icons.location_city, simple: true),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _buildTextField(controller: postalCodeController, label: 'Code postal', hint: '00000', icon: Icons.markunread_mailbox_outlined, keyboardType: TextInputType.number, simple: true),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (isEditing) {
                          setState(() {
                            addresses[index!] = {
                              'id': address!['id'],
                              'name': titleController.text,
                              'fullName': fullNameController.text,
                              'phone': phoneController.text,
                              'address': addressController.text,
                              'city': cityController.text,
                              'postalCode': postalCodeController.text,
                              'country': countryController.text,
                              'isDefault': address['isDefault'],
                            };
                          });
                        } else {
                          setState(() {
                            addresses.add({
                              'id': DateTime.now().millisecondsSinceEpoch,
                              'name': titleController.text,
                              'fullName': fullNameController.text,
                              'phone': phoneController.text,
                              'address': addressController.text,
                              'city': cityController.text,
                              'postalCode': postalCodeController.text,
                              'country': countryController.text,
                              'isDefault': addresses.isEmpty,
                            });
                          });
                        }
                        // Navigator.pop(context);

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.deepBlue,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text(isEditing ? 'Enregistrer' : 'Ajouter', style: const TextStyle(fontSize: 16,color:Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildTextField({
  required TextEditingController controller,
  required String label,
  required String hint,
  required IconData icon,
  TextInputType? keyboardType,
  int maxLines = 1,
  bool simple = false,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    maxLines: maxLines,
    decoration: InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: Icon(icon, color: AppColors.deepBlue),
      border: simple
          ? UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300))
          : OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      focusedBorder: simple
          ? UnderlineInputBorder(borderSide: BorderSide(color: AppColors.deepBlue, width: 2))
          : OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: AppColors.deepBlue, width: 2)),
      filled: true,
      fillColor: Colors.grey[50],
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    ),
  );
}


  void _showDeleteDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text('Supprimer l\'adresse'),
        content: const Text(
          'Êtes-vous sûr de vouloir supprimer cette adresse ?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                addresses.removeAt(index);
                if (addresses.isNotEmpty && !addresses.any((a) => a['isDefault'])) {
                  addresses[0]['isDefault'] = true;
                }
              });
              // Navigator.pop(context);
              // ScaffoldMessenger.of(context).showSnackBar(
              //   const SnackBar(
              //     content: Text('Adresse supprimée'),
              //     backgroundColor: Colors.red,
              //   ),
              // );
            },
            child: const Text(
              'Supprimer',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _setDefaultAddress(int index) {
  setState(() {
    for (int i = 0; i < addresses.length; i++) {
      addresses[i]['isDefault'] = i == index;
    }
  });
}}