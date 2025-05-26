import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/Promotions/Widgets/FilterChip.dart';

class Promotionsheader extends StatefulWidget {
  final String selectedFilter;
  final Function(String) onFilterChanged;

  const Promotionsheader({
    Key? key,
    required this.selectedFilter,
    required this.onFilterChanged,
  }) : super(key: key);

  @override
  State<Promotionsheader> createState() => _PromotionsheaderState();
}

class _PromotionsheaderState extends State<Promotionsheader> {
  final List<String> filterLabels = [
    "Tous",
    "Soins visage",
    "Compléments",
    "Anti-âge",
    "Hydratants",
    "Nettoyants"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Promotions",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF243B6A),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: filterLabels.map((label) => 
                CustomFilterChip(
                  label: label,
                  isSelected: widget.selectedFilter == label,
                  onSelected: (selected) {
                    if (selected) {
                      widget.onFilterChanged(label);
                    }
                  },
                )
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}