import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/theme/Colors.dart';

class ProductFilterBar extends StatelessWidget {
  final bool isFilterActive;
  final VoidCallback onClearFilter;
  final VoidCallback onOpenFilter;

  const ProductFilterBar({
    super.key,
    required this.isFilterActive,
    required this.onClearFilter,
    required this.onOpenFilter,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: onOpenFilter,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isFilterActive ? AppColors.deepBlue : Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.filter_list, size: 18, color: isFilterActive ? Colors.white : Colors.black87),
                        const SizedBox(width: 4),
                        Text(
                          'Filtres',
                          style: TextStyle(color: isFilterActive ? Colors.white : Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ),
                // if (isFilterActive)
                //   IconButton(
                //     icon: const Icon(Icons.close, color: Colors.red),
                //     onPressed: onClearFilter,
                //   ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
