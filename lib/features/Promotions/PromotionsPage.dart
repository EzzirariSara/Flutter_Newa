import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/Header/DetailHeader.dart';
import 'package:flutter_application_1/features/Promotions/Widgets/Promotion.dart';
import 'package:flutter_application_1/features/Promotions/Widgets/PromotionsGrid.dart';
import 'package:flutter_application_1/features/Promotions/Widgets/PromotionsHeader.dart';
import 'package:flutter_application_1/features/Promotions/Widgets/PromotionsTitle.dart';

class PromotionsPage extends StatefulWidget {
  const PromotionsPage({Key? key}) : super(key: key);

  @override
  State<PromotionsPage> createState() => _PromotionsPageState();
}

class _PromotionsPageState extends State<PromotionsPage> {
  String selectedCategory = "Tous";

  void updateSelectedCategory(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  List<Promotion> getFilteredPromotions() {
    if (selectedCategory == "Tous") {
      return demoPromotions;
    } else {
      return demoPromotions.where((promotion) => 
        promotion.category == selectedCategory
      ).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          DetailHeader(),
          Promotionsheader(
            selectedFilter: selectedCategory,
            onFilterChanged: updateSelectedCategory,
          ),
          const SizedBox(height: 8),
          Promotionstitle(),
          PromotionsGrid(promotions: getFilteredPromotions()),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}