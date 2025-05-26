import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/Paniers/pages/ShoppingCartPage.dart';
import 'package:flutter_application_1/config/theme/Colors.dart';
import 'package:flutter_application_1/features/Achats/pages/CheckoutPage.dart';
import 'package:flutter_application_1/features/Achats/panierCuPage.dart';

class InfoProducts extends StatefulWidget {
  final String imagePath;
  final String productName;
  final String price;

  const InfoProducts({
    Key? key,
    required this.imagePath,
    required this.productName,
    required this.price,
  }) : super(key: key);

  @override
  State<InfoProducts> createState() => _InfoProductsState();
}

class _InfoProductsState extends State<InfoProducts> {
  bool showFullDescription = false;
  bool isHoveringImage = false;
  TransformationController _transformationController = TransformationController();
  
  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  void showCartDrawer(BuildContext context) {
    final List<Map<String, dynamic>> cartItems = [
      {
        'imageUrl': 'assets/Products/Product1.png',
        'title': 'Pomegranate Shampoo',
        'price': '35.0',
        'quantity': '1',
      },
      {
        'imageUrl': 'assets/Products/Product2.png',
        'title': 'Argan Oil Conditioner',
        'price': '45.0',
        'quantity': '2',
      },
      {
        'imageUrl': 'assets/Products/Product3.png',
        'title': 'Olive Hair Mask',
        'price': '55.0',
        'quantity': '1',
      },
    ];

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Panier",
      barrierColor: Colors.black.withOpacity(0.3),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return const SizedBox.expand();
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: Align(
            alignment: Alignment.centerRight,
            child: Material(
              elevation: 16,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
              color: Colors.white,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 620,
                  child: CompactCartView(cartProducts: cartItems),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showImageDetailDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.all(10),
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.productName,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: InteractiveViewer(
                    transformationController: _transformationController,
                    minScale: 0.5,
                    maxScale: 4.0,
                    child: Image.asset(
                      widget.imagePath,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.zoom_in),
                        onPressed: () {
                          setState(() {
                            final newScale = _transformationController.value.getMaxScaleOnAxis() * 1.2;
                            _transformationController.value = Matrix4.diagonal3Values(
                              newScale, newScale, 1.0,
                            );
                          });
                        },
                      ),
                      SizedBox(width: 20),
                      IconButton(
                        icon: Icon(Icons.zoom_out),
                        onPressed: () {
                          setState(() {
                            final newScale = _transformationController.value.getMaxScaleOnAxis() / 1.2;
                            _transformationController.value = Matrix4.diagonal3Values(
                              newScale, newScale, 1.0,
                            );
                          });
                        },
                      ),
                      SizedBox(width: 20),
                      IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () {
                          setState(() {
                            _transformationController.value = Matrix4.identity();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final descriptionText =
        'Ideo urbs venerabilis post superbas efferatarum gentium cervices oppressas latasque leges fundamenta libertatis et retinacula sempiterna velut frugi parens et prudens et dives Caesaribus tamquam liberis suis regenda patrimonii iura permisit.';

    return Padding(
      padding: const EdgeInsets.all(6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          const SizedBox(height: 16),

          Center(
            child: MouseRegion(
              onEnter: (_) => setState(() => isHoveringImage = true),
              onExit: (_) => setState(() => isHoveringImage = false),
              child: GestureDetector(
                onTap: () => _showImageDetailDialog(context),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  transform: isHoveringImage 
                      ? Matrix4.diagonal3Values(1.1, 1.1, 1.0)
                      : Matrix4.identity(),
                  transformAlignment: Alignment.center,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(widget.imagePath, height: 300),
                      if (isHoveringImage)
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.zoom_in,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  widget.productName,
                  style: const TextStyle(
                    fontSize: 18, 
                    fontWeight: FontWeight.bold
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              
              Text(
                '${widget.price} DHS',
                style: const TextStyle(
                  fontSize: 18,
                  color: Color(0xFF00438F),
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    showCartDrawer(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.deepBlue, 
                    side: BorderSide(color: AppColors.deepBlue, width: 2),
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Ajouter au panier',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    final List<CartItem> items = [
                      CartItem(
                        id: '1',
                        productName: widget.productName,
                        imagePath: widget.imagePath,
                        price: double.parse(widget.price),
                        quantity: 1,
                        isSelected: true,
                      )
                    ];
                    final double total = double.parse(widget.price);
                    final double deliveryFee = 25.0;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CheckoutPage(
                          items: items,
                          total: total,
                          deliveryFee: deliveryFee,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.deepBlue,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Commander',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          const Text(
            'Description',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            descriptionText,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
            maxLines: showFullDescription ? null : 2,
            overflow: showFullDescription ? TextOverflow.visible : TextOverflow.ellipsis,
          ),
          TextButton(
            onPressed: () {
              setState(() {
                showFullDescription = !showFullDescription;
              });
            },
            child: Text(showFullDescription ? 'Voir moins' : 'Voir plus'),
          ),

          if (showFullDescription) ...[
            const SizedBox(height: 15),
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 245, 245, 245),
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '4.6',
                                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 4),
                              Text(
                                '/5',
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Basé sur 136 Notes',
                            style: TextStyle(fontSize: 12, color: Color(0xFF8C8C8C)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),

                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          int star = 5 - index;
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2),
                            child: Row(
                              children: [
                                Text('$star Étoile${star > 1 ? 's' : ''}'),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: LinearProgressIndicator(
                                    value: (star == 5)
                                        ? 0.7
                                        : (star == 4)
                                            ? 0.2
                                            : (star == 3)
                                                ? 0.05
                                                : 0.03,
                                    backgroundColor: Colors.grey.shade300,
                                    valueColor: const AlwaysStoppedAnimation<Color>(
                                        Color.fromARGB(255, 0, 0, 0)),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]
        ],
      ),
    );
  }
}