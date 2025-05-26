import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/profile_controller.dart';
import '../../models/user_model.dart';
import '../../widgets/profile_widgets.dart';

class PersonalInfoSection extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;

  const PersonalInfoSection({
    Key? key,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileController = Provider.of<ProfileController>(context);
    final isEditing = profileController.isEditing;

    return ProfileSectionContainer(
      title: 'Informations personnelles',
      icon: Icons.person,
      children: [
        ProfileFormField(
          controller: nameController,
          label: 'Nom complet',
          enabled: isEditing,
          prefixIcon: Icons.person_outline,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez entrer votre nom';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        ProfileFormField(
          controller: emailController,
          label: 'Email',
          enabled: isEditing,
          prefixIcon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez entrer votre email';
            }
            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
              return 'Veuillez entrer un email valide';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        ProfileFormField(
          controller: phoneController,
          label: 'Téléphone',
          enabled: isEditing,
          prefixIcon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez entrer votre numéro de téléphone';
            }
            return null;
          },
        ),
      ],
    );
  }
}

class AddressSection extends StatelessWidget {
  final TextEditingController addressController;
  final TextEditingController cityController;
  final TextEditingController postalCodeController;

  const AddressSection({
    Key? key,
    required this.addressController,
    required this.cityController,
    required this.postalCodeController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileController = Provider.of<ProfileController>(context);
    final isEditing = profileController.isEditing;

    return ProfileSectionContainer(
      title: 'Adresse de livraison',
      icon: Icons.location_on,
      children: [
        ProfileFormField(
          controller: addressController,
          label: 'Adresse',
          enabled: isEditing,
          prefixIcon: Icons.home_outlined,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Veuillez entrer votre adresse';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: ProfileFormField(
                controller: cityController,
                label: 'Ville',
                enabled: isEditing,
                prefixIcon: Icons.location_city_outlined,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre ville';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ProfileFormField(
                controller: postalCodeController,
                label: 'Code postal',
                enabled: isEditing,
                prefixIcon: Icons.markunread_mailbox_outlined,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer votre code postal';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class PreferencesSection extends StatelessWidget {
  const PreferencesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileController = Provider.of<ProfileController>(context);
    final isEditing = profileController.isEditing;
    final user = profileController.user;
    
    if (user == null) return Container();

    void updatePreference(String key, bool value) {
      if (isEditing) {
        profileController.updatePreference(key, value);
      }
    }

    return ProfileSectionContainer(
      title: 'Préférences',
      icon: Icons.settings,
      children: [
        ProfileSwitchTile(
          title: 'Notifications push',
          subtitle: 'Recevoir des alertes et mises à jour',
          icon: Icons.notifications_outlined,
          value: user.preferences['pushNotifications'] ?? true,
          onChanged: isEditing 
              ? (value) => updatePreference('pushNotifications', value) 
              : null,
        ),
        const ProfileDivider(),
        ProfileSwitchTile(
          title: 'Emails promotionnels',
          subtitle: 'Recevoir nos offres et nouveautés',
          icon: Icons.mail_outline,
          value: user.preferences['emailPromotions'] ?? false,
          onChanged: isEditing 
              ? (value) => updatePreference('emailPromotions', value) 
              : null,
        ),
        const ProfileDivider(),
        ProfileSwitchTile(
          title: 'Rappels de panier',
          subtitle: 'Rappels pour les articles dans votre panier',
          icon: Icons.shopping_cart_outlined,
          value: user.preferences['cartReminders'] ?? true,
          onChanged: isEditing 
              ? (value) => updatePreference('cartReminders', value) 
              : null,
        ),
      ],
    );
  }
}

class SecuritySection extends StatelessWidget {
  const SecuritySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProfileSectionContainer(
      title: 'Sécurité',
      icon: Icons.security,
      children: [
        ProfileActionTile(
          title: 'Changer le mot de passe',
          icon: Icons.lock_outline,
          onTap: () {
          },
        ),
        const ProfileDivider(),
        ProfileActionTile(
          title: 'Paramètres de confidentialité',
          icon: Icons.visibility_outlined,
          onTap: () {
          },
        ),
        // const ProfileDivider(),
        // ProfileActionTile(
        //   title: 'Appareils connectés',
        //   icon: Icons.devices_outlined,
        //   onTap: () {
        //   },
        // ),
      ],
    );
  }
}

class LogoutButton extends StatelessWidget {
  final VoidCallback onLogout;
  
  const LogoutButton({
    Key? key,
    required this.onLogout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Déconnexion'),
              content: const Text('Êtes-vous sûr de vouloir vous déconnecter?'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Annuler'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    onLogout();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Déconnexion'),
                ),
              ],
            ),
          );
        },
        icon: const Icon(Icons.logout, color: Colors.white),
        label: const Text(
          'Déconnexion',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}