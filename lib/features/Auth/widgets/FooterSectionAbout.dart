import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/theme/Colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.deepBlue, 
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCustomExpansionTile(
            title: "Catégories",
            children: const [
              "Téléphone & objets connectés",
              "Tv, Son, Photo",
              "Informatique & Gaming",
              "Électroménager",
              "Maison - Cuisine - Déco",
              "Beauté - Santé",
              "Vêtements - Chaussures - Bijoux - Accessoires",
              "Bébé & Jouets",
              "Sport",
              "Auto Moto",
              "Brico - Jardin - Animalerie",
              "Librairie",
            ],
          ),
          _buildCustomExpansionTile(
            title: "Découvrez la Marketplace",
            children: const [],
          ),
          _buildCustomExpansionTile(
            title: "Informations légales",
            children: const [],
          ),
          _buildCustomExpansionTile(
            title: "Nos marques",
            children: const [],
          ),
          const SizedBox(height: 12),
          Center(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.white),
              ),
              onPressed: () {},
              child: const Text(
                "Devenir vendeur",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Wrap(
              alignment: WrapAlignment.center, 
              spacing: 14,
              runSpacing: 6,
              children: const [
                FeatureIcon(icon: Icons.verified, label: "Produits 100%\nauthentiques"),
                FeatureIcon(icon: Icons.local_shipping, label: "Livraison partout\nau Maroc"),
                FeatureIcon(icon: Icons.replay, label: "Satisfait ou\nremboursé"),
                FeatureIcon(icon: Icons.public, label: "Offre nationale et\ninternationale"),
              ],
            ),
          ),

          const SizedBox(height: 12),
          const Text(
            "Modes de paiement",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 8),
          Center(
            child:Wrap(
            alignment: WrapAlignment.center,
            spacing: 16,
            children: [
              Image.asset("assets/CartBanq/cmi.jpeg", height: 32, errorBuilder: (_, __, ___) {
                return const Icon(Icons.error, color: Colors.white);
              }),
              Image.asset("assets/CartBanq/visa.png", height: 32, errorBuilder: (_, __, ___) {
                return const Icon(Icons.error, color: Colors.white);
              }),
              Image.asset("assets/CartBanq/mastercard.jpeg", height: 32, errorBuilder: (_, __, ___) {
                return const Icon(Icons.error, color: Colors.white);
              }),
              Image.asset("assets/CartBanq/maestro.png", height: 32, errorBuilder: (_, __, ___) {
                return const Icon(Icons.error, color: Colors.white);
              }),
              Image.asset("assets/CartBanq/cash.jpeg", height: 32, errorBuilder: (_, __, ___) {
                return const Icon(Icons.error, color: Colors.white);
              }),
            ],
          ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(
              "© 2025 – dev.dibitel.com",
              style: TextStyle(color: Colors.white.withOpacity(0.7)),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.facebook, color: Colors.white),
              SizedBox(width: 12),
              Icon(FontAwesomeIcons.instagram, color: Colors.pink),
              SizedBox(width: 12),
              Icon(Icons.youtube_searched_for, color: Colors.white),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCustomExpansionTile({required String title, required List<String> children}) {
    return Theme(
      data: ThemeData(
        dividerColor: Colors.transparent,
      ),
      child: ExpansionTile(
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        childrenPadding: const EdgeInsets.symmetric(horizontal: 16),
        iconColor: Colors.white,
        collapsedIconColor: Colors.white,
        children: children
            .map(
              (child) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  child,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class FeatureIcon extends StatelessWidget {
  final IconData icon;
  final String label;

  const FeatureIcon({required this.icon, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 32, color: Colors.white),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white, fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}