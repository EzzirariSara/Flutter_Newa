import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/Promotions/Pages/PromotionCard.dart';
import 'package:flutter_application_1/features/Promotions/Widgets/Promotion.dart';

class PromotionsGrid extends StatelessWidget {
  final List<Promotion> promotions;

  const PromotionsGrid({
    Key? key,
    required this.promotions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(16),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: promotions.length,
      itemBuilder: (context, index) {
        return PromotionCard(
          promotion: promotions[index],
          onTap: () {
          },
        );
      },
    );
  }
}