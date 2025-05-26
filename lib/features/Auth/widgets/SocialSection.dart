import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/Auth/widgets/SocialIcon.dart';

class SocialSection extends StatelessWidget {
  const SocialSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            'Suivez-nous',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            children: [
              SocialIcon(icon: Icons.facebook, onTap: () {}),
              const SizedBox(width: 20),
              SocialIcon(icon: Icons.camera_alt_outlined, onTap: () {}),
              const SizedBox(width: 20),
              SocialIcon(icon: Icons.play_circle_outline, onTap: () {}),

            ],
          ),
        ),
      ],
    );
  }
}