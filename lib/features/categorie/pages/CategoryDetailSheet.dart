import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/Brands/BrandCategorie.dart';
import 'package:flutter_application_1/features/Brands/pages/BrandsScreen.dart';
import 'package:flutter_application_1/config/theme/Colors.dart';
import 'package:flutter_application_1/features/ProductBrands/pages/ProductGrid.dart';
import 'package:flutter_application_1/features/Products/pages/ProductCategories.dart';

class CategoryDetailSheet extends StatelessWidget {
  final String name;
  final String imageUrl;
  final List<dynamic> subcategories;
  final VoidCallback? onClose;

  const CategoryDetailSheet({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.subcategories,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    final double maxHeight = MediaQuery.of(context).size.height * 1.10;


    return Material(
      color: Colors.transparent,
      elevation: 12,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: maxHeight,
          minWidth: double.infinity,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        decoration: const BoxDecoration(
          color: AppColors.deepBlue,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Productcategories(categoryName: name),
                  ),
                );
              },
              child: Row(
                children: [
                  CircleAvatar(radius: 30, backgroundImage: AssetImage(imageUrl)),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: onClose ?? () => Navigator.of(context).maybePop(),
                    tooltip: 'Fermer',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            subcategories.isNotEmpty
                ? Flexible(
                  child: ListView.separated(
                    itemCount: subcategories.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final sub = subcategories[index];
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pop();

                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (context) => Brandcategorie(
                                    subcategoryName: sub['name'],
                                    subcategoryImage: sub['image'],
                                    brands: sub['brands'] ?? [],
                                  ),
                            ),
                          );
                        },
                        child: Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          children: subcategories.map<Widget>((sub) {
                            return SizedBox(
                              width: 100,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: AssetImage(sub['image']),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    sub['name'],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(color: Colors.white, fontSize: 14),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),

                      );
                    },
                  ),
                )
                : const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    "Aucune sous-catégorie.",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}

