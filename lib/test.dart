import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/categorie/widgets/categoriges.dart';

class test extends StatelessWidget {
  const test({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {
        'name': 'Électronique',
        'image': 'assets/Categorys/categori9.png'
      },
      {
        'name': 'Vêtements',
        'image': 'assets/Categorys/categori9.png'
      },
      {
        'name': 'Maison',
        'image': 'assets/Categorys/categori9.png'
      },
      {
        'name': 'Sports',
        'image': 'assets/Categorys/categori9.png'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catégories'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Categories(categories: categories),
      ),
    );
  }
}