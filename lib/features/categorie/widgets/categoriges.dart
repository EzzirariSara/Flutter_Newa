import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/categorie/pages/CategoryCard.dart';
import 'package:flutter_application_1/features/categorie/pages/CategoryDetailSheet.dart';

class Categories extends StatelessWidget {
  final List<Map<String, dynamic>> categories;

  const Categories({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Container(
      height: screenHeight * 0.65, 
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.8,
        ),
        itemCount: categories.length,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                useSafeArea: true, 
                isDismissible: true,
                enableDrag: true,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.85 - 60,
                ),
                builder: (BuildContext context) {
                  return CategoryDetailSheet(
                    name: category['name'],
                    imageUrl: category['image'],
                    subcategories: category['subcategories'] ?? [],
                  );
                },
              );
            },
            child: CategoryCard(
              name: category['name'],
              imageUrl: category['image'],
            ),
          );
        },
      ),
    );
  }
}
