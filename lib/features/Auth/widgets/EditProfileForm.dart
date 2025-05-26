import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/theme/Colors.dart';
import 'package:flutter_application_1/features/Auth/models/user_model.dart';

class EditProfileForm extends StatefulWidget {
  final User user;
  final Function(User) onSave;
  final VoidCallback? onCancel;

  const EditProfileForm({
    Key? key,
    required this.user,
    required this.onSave,
    this.onCancel,
  }) : super(key: key);

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  late TextEditingController _lastNameController;
  late TextEditingController _firstNameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  late TextEditingController _currentPasswordController;
  late TextEditingController _newPasswordController;

  String _selectedGender = 'Femme';
  bool _showPasswordFields = false;

  @override
  void initState() {
    super.initState();
    final nameParts = widget.user.name.split(' ');
    if (nameParts.length > 1) {
      _firstNameController = TextEditingController(text: nameParts.first);
      _lastNameController = TextEditingController(text: nameParts.last);
    } else {
      _firstNameController = TextEditingController(
        text: nameParts.isNotEmpty ? nameParts.first : '',
      );
      _lastNameController = TextEditingController();
    }

    _phoneController = TextEditingController(
      text: widget.user.phone.replaceAll('+212', ''),
    );
    _emailController = TextEditingController(text: widget.user.email);
    _currentPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _selectedGender = widget.user.gender ?? 'Femme';
  }

  @override
  void dispose() {
    _lastNameController.dispose();
    _firstNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  void _saveProfileChanges() {
    final updatedUser = User(
      id: widget.user.id,
      name: '${_firstNameController.text} ${_lastNameController.text}',
      email: _emailController.text,
      phone: '+212${_phoneController.text}',
      address: widget.user.address,
      city: widget.user.city,
      postalCode: widget.user.postalCode,
      isPremium: widget.user.isPremium,
      preferences: widget.user.preferences,
      gender: _selectedGender,
    );

    widget.onSave(updatedUser);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Radio(
                value: 'Monsieur',
                groupValue: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value.toString();
                  });
                },
                activeColor: AppColors.deepBlue,
                visualDensity: VisualDensity.compact,
              ),
              const Text(
                'Monsieur',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(width: 20),
              Radio(
                value: 'Femme',
                groupValue: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value.toString();
                  });
                },
                activeColor: AppColors.deepBlue,
                visualDensity: VisualDensity.compact,
              ),
              const Text(
                'Madame',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),

          const SizedBox(height: 16),

          TextField(
            controller: _lastNameController,
            decoration: const InputDecoration(
              labelText: 'Nom de famille',
              hintText: 'Nom de famille',
              border: UnderlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(vertical: 8),
            ),
          ),

          const SizedBox(height: 16),

          TextField(
            controller: _firstNameController,
            decoration: const InputDecoration(
              labelText: 'Prénom',
              hintText: 'Prénom',
              border: UnderlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(vertical: 8),
            ),
          ),

          const SizedBox(height: 16),

          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade400),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/images/morocco_flag.png',
                      width: 24,
                      height: 16,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          'icons/flags/png/ma.png',
                          package: 'country_icons',
                          width: 24,
                          height: 16,
                        );
                      },
                    ),
                    const SizedBox(width: 5),
                    const Text('+212', style: TextStyle(fontSize: 16)),
                    const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black,
                      size: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'Numéro de téléphone',
                    hintText: 'Numéro de téléphone',
                    border: UnderlineInputBorder(),
                    contentPadding: EdgeInsets.only(bottom: 8),
                    isDense: true,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: 'Email',
              hintText: 'Email',
              border: UnderlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(vertical: 8),
            ),
          ),

          const SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Modifier le mot de passe',
                style: TextStyle(fontSize: 15),
              ),
              Switch(
                value: _showPasswordFields,
                onChanged: (value) {
                  setState(() {
                    _showPasswordFields = value;
                  });
                },
                activeColor: AppColors.deepBlue,
              ),
            ],
          ),

          if (_showPasswordFields) ...[
            const SizedBox(height: 16),
            TextField(
              controller: _currentPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Mot de passe actuel',
                hintText: 'Mot de passe actuel',
                border: UnderlineInputBorder(),
                suffixIcon: Icon(Icons.remove_red_eye_outlined, size: 20),
                contentPadding: EdgeInsets.symmetric(vertical: 8),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Nouveau mot de passe',
                hintText: 'Nouveau mot de passe',
                border: UnderlineInputBorder(),
                suffixIcon: Icon(Icons.remove_red_eye_outlined, size: 20),
                contentPadding: EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ],

          const SizedBox(height: 30),

          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 45,
                  child: ElevatedButton(
                    onPressed: _saveProfileChanges,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.deepBlue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                    child: const Text('Enregistrer', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: 45,
                  child: OutlinedButton(
                    onPressed: widget.onCancel,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.deepBlue,
                      side: const BorderSide(color: AppColors.deepBlue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                    child: const Text('Annuler', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Center(
            child: TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Supprimer mon compte'),
                    content: const Text(
                      'Êtes-vous sûr de vouloir supprimer votre compte ? Cette action est irréversible.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Annuler'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Supprimer',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: const Text(
                'Supprimer mon compte',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}