import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/theme/Colors.dart';
import 'package:flutter_application_1/features/Achats/pages/CheckoutPage.dart';
import 'package:flutter_application_1/features/Achats/panierCuPage.dart';

class CompactCartView extends StatefulWidget {
  final List<Map<String, dynamic>> cartProducts;

  const CompactCartView({
    Key? key,
    required this.cartProducts,
  }) : super(key: key);

  @override
  State<CompactCartView> createState() => _CompactCartViewState();
}

class _CompactCartViewState extends State<CompactCartView> {
  late List<Map<String, dynamic>> products;

  @override
  void initState() {
    super.initState();
    products = List.from(widget.cartProducts);
    
    for (var product in products) {
      if (!product.containsKey('isSelected')) {
        product['isSelected'] = true; 
      }
    }
  }

  void incrementQuantity(int index) {
    setState(() {
      int currentQuantity = int.parse(products[index]['quantity'].toString());
      products[index]['quantity'] = (currentQuantity + 1).toString();
    });
  }

  void decrementQuantity(int index) {
    setState(() {
      int currentQuantity = int.parse(products[index]['quantity'].toString());
      if (currentQuantity > 1) {
        products[index]['quantity'] = (currentQuantity - 1).toString();
      }
    });
  }

  void toggleSelection(int index) {
    setState(() {
      products[index]['isSelected'] = !(products[index]['isSelected'] as bool);
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = products.fold(
      0,
      (sum, product) {
        bool isSelected = product['isSelected'] ?? true;
        if (isSelected) {
          return sum + (double.parse(product['price'].toString()) * int.parse(product['quantity'].toString()));
        }
        return sum;
      },
    );
    double deliveryFee = 25.0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
          titleSpacing: 0,
          title: Text(
            'Panier',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(Icons.close, color: Colors.grey.shade700, size: 28),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 15),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                final bool isSelected = product['isSelected'] ?? true;
                
                return Container(
                  margin: EdgeInsets.only(bottom: 15),
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Stack(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 2,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Opacity(
                                opacity: isSelected ? 1.0 : 0.5,
                                child: Image.asset(
                                  product['imageUrl'].toString(),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product['title'].toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isSelected ? Colors.black : Colors.grey,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Container(
                                      height: 32,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: isSelected ? Colors.grey.shade300 : Colors.grey.shade200,
                                        ),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            width: 28,
                                            child: IconButton(
                                              padding: EdgeInsets.zero,
                                              icon: Icon(
                                                Icons.remove, 
                                                size: 16,
                                                color: isSelected 
                                                    ? (int.parse(product['quantity'].toString()) > 1 
                                                        ? Colors.black 
                                                        : Colors.grey.shade400)
                                                    : Colors.grey.shade400,
                                              ),
                                              onPressed: isSelected 
                                                  ? () => decrementQuantity(index) 
                                                  : null,
                                            ),
                                          ),
                                          Container(
                                            width: 22,
                                            alignment: Alignment.center,
                                            child: Text(
                                              product['quantity'].toString(),
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: isSelected ? Colors.black : Colors.grey,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 28,
                                            child: IconButton(
                                              padding: EdgeInsets.zero,
                                              icon: Icon(
                                                Icons.add, 
                                                size: 16,
                                                color: isSelected ? Colors.black : Colors.grey.shade400,
                                              ),
                                              onPressed: isSelected 
                                                  ? () => incrementQuantity(index) 
                                                  : null,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      '${double.parse(product['price'].toString()).toStringAsFixed(2)}DHS',
                                      style: TextStyle(
                                        color: isSelected ? Color(0xFF00438F) : Colors.grey,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      Positioned(
                        top: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () => toggleSelection(index),
                          child: Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              color: isSelected ? Color(0xFF00438F) : Colors.grey.shade300,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              isSelected ? Icons.check : Icons.close,
                              color: Colors.white,
                              size: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(16, 12, 16, 16),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 4,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Prix du produit',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Text(
                      '${totalPrice.toStringAsFixed(0)} DHS',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Livraison',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Text(
                      '${deliveryFee.toStringAsFixed(0)} DHS',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Divider(height: 0),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Soustotal',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      '${(totalPrice + deliveryFee).toStringAsFixed(0)} DHS',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      final List<CartItem> selectedItems = products
                          .where((product) => product['isSelected'] == true)
                          .map((product) => CartItem(
                                id: product['id'] ?? '1',
                                productName: product['title'],
                                imagePath: product['imageUrl'],
                                price: double.parse(product['price'].toString()),
                                quantity: int.parse(product['quantity'].toString()),
                                isSelected: true,
                              ))
                          .toList();

                      final total = totalPrice + deliveryFee;
                      
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CheckoutPage(
                            items: selectedItems,
                            total: total,
                            deliveryFee: deliveryFee,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.deepBlue,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'COMMANDER',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}