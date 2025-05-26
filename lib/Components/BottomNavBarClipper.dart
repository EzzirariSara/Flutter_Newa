import 'package:flutter/material.dart';

class BottomNavBarClipper extends CustomClipper<Path> {
  final double circleDiameter;
  final double barWidth;
  final int selectedIndex;
  final int itemCount;

  BottomNavBarClipper({
    required this.circleDiameter,
    required this.barWidth,
    required this.selectedIndex,
    required this.itemCount,
  });

  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);

    double width = size.width / itemCount;
    double centerX = selectedIndex * width + width / 2;
    double radius = circleDiameter / 2;

    path.lineTo(centerX - radius, 0);

    path.arcToPoint(
      Offset(centerX + radius, 0),
      radius: Radius.circular(radius),
      clockwise: false,
    );

    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}