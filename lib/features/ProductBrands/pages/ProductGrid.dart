import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/theme/Colors.dart';
import 'package:flutter_application_1/core/widgets/PriceFilterWidget.dart';
import 'package:flutter_application_1/features/ProductBrands/widgets/ProductCard.dart';

class ProductGrid extends StatefulWidget {
  final List<Map<String, dynamic>>? products;

  const ProductGrid({Key? key, this.products}) : super(key: key);
 
  @override
  _ProductGridState createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  double minPrice = 0;
  double maxPrice = 100;
  
  List<String> selectedBrands = [];
  List<String> selectedSizes = [];
  double selectedRating = 0;
  
  List<Map<String, dynamic>> filteredProducts = [];
  bool isFilterActive = false;

  @override
  void initState() {
    super.initState();
    _initPriceRange();
  }

  void _initPriceRange() {
    if (widget.products != null && widget.products!.isNotEmpty) {
      double min = double.infinity;
      double max = 0;

      for (var product in widget.products!) {
        double price = product['price'];
        if (price < min) min = price;
        if (price > max) max = price;
      }

      min = (min > 5) ? min - 5 : 0;
      max = max + 5;

      setState(() {
        minPrice = min;
        maxPrice = max;
        filteredProducts = List.from(widget.products!);
      });
    }
  }

  void _applyFilters({
    required double min, 
    required double max, 
    List<String>? brands, 
    List<String>? sizes, 
    double? rating
  }) {
    if (widget.products == null) return;

    setState(() {
      minPrice = min;
      maxPrice = max;
      
      if (brands != null) selectedBrands = brands;
      if (sizes != null) selectedSizes = sizes;
      if (rating != null) selectedRating = rating;
      
      isFilterActive = minPrice > 0 || maxPrice < 100 || 
                       selectedBrands.isNotEmpty || 
                       selectedSizes.isNotEmpty || 
                       selectedRating > 0;

      filteredProducts = widget.products!.where((product) {
        double price = product['price'];
        bool passesPrice = price >= min && price <= max;
        
        bool passesBrand = selectedBrands.isEmpty || 
                          (product['brand'] != null && 
                           selectedBrands.contains(product['brand']));
        
        bool passesSize = selectedSizes.isEmpty || 
                         (product['size'] != null && 
                          selectedSizes.contains(product['size']));
        
        bool passesRating = selectedRating <= 0 || 
                           (product['rating'] != null && 
                            product['rating'] >= selectedRating);
        
        return passesPrice && passesBrand && passesSize && passesRating;
      }).toList();
    });
  }

  void _clearFilter() {
    setState(() {
      isFilterActive = false;
      minPrice = 0;
      maxPrice = 100;
      selectedBrands = [];
      selectedSizes = [];
      selectedRating = 0;
      
      if (widget.products != null) {
        filteredProducts = List.from(widget.products!);
      } else {
        filteredProducts = [];
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

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> displayProducts =
        isFilterActive ? filteredProducts : (widget.products ?? []);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${displayProducts.length} produits',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: _showPriceFilterBottomSheet,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: isFilterActive
                              ? AppColors.deepBlue
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.filter_list,
                              size: 18,
                              color: isFilterActive
                                  ? Colors.white
                                  : Colors.black87,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Filtres',
                              style: TextStyle(
                                color: isFilterActive
                                    ? Colors.white
                                    : Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    if (isFilterActive)
                      GestureDetector(
                        onTap: _clearFilter,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Icon(Icons.close, size: 20, color: Colors.red),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          displayProducts.isEmpty
              ? Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Column(
                    children: [
                      Icon(Icons.search_off, size: 60, color: Colors.grey),
                      SizedBox(height: 16),
                      Text(
                        'Aucun produit ne correspond à ces critères',
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
              : GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

                  crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.75,

                ),
                itemCount: displayProducts.length,
                itemBuilder: (context, index) {
                  final product = displayProducts[index];
                  return ProductCard(
                    brand: product['brand'],
                    imagePath: product['imagePath'],
                    productName: product['productName'],
                    price: product['price'].toString(),
                    originalPrice: product['originalPrice'].toString(),

                  );
                },
              ),
          SizedBox(height: 24),
        ],
      ),
    );
  }
  
  // Widget _buildFilterChip({required String label, required VoidCallback onDelete}) {
    // return Container(
      // padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      // decoration: BoxDecoration(
        // color: Colors.grey[200],
        // borderRadius: BorderRadius.circular(16),
      // ),
      // child: Row(
        // mainAxisSize: MainAxisSize.min,
        // children: [
          // Text(
            // label,
            // style: TextStyle(fontSize: 14, color: Colors.black87),
          // ),
          // SizedBox(width: 4),
          // GestureDetector(
            // onTap: onDelete,
            // child: Icon(Icons.close, size: 16, color: Colors.grey[600]),
          // ),
        // ],
      // ),
    // );
  // }
}