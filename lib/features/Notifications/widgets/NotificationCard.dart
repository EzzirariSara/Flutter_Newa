import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/theme/Colors.dart';
import 'package:flutter_application_1/features/Notifications/widgets/NotificationItem.dart';

class NotificationCard extends StatelessWidget {
  final NotificationItem notification;
  final VoidCallback onTap;

  const NotificationCard({
    Key? key,
    required this.notification,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color borderColor;
    Color iconBackgroundColor;
    Color iconColor;
    IconData iconData;

    switch (notification.type) {
      case NotificationType.promotion:
        borderColor = AppColors.deepBlue;
        iconBackgroundColor = AppColors.deepBlue.withOpacity(0.15);
        iconColor = AppColors.deepBlue;
        iconData = Icons.local_offer;
        break;
      case NotificationType.shipping:
        borderColor = const Color.fromARGB(255, 145, 160, 248);  
        iconBackgroundColor = const Color.fromARGB(255, 145, 160, 248).withOpacity(0.15);
        iconColor = const Color.fromARGB(255, 145, 160, 248);
        iconData = Icons.local_shipping;
        break;
      case NotificationType.newProduct:
        borderColor = const Color.fromARGB(255, 80, 85, 114);  
        iconBackgroundColor = const Color.fromARGB(255, 80, 85, 114).withOpacity(0.15);
        iconColor = const Color.fromARGB(255, 80, 85, 114);
        iconData = Icons.new_releases;
        break;
      case NotificationType.restock:
        borderColor = Color(0xFF6D597A); 
        iconBackgroundColor = Color(0xFF6D597A).withOpacity(0.15);
        iconColor = Color(0xFF6D597A);
        iconData = Icons.refresh;
        break;
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
        border: notification.isRead 
            ? Border.all(color: Colors.transparent)
            : Border.all(color: borderColor, width: 1.5),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: Stack(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: iconBackgroundColor,
              child: Icon(iconData, color: iconColor),
            ),
            if (!notification.isRead)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: borderColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
        title: Text(
          notification.title,
          style: TextStyle(
            fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
            color: Color(0xFF3A2E39),
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4),
            Text(
              notification.description,
              style: TextStyle(
                color: Color(0xFF6D6875),
                fontSize: 13,
              ),
            ),
            SizedBox(height: 8),
            Text(
              notification.time,
              style: TextStyle(
                color: Color(0xFF6D6875),
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}