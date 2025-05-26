import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/theme/Colors.dart';
import 'package:flutter_application_1/features/Auth/models/order_model.dart';
import 'package:flutter_application_1/features/Auth/pages/order/OrderDetailsPage.dart';
import 'package:intl/intl.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({Key? key}) : super(key: key);

  @override
  _OrdersPageState createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<Order> _orders;
  final DateFormat dateFormatter = DateFormat('dd/MM/yyyy');

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _loadOrders();
  }

  void _loadOrders() {
    _orders = [
      Order(
        id: 'CMD-0012345',
        date: DateTime.now().subtract(const Duration(days: 2)),
        status: 'En cours',
        total: 356.50,
        items: [
          OrderItem(
            productId: 'P001',
            name: 'Crème hydratante visage',
            imageUrl: 'assets/Products/Product1.png',
            price: 129.90,
            quantity: 1,
          ),
          OrderItem(
            productId: 'P002',
            name: 'Shampoing doux',
            imageUrl: 'assets/Products/Product2.png',
            price: 75.50,
            quantity: 3,
          ),
        ],
        deliveryAddress: '27 Avenue Hassan II, Casablanca, 20000',
        trackingNumber: 'TRK-987654',
      ),
      Order(
        id: 'CMD-0012344',
        date: DateTime.now().subtract(const Duration(days: 8)),
        status: 'Livré',
        total: 245.80,
        items: [
          OrderItem(
            productId: 'P003',
            name: 'Sérum anti-âge',
            imageUrl: 'assets/Products/Product3.png',
            price: 245.80,
            quantity: 1,
          ),
        ],
        deliveryAddress: '27 Avenue Hassan II, Casablanca, 20000',
        trackingNumber: 'TRK-987653',
      ),
      Order(
        id: 'CMD-0012343',
        date: DateTime.now().subtract(const Duration(days: 15)),
        status: 'Annulé',
        total: 175.60,
        items: [
          OrderItem(
            productId: 'P004',
            name: 'Masque visage hydratant',
            imageUrl: 'assets/Products/Product4.png',
            price: 85.30,
            quantity: 1,
          ),
          OrderItem(
            productId: 'P005',
            name: 'Crème pour les mains',
            imageUrl: 'assets/Products/Product5.png',
            price: 45.15,
            quantity: 2,
          ),
        ],
        deliveryAddress: '27 Avenue Hassan II, Casablanca, 20000',
        trackingNumber: 'TRK-987652',
      ),
      Order(
        id: 'CMD-0012342',
        date: DateTime.now().subtract(const Duration(days: 20)),
        status: 'Expédié',
        total: 432.00,
        items: [
          OrderItem(
            productId: 'P006',
            name: 'Huile d\'argan pure',
            imageUrl: 'assets/Products/Product6.png',
            price: 145.00,
            quantity: 1,
          ),
          OrderItem(
            productId: 'P007',
            name: 'Nettoyant visage',
            imageUrl: 'assets/Products/Product7.png',
            price: 95.50,
            quantity: 3,
          ),
        ],
        deliveryAddress: '27 Avenue Hassan II, Casablanca, 20000',
        trackingNumber: 'TRK-987651',
      ),
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Order> _getFilteredOrders(String status) {
    if (status == 'Tous') {
      return _orders;
    }
    return _orders.where((order) => order.status == status).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'En cours':
        return Colors.blue;
      case 'Livré':
        return Colors.green;
      case 'Annulé':
        return Colors.red;
      case 'Expédié':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Mes commandes',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.deepBlue,
          unselectedLabelColor: Colors.grey,
          indicatorColor: AppColors.deepBlue,
          tabs: const [
            Tab(text: 'Tous'),
            Tab(text: 'En cours'),
            Tab(text: 'Livré'),
            Tab(text: 'Annulé'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOrderList(_getFilteredOrders('Tous')),
          _buildOrderList(_getFilteredOrders('En cours')),
          _buildOrderList(_getFilteredOrders('Livré')),
          _buildOrderList(_getFilteredOrders('Annulé')),
        ],
      ),
    );
  }

  Widget _buildOrderList(List<Order> orders) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_bag_outlined, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'Aucune commande trouvée',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: orders.length,
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        final order = orders[index];
        return _buildOrderCard(order);
      },
    );
  }

  Widget _buildOrderCard(Order order) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderDetailsPage(order: order),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Commande #${order.id}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _getStatusColor(order.status).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      order.status,
                      style: TextStyle(
                        color: _getStatusColor(order.status),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Date: ${dateFormatter.format(order.date)}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Icon(
                    Icons.payments_outlined,
                    size: 16,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Total: ${order.total.toStringAsFixed(2)} Dh',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(
                    Icons.list_alt,
                    size: 16,
                    color: AppColors.deepBlue,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '${order.items.length} article${order.items.length > 1 ? 's' : ''}',
                    style: const TextStyle(
                      color: AppColors.deepBlue,
                      fontSize: 14,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: const [
                      Text(
                        'Voir détails',
                        style: TextStyle(
                          color: AppColors.deepBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                        color: AppColors.deepBlue,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}