import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/theme/Colors.dart';

class Shippingaddress {
  String address;
  String city;
  String postcode;
  String country;

  Shippingaddress({
    required this.address,
    required this.city,
    required this.postcode,
    required this.country,
  });
}

class AddressEditSheet extends StatefulWidget {
  final Shippingaddress initialAddress;
  final Function(Shippingaddress) onSave;

  const AddressEditSheet({
    Key? key,
    required this.initialAddress,
    required this.onSave,
  }) : super(key: key);

  @override
  State<AddressEditSheet> createState() => _AddressEditSheetState();
}

class _AddressEditSheetState extends State<AddressEditSheet> {
  late TextEditingController _addressController;
  late TextEditingController _cityController;
  late TextEditingController _postcodeController;
  late TextEditingController _countryController;

  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController(text: widget.initialAddress.address);
    _cityController = TextEditingController(text: widget.initialAddress.city);
    _postcodeController = TextEditingController(text: widget.initialAddress.postcode);
    _countryController = TextEditingController(text: widget.initialAddress.country);
  }

  @override
  void dispose() {
    _addressController.dispose();
    _cityController.dispose();
    _postcodeController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    final updatedAddress = Shippingaddress(
      address: _addressController.text,
      city: _cityController.text,
      postcode: _postcodeController.text,
      country: _countryController.text,
    );
    
    widget.onSave(updatedAddress);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.4, 
      maxChildSize: 0.9, 

      builder: (_, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Adresse de livraison',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              
              const Divider(),
              
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildAddressField('Pays', _countryController, 
                        trailing: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade200,
                          ),
                          child: const Icon(Icons.add, color: Colors.black54),
                        )
                      ),
                      const SizedBox(height: 16),
                      
                      _buildAddressField('Adresse', _addressController),
                      const SizedBox(height: 16),
                      
                      _buildAddressField('Ville', _cityController),
                      const SizedBox(height: 16),
                      
                      _buildAddressField('Code postal', _postcodeController),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: _saveChanges,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.deepBlue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: const Text(
                      'Enregistrer les modifications',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAddressField(String label, TextEditingController controller, {Widget? trailing}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.all(16),
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                  ),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              if (trailing != null) Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: trailing,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

void showAddressEditSheet(
  BuildContext context, 
  Shippingaddress initialAddress,
  Function(Shippingaddress) onSave,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return AddressEditSheet(
        initialAddress: initialAddress,
        onSave: onSave,
      );
    },
  );
}