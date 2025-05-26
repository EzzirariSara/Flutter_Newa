import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/theme/Colors.dart';

class EmptyNotificationView extends StatelessWidget {
  const EmptyNotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off_outlined,
            size: 64,
            color: AppColors.deepBlue.withOpacity(0.7)
          ),
          SizedBox(height: 16),
          Text(
            "Aucune notification",
            style: TextStyle(
              color: Color(0xFF3A2E39),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}