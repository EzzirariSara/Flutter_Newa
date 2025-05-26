class User {
  final String id;
  String name;
  String email;
  String phone;
  String address;
  String city;
  String postalCode;
  bool isPremium;
  Map<String, bool> preferences;
  final String gender; 

  User({
    required this.id,
    required this.name,
    required this.email,
    this.phone = "",
    this.address = "",
    this.city = "",
    this.postalCode = "",
    this.isPremium = false,
    Map<String, bool>? preferences,
    this.gender = '',
  }) : preferences = preferences ?? {
         'pushNotifications': true,
         'emailPromotions': false,
         'cartReminders': true,
       };

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      address: json['address'] ?? '',
      city: json['city'] ?? '',
      postalCode: json['postalCode'] ?? '',
      isPremium: json['isPremium'] ?? false,
      preferences: Map<String, bool>.from(json['preferences'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'city': city,
      'postalCode': postalCode,
      'isPremium': isPremium,
      'preferences': preferences,
    };
  }
}