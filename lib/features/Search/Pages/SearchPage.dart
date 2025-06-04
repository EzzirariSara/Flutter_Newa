import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/theme/Colors.dart';
import 'package:flutter_application_1/core/widgets/PriceFilterWidget.dart';
import 'package:flutter_application_1/core/widgets/ProductFilterBar.dart';
import 'package:flutter_application_1/features/Products/widgets/ProductCardHorizantale.dart';

class Searchpage extends StatefulWidget {
  final List<Map<String, dynamic>> products;

  const Searchpage({
    Key? key,
    required this.products,
  }) : super(key: key);

  @override
  _SearchpageState createState() => _SearchpageState();
}

class _SearchpageState extends State<Searchpage> {
  double minPrice = 0;
  double maxPrice = 1000;
  bool isFilterActive = false;

  List<String> selectedBrands = [];
  List<Map<String, dynamic>> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _resetFilters();
  }

  void _resetFilters() {
    setState(() {
      minPrice = 0;
      maxPrice = 1000;
      selectedBrands.clear();
      isFilterActive = false;
      filteredProducts = widget.products;
    });
  }

  void _applyFilters(double min, double max, List<String> brands) {
    setState(() {
      minPrice = min;
      maxPrice = max;
      selectedBrands = brands;

      isFilterActive = min > 0 || max < 1000 || brands.isNotEmpty;

      filteredProducts = widget.products.where((product) {
        double price = product['price'];
        return price >= min &&
            price <= max &&
            (brands.isEmpty || brands.contains(product['brand']));
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
  color: Colors.white,
  child: Column(
    children: [
      ProductFilterBar(
        isFilterActive: isFilterActive,
        onClearFilter: _resetFilters,
        onOpenFilter: () => _showFilterSheet(context),
      ),
      Expanded(
        child: filteredProducts.isEmpty
            ? const Center(child: Text('Aucun produit trouvé'))
            : ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = filteredProducts[index];
                  return Productcardhorizantale(
                    brand: product['brand'],
                    imagePath: product['imagePath'],
                    productName: product['productName'],
                    price: product['price'].toString(),
                    originalPrice: product['originalPrice'].toString(),
                  );
                },
              ),
      ),
    ],
  ),
);

  }

  void _showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return PriceFilterWidget(
          minPrice: 0,
          maxPrice: 1000,
          initialMinValue: minPrice,
          initialMaxValue: maxPrice,
          onPriceRangeChanged: (min, max) {
            _applyFilters(min, max, selectedBrands);
          },
        );
      },
    );
  }
}