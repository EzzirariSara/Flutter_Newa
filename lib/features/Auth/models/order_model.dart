class Order {
  final String id;
  final DateTime date;
  final String status;
  final double total;
  final List<OrderItem> items;
  final String deliveryAddress;
  final String trackingNumber;

  Order({
    required this.id,
    required this.date,
    required this.status,
    required this.total,
    required this.items,
    required this.deliveryAddress,
    required this.trackingNumber,
  });
}

class OrderItem {
  final String productId;
  final String name;
  final String imageUrl;
  final double price;
  final int quantity;

  OrderItem({
    required this.productId,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });
}