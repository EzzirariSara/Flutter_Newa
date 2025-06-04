import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/theme/Colors.dart';
import 'package:url_launcher/url_launcher.dart';

class AssistancePage extends StatelessWidget {
  const AssistancePage({super.key});

  void _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.deepBlue,
        title: const Text('Assistance',
            style: TextStyle(
              color: Colors.white,
              
            )),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/Assistance/Assistance.png',
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: 200,
                  color: Colors.black.withOpacity(0.5),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Bienvenue dans votre espace\nassistance NEWA',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        '🕒  7 jours / 7 de 9h à 21h',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.deepBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          _launchURL('https://www.Newa.ma/faq');
                        },
                        child: const Text('Consultez notre FAQ'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Contactez-nous',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ContactOption(
                    icon: Icons.history,
                    text: 'Historique des demandes',
                    onTap: () {
                    },
                  ),
                  ContactOption(
                    icon: Icons.phone,
                    text: 'Par Téléphone',
                    onTap: () {
                      _launchURL('tel:+212522123456'); 
                    },
                  ),
                  ContactOption(
                    icon: Icons.message,
                    text: 'Par WhatsApp',
                    onTap: () {
                      _launchURL('https://wa.me/212612345678'); 
                    },
                  ),
                  ContactOption(
                    icon: Icons.email,
                    text: 'Par mail',
                    onTap: () {
                      _launchURL('mailto:support@marjanemall.ma');
                    },
                  ),
                ],
              ),
            ),
            Divider(color: Colors.grey[300], thickness: 1),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Sur nos réseaux sociaux',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.facebook, color: AppColors.deepBlue),
                        onPressed: () {
                          _launchURL('https://www.facebook.com/marjanemall');
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.camera_alt, color: AppColors.deepBlue),
                        onPressed: () {
                          _launchURL('https://www.instagram.com/marjanemall');
                        },
                      ),
                    ],
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

class ContactOption extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const ContactOption({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(
          leading: Icon(icon, color: AppColors.deepBlue),
          title: Text(text),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        ),
      ),
    );
  }
}
