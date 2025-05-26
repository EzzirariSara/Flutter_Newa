import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/theme/Colors.dart';
import 'package:flutter_application_1/core/widgets/PriceFilterWidget.dart';
import 'package:flutter_application_1/core/widgets/ProductFilterBar.dart';
import 'package:flutter_application_1/features/Products/widgets/ProductCardHorizantale.dart';

class ProductGridHorizontal extends StatefulWidget {
  final List<Map<String, dynamic>>? products;
  final String categoryName;


  const ProductGridHorizontal({
    Key? key,
   this.products,
    required this.categoryName,
   }) : super(key: key);

  @override
  _ProductGridHorizontalState createState() => _ProductGridHorizontalState();
}

class _ProductGridHorizontalState extends State<ProductGridHorizontal> {
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

      setState(() {
        minPrice = (min > 5) ? min - 5 : 0;
        maxPrice = max + 5;
        filteredProducts = List.from(widget.products!);
      });
    }
  }

  void _applyFilters({
    required double min,
    required double max,
    List<String>? brands,
    List<String>? sizes,
    double? rating,
  }) {
    if (widget.products == null) return;

    setState(() {
      minPrice = min;
      maxPrice = max;
      selectedBrands = brands ?? selectedBrands;
      selectedSizes = sizes ?? selectedSizes;
      selectedRating = rating ?? selectedRating;

      isFilterActive = min > 0 || max < 100 || selectedBrands.isNotEmpty || selectedSizes.isNotEmpty || selectedRating > 0;

      filteredProducts = widget.products!.where((product) {
        double price = product['price'];
        return price >= min &&
            price <= max &&
            (selectedBrands.isEmpty || selectedBrands.contains(product['brand'])) &&
            (selectedSizes.isEmpty || selectedSizes.contains(product['size'])) &&
            (selectedRating <= 0 || (product['rating'] != null && product['rating'] >= selectedRating));
      }).toList();
    });
  }

  void _clearFilter() {
    setState(() {
      minPrice = 0;
      maxPrice = 100;
      selectedBrands.clear();
      selectedSizes.clear();
      selectedRating = 0;
      isFilterActive = false;
      filteredProducts = widget.products ?? [];
    });
  }

  void _showPriceFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            padding: const EdgeInsets.only(top: 20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: PriceFilterWidget(
              minPrice: 0,
              maxPrice: 100,
              initialMinValue: minPrice,
              initialMaxValue: maxPrice,
              onPriceRangeChanged: (min, max) {
                _applyFilters(
                  min: min,
                  max: max,
                  brands: selectedBrands,
                  sizes: selectedSizes,
                  rating: selectedRating,
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildFilterChip({required String label, required VoidCallback onDelete}) {
    return Chip(
      label: Text(label),
      onDeleted: onDelete,
      backgroundColor: Colors.grey[200],
    );
  }

  @override
  Widget build(BuildContext context) {
    final productsToDisplay = isFilterActive ? filteredProducts : widget.products ?? [];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        
        children: [
          
  Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  crossAxisAlignment: CrossAxisAlignment.center,
  children: [
    Expanded(
      child: Row(
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              widget.categoryName,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis, 
              maxLines: 1,
            ),
          ),
        ],
      ),
    ),
    SizedBox(
      width: 150,
      child: ProductFilterBar(
        isFilterActive: isFilterActive,
        onClearFilter: _clearFilter,
        onOpenFilter: _showPriceFilterBottomSheet,
      ),
    ),
  ],
),





          if (isFilterActive)
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                if (minPrice > 0 || maxPrice < 100)
                  _buildFilterChip(
                    label: 'Prix: ${minPrice.toInt()}Dh - ${maxPrice.toInt()}Dh',
                    onDelete: () => _applyFilters(min: 0, max: 100),
                  ),
                ...selectedBrands.map((brand) => _buildFilterChip(
                      label: 'Marque: $brand',
                      onDelete: () {
                        final updated = List<String>.from(selectedBrands)..remove(brand);
                        _applyFilters(min: minPrice, max: maxPrice, brands: updated);
                      },
                    )),
                ...selectedSizes.map((size) => _buildFilterChip(
                      label: 'Taille: $size',
                      onDelete: () {
                        final updated = List<String>.from(selectedSizes)..remove(size);
                        _applyFilters(min: minPrice, max: maxPrice, sizes: updated);
                      },
                    )),
                if (selectedRating > 0)
                  _buildFilterChip(
                    label: 'Note: ${selectedRating.toStringAsFixed(1)}★+',
                    onDelete: () => _applyFilters(min: minPrice, max: maxPrice, rating: 0),
                  ),
              ],
            ),
          productsToDisplay.isEmpty
              ? const Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(Icons.search_off, size: 60, color: Colors.grey),
                        SizedBox(height: 16),
                        Text('Aucun produit ne correspond à ces critères', style: TextStyle(fontSize: 16, color: Colors.grey)),
                      ],
                    ),
                  ),
                )
              :  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: productsToDisplay.length,
                    itemBuilder: (context, index) {
                      final product = productsToDisplay[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0),
                        child: Productcardhorizantale(
                          brand: product['brand'],
                          imagePath: product['imagePath'],
                          productName: product['productName'],
                          price: product['price'].toString(),
                          originalPrice: product['originalPrice'].toString(),
                        ),
                      );
                    },
                ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
