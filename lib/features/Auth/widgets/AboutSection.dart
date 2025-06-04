import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/Auth/Controllers/auth_controller.dart';
import 'package:flutter_application_1/features/Auth/pages/About/AboutPage.dart';
import 'package:flutter_application_1/features/Auth/pages/About/PrivacyPolicySheet.dart';
import 'package:flutter_application_1/features/Auth/pages/About/TermsAndConditionsPage.dart';
import 'package:flutter_application_1/features/Auth/pages/auth/login_page.dart';
import 'package:flutter_application_1/features/Auth/widgets/InfoItem.dart';
import 'package:provider/provider.dart';
class Aboutsection extends StatelessWidget {
  const Aboutsection({super.key});

  @override
  Widget build(BuildContext context) {
    void _logout() {
      final authController = Provider.of<AuthController>(context, listen: false);
      authController.logout();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            'À propos de nous',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
InfoItem(
  icon: Icons.info_outline,
  title: 'À propos de l\'application',
  onTap: () => showAboutModal(context),

),
        const Divider(height: 1, indent: 20, endIndent: 20),
  
  InfoItem(
          icon: Icons.share_outlined,
          title: 'Partager l\'application',
          onTap: () {
          },
        ),
        const Divider(height: 1, indent: 20, endIndent: 20),

        InfoItem(
  icon: Icons.info_outline,
  title: 'Conditions générales d\'utilisation',
  onTap: () => TermsAndConditionsSheet(context),
  
),



        const Divider(height: 1, indent: 20, endIndent: 20),
        InfoItem(
          icon: Icons.lock_outline,
          title: 'Politique de confidentialité',
          onTap: () => PrivacyPolicySheet(context),
        ),
        const Divider(height: 1, indent: 20, endIndent: 20),
        InfoItem(
          icon: Icons.power_settings_new,
          title: 'Déconnexion',
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            );
          },
        ),

      ],
    );
  }
}
