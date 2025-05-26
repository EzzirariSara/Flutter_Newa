import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/theme/Colors.dart';
import 'package:flutter_application_1/features/Search/Pages/Searchpage.dart';

class Searchscr extends StatefulWidget {
  final List<String> searchHistory;
  final List<Map<String, dynamic>> products;

  const Searchscr({
    Key? key,
    required this.searchHistory,
    required this.products,
  }) : super(key: key);

  @override
  State<Searchscr> createState() => _SearchscrState();
}

class _SearchscrState extends State<Searchscr> {
  final TextEditingController _searchController = TextEditingController();
  String _query = '';

  // Filter variables
  double _minPriceFilter = 0;
  double _maxPriceFilter = 1000;
  List<String> _selectedBrands = [];
  List<String> _selectedCategories = [];
  List<String> _selectedSizes = [];
  double _selectedRating = 0;

  void _performSearch(String query) {
    setState(() {
      _query = query;

      if (!widget.searchHistory.contains(query)) {
        widget.searchHistory.insert(0, query);
      }
    });
  }

  void _clearSearch() {
    setState(() {
      _query = '';
      _searchController.clear();
    });
  }

  bool _hasActiveFilters() {
    return _minPriceFilter > 0 ||
        _maxPriceFilter < 1000 ||
        _selectedBrands.isNotEmpty ||
        _selectedCategories.isNotEmpty ||
        _selectedSizes.isNotEmpty ||
        _selectedRating > 0;
  }

  void _resetFilters() {
    setState(() {
      _minPriceFilter = 0;
      _maxPriceFilter = 1000;
      _selectedBrands.clear();
      _selectedCategories.clear();
      _selectedSizes.clear();
      _selectedRating = 0;
    });
  }

  @override
  Widget build(BuildContext context) {

    final filteredProducts = widget.products.where((product) {
      bool matchesSearch = _query.isEmpty ||
          product['productName']
              .toString()
              .toLowerCase()
              .contains(_query.toLowerCase()) ||
          product['brand']
              .toString()
              .toLowerCase()
              .contains(_query.toLowerCase());

      double productPrice = double.tryParse(product['price'].toString()) ?? 0;
      bool matchesPrice = productPrice >= _minPriceFilter &&
          productPrice <= _maxPriceFilter;

      bool matchesBrand = _selectedBrands.isEmpty ||
          _selectedBrands.contains(product['brand'].toString());

      bool matchesCategory = _selectedCategories.isEmpty ||
          _selectedCategories.contains(product['category']?.toString() ?? '');

      bool matchesSize = _selectedSizes.isEmpty ||
          _selectedSizes.contains(product['size']?.toString() ?? '');

      double productRating =
          double.tryParse(product['rating']?.toString() ?? '0') ?? 0;
      bool matchesRating =
          _selectedRating == 0 || productRating >= _selectedRating;

      return matchesSearch &&
          matchesPrice &&
          matchesBrand &&
          matchesCategory &&
          matchesSize &&
          matchesRating;
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white ,
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Recherchez un produit, une marque...',
            hintStyle: const TextStyle(color: Colors.white70),
            border: InputBorder.none,
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.clear, color: Colors.white),
                  onPressed: _clearSearch,
                ),
              ],
            ),
          ),
          style: const TextStyle(color: Colors.white),
          onSubmitted: _performSearch,
        ),
        backgroundColor: AppColors.deepBlue,
      ),
      body: _query.isEmpty
          ? _buildSearchHistory()
          : Searchpage(
            
              products: filteredProducts,
            ),
    );
  }

  Widget _buildSearchHistory() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Historique de recherche',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ...widget.searchHistory.map((query) {
          return ListTile(
            title: Text(query),
            leading: const Icon(Icons.history, color: Colors.grey),
            onTap: () {
              _searchController.text = query;
              _performSearch(query);
            },
          );
        }),
        if (widget.searchHistory.isEmpty)
          const Center(
            child: Padding(
              padding: EdgeInsets.all(50),
              child: Text(
                'Aucun historique de recherche',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
      ],
    );
  }
}