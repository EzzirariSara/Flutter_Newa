import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/theme/Colors.dart';

class Helpbutton extends StatelessWidget {
  const Helpbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.deepBlue),
        ),
        child: TextButton(
          onPressed: () {},
          child: Text(
            'Besoin d\'aide ?',
            style: TextStyle(
              color: AppColors.deepBlue,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}