import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/widgets/PriceFilterWidget.dart';
import 'package:flutter_application_1/features/Achats/panierCuPage.dart';
import 'package:flutter_application_1/features/Auth/pages/auth/login_page.dart';
import 'package:flutter_application_1/features/Header/DetailHeader.dart';
import 'package:flutter_application_1/NewaBottomNavBar.dart';
import 'package:flutter_application_1/features/Promotions/PromotionsPage.dart';
import 'package:flutter_application_1/features/categorie/Categories.dart';
import 'package:flutter_application_1/features/home/pages/Home.dart';
import 'package:flutter_application_1/features/home/pages/ProductsPage.dart';
import 'package:flutter_application_1/model/Products.dart';

class Productcategories extends StatefulWidget {
  final String categoryName;

  const Productcategories({
    required this.categoryName,
    Key? key,
  }) : super(key: key);

  @override
  State<Productcategories> createState() => _ProductcategoriesState();
}

class _ProductcategoriesState extends State<Productcategories> {
  int _selectedIndex = 2;
  bool _isCategoriesPageShown = false;
    bool isFilterActive = false;

  double minPrice = 0;
  double maxPrice = 100;
  double selectedMinPrice = 0;
  double selectedMaxPrice = 100;

  List<String> selectedBrands = [];
  List<String> selectedSizes = [];
  double selectedRating = 0;

  void _applyFilters({
  required double min,
  required double max,
  List<String>? brands,
  List<String>? sizes,
  double? rating,
}) {
  setState(() {
    selectedMinPrice = min;
    selectedMaxPrice = max;
    selectedBrands = brands ?? [];
    selectedSizes = sizes ?? [];
    selectedRating = rating ?? 0;

    isFilterActive = selectedMinPrice != minPrice || selectedMaxPrice != maxPrice;
  });
}


  void _onTabSelected(int index) {
    setState(() {
      if (_selectedIndex == 2 && index == 2) {
        _isCategoriesPageShown = !_isCategoriesPageShown;
      } else {
        _selectedIndex = index;
        _isCategoriesPageShown = false;
      }
    });
  }
  void _showPriceFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: EdgeInsets.only(top: 20),
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: PriceFilterWidget(
              minPrice: 0,
              maxPrice: 100,
              initialMinValue: minPrice,
              initialMaxValue: maxPrice,
              onPriceRangeChanged: (min, max) => _applyFilters(
                min: min, 
                max: max, 
                brands: selectedBrands,
                sizes: selectedSizes,
                rating: selectedRating
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPage() {

    switch (_selectedIndex) {
      case 0:
        return const Home();
      case 1:
        return const PromotionsPage();
      case 2:
        return _isCategoriesPageShown
            ? const CategoriesPage()
            : _buildProductPage();
      case 3:
        return const Paniercupage();
      case 4:
        return const LoginPage();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildProductPage() {
    if (_productsByCategory.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Aucune catégorie ou produit disponible.",
            style: TextStyle(fontSize: 18, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DetailHeader(),
          const SizedBox(height: 10),
        Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Row(
            children: [
              const Icon(Icons.arrow_back_ios, size: 18, color: Colors.black),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  widget.categoryName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      GestureDetector(
        onTap: _showPriceFilterBottomSheet,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: isFilterActive ? Colors.blue.shade900 : Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Icon(
                Icons.filter_list,
                size: 18,
                color: isFilterActive ? Colors.white : Colors.black87,
              ),
              const SizedBox(width: 6),
              Text(
                "Filtres",
                style: TextStyle(
                  color: isFilterActive ? Colors.white : Colors.black87,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  ),
),




          const SizedBox(height: 10),
          ..._productsByCategory.entries.map((entry) {
            final String categoryTitle = entry.key;
            final List<Product> products = entry.value
                .map((productData) => Product(
                      imagePath: productData['imagePath'],
                      productName: productData['productName'],
                      price: productData['price'].toString(),
                      type: productData['type'],
                    ))
                .where((product) {
                  final price = double.tryParse(product.price) ?? 0;
                  return price >= selectedMinPrice && price <= selectedMaxPrice;
                })
                .toList();

            return products.isEmpty
                ? const SizedBox.shrink()
                : Productspage(
                    title: categoryTitle,
                    products: products,
                  );
          }).toList(),
        ],
      ),
    );
  }

  final Map<String, List<Map<String, dynamic>>> _productsByCategory = {
    'Pharmacie': [
      {
        'type': 'SAMSUNG',
        'productName': 'Galaxy A52',
        'imagePath': 'assets/Products/Product6.png',
        'price': 320.0,
        'originalPrice': 350.0,
      },
      {
        'type': 'APPLE',
        'productName': 'iPhone 13',
        'imagePath': 'assets/Products/Product7.png',
        'price': 999.0,
        'originalPrice': 1099.0,
      },
      {
        'type': 'CERAVE',
        'productName': 'DOLOGEL Gel Apaisant',
        'imagePath': 'assets/Products/Product1.png',
        'price': 30.0,
      },
      {
        'type': 'CERAVE',
        'productName': 'CERAVE Hydratant',
        'imagePath': 'assets/Products/Product2.png',
        'price': 25.0,
      },
      {
        'type': 'CERAVE',
        'productName': 'PAYOT Crème',
        'imagePath': 'assets/Products/Product4.png',
        'price': 35.0,
      },
      {
        'type': 'CERAVE',
        'productName': 'ANIAN Lotion',
        'imagePath': 'assets/Products/Product5.png',
        'price': 15.0,
      },
    ],
    'Beauté & Santé': [
            {
        'type': 'CERAVE',
        'productName': 'PAYOT Crème',
        'imagePath': 'assets/Products/Product4.png',
        'price': 35.0,
      },
      {
        'type': 'CERAVE',
        'productName': 'ANIAN Lotion',
        'imagePath': 'assets/Products/Product5.png',
        'price': 15.0,
      },
      {
        'type': 'SAMSUNG',
        'productName': 'Galaxy A52',
        'imagePath': 'assets/Products/Product6.png',
        'price': 320.0,
        'originalPrice': 350.0,
      },
      {
        'type': 'APPLE',
        'productName': 'iPhone 13',
        'imagePath': 'assets/Products/Product7.png',
        'price': 999.0,
        'originalPrice': 1099.0,
      },

            {
        'type': 'CERAVE',
        'productName': 'DOLOGEL Gel Apaisant',
        'imagePath': 'assets/Products/Product1.png',
        'price': 30.0,
      },
      {
        'type': 'CERAVE',
        'productName': 'CERAVE Hydratant',
        'imagePath': 'assets/Products/Product2.png',
        'price': 25.0,
      },
    ],
    'Téléphone & Objet Connecté': [
                  {
        'type': 'CERAVE',
        'productName': 'PAYOT Crème',
        'imagePath': 'assets/Products/Product4.png',
        'price': 35.0,
      },
      {
        'type': 'CERAVE',
        'productName': 'ANIAN Lotion',
        'imagePath': 'assets/Products/Product5.png',
        'price': 15.0,
      },
      {
        'type': 'SAMSUNG',
        'productName': 'Galaxy A52',
        'imagePath': 'assets/Products/Product6.png',
        'price': 320.0,
        'originalPrice': 350.0,
      },
      {
        'type': 'APPLE',
        'productName': 'iPhone 13',
        'imagePath': 'assets/Products/Product7.png',
        'price': 999.0,
        'originalPrice': 1099.0,
      },
            {
        'type': 'CERAVE',
        'productName': 'DOLOGEL Gel Apaisant',
        'imagePath': 'assets/Products/Product1.png',
        'price': 30.0,
      },
      {
        'type': 'CERAVE',
        'productName': 'CERAVE Hydratant',
        'imagePath': 'assets/Products/Product2.png',
        'price': 25.0,
      },

    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildPage(),
      bottomNavigationBar: NewaBottomNavBar(
        selectedIndex: _selectedIndex,
        onTabSelected: _onTabSelected,
      ),
    );
  }
}
