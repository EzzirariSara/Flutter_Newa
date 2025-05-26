enum NotificationType {
  promotion,
  shipping,
  newProduct,
  restock,
}

class NotificationItem {
  final String title;
  final String description;
  final String time;
  final String image;
  final NotificationType type;
  bool isRead;

  NotificationItem({
    required this.title,
    required this.description,
    required this.time,
    required this.image,
    required this.type,
    this.isRead = false,
  });
}