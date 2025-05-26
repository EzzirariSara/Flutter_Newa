import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/Products/pages/ProductGridHorizantale.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_application_1/config/theme/Colors.dart';
import 'package:flutter_application_1/features/Search/Widgets/SearchScr.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({super.key});

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  List<String> _searchHistory = []; 

  final List<Map<String, dynamic>> _products = [
    {
      'brand': 'CERAVE',
      "productName": "PAYOT Crème",
      "imagePath": "assets/Products/Product4.png",
      "price": 35.0,
      'originalPrice': 35.0,
    },
    {
      'brand': 'CERAVE',
      "productName": "ANIAN Lotion",
      "imagePath": "assets/Products/Product5.png",
      "price": 15.0,
      'originalPrice': 35.0,
    },
    {
      'brand': 'CERAVE',
      "productName": "DOLOGEL Gel Apaisant",
      "imagePath": "assets/Products/Product1.png",
      "price": 30.0,
      'originalPrice': 35.0,
    },
  ];

  void _openSearchPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Searchscr(
          searchHistory: _searchHistory,
          products: _products,
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.camera);

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });

        _performImageSearch();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors de l\'accès à la caméra: $e')),
      );
    }
  }

  void _performImageSearch() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductGridHorizontal(
          categoryName: 'Résultats de recherche par image',
          products: _products, 
        ),
      ),
    );

    setState(() {
      _selectedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: _openSearchPage,
              child: Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  'Rechercher',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: _pickImage,
            child: Container(
              padding: const EdgeInsets.all(4),
              child: const Icon(
                Icons.camera_alt,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}