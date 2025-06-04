import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/theme/Colors.dart';
import 'package:flutter_application_1/features/Notifications/widgets/EmptyNotificationView.dart';
import 'package:flutter_application_1/features/Notifications/widgets/NotificationCard.dart';
import 'package:flutter_application_1/features/Notifications/widgets/NotificationItem.dart';
import 'package:flutter_application_1/features/Promotions/PromotionsPage.dart';
import 'package:flutter_application_1/HomePage.dart'; 

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  final List<NotificationItem> _notifications = [
    NotificationItem(
      title: "Offre spéciale pour vous",
      description: "Profitez de 20% de réduction sur votre crème hydratante préférée",
      time: "Il y a 2 heures",
      image: "assets/images/cream.png",
      type: NotificationType.promotion,
      isRead: false,
    ),
    NotificationItem(
      title: "Votre commande a été expédiée",
      description: "Votre commande #12345 sera livrée demain",
      time: "Il y a 5 heures",
      image: "assets/images/package.png",
      type: NotificationType.shipping,
      isRead: true,
    ),
    NotificationItem(
      title: "Nouveau produit disponible",
      description: "Découvrez notre nouveau sérum anti-âge à l'acide hyaluronique",
      time: "Hier",
      image: "assets/images/serum.png",
      type: NotificationType.newProduct,
      isRead: false,
    ),
    NotificationItem(
      title: "N'oubliez pas de réapprovisionner",
      description: "Votre nettoyant visage sera bientôt épuisé selon votre routine",
      time: "Il y a 2 jours",
      image: "assets/images/cleanser.png",
      type: NotificationType.restock,
      isRead: true,
    ),
  ];

  List<NotificationItem> get _unreadNotifications => 
      _notifications.where((notification) => !notification.isRead).toList();

  List<NotificationItem> get _promotionNotifications => 
      _notifications.where((notification) => notification.type == NotificationType.promotion).toList();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF3F0),
      appBar: AppBar(
        title: const Text(
          "Notifications",
          style: TextStyle(
            color: Color(0xFF3A2E39),
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                for (var notification in _notifications) {
                  notification.isRead = true;
                }
              });
            },
            child: const Text(
              "Tout marquer comme lu",
              style: TextStyle(
                color: AppColors.deepBlue,
                fontSize: 12,
              ),
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.deepBlue,
          unselectedLabelColor: const Color.fromARGB(255, 156, 162, 193),
          indicatorColor: AppColors.deepBlue,
          tabs: const [
            Tab(text: "Toutes"),
            Tab(text: "Non lues"),
            Tab(text: "Promotions"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildNotificationsList(_notifications),
          _buildNotificationsList(_unreadNotifications),
          _buildNotificationsList(_promotionNotifications),
        ],
      ),
    );
  }

  Widget _buildNotificationsList(List<NotificationItem> notifications) {
    if (notifications.isEmpty) {
      return const EmptyNotificationView();
    }

    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return NotificationCard(
          notification: notification,
          onTap: () {
            setState(() {
              notification.isRead = true;
            });
            
            if (notification.type == NotificationType.promotion) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => Homepage(initialIndex: 1),
                ),
                (route) => false, 
              );
            }
            if (notification.type == NotificationType.newProduct) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => Homepage(initialIndex: 0),
                ),
                (route) => false, 
              );
            }

          },
        );
      },
    );
  }
}