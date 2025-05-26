import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/Auth/Controllers/profile_controller.dart';
import 'package:flutter_application_1/features/Auth/models/user_model.dart';
import 'package:provider/provider.dart';
import '../../../config/theme/Colors.dart';
import 'EditProfileForm.dart';

class EditProfileCard extends StatefulWidget {
  final User user;
  final VoidCallback onClose;

  const EditProfileCard({
    super.key,
    required this.user,
    required this.onClose,
  });

  @override
  State<EditProfileCard> createState() => _EditProfileCardState();
}

class _EditProfileCardState extends State<EditProfileCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.deepBlue.withOpacity(0.05),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Modifier mon compte',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.deepBlue,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: AppColors.deepBlue),
                  onPressed: widget.onClose,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            child: EditProfileForm(
              user: widget.user,
              onSave: (updatedUser) {
                Provider.of<ProfileController>(context, listen: false).user = updatedUser;
                widget.onClose();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Profil mis à jour avec succès'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              onCancel: widget.onClose,
            ),
          ),
        ],
      ),
    );
  }
}
