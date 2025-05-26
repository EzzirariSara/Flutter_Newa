import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/theme/Colors.dart';

class NewaBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;

  const NewaBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
  });


  @override
  Widget build(BuildContext context) {
    double totalWidth = MediaQuery.of(context).size.width;
    double itemWidth = totalWidth / 5;
    double barHeight = 60;
    double circleDiameter = 50;

    return Container(
      height: barHeight,
      decoration: BoxDecoration(
        color: AppColors.deepBlue,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: CustomPaint(
              size: Size(totalWidth, barHeight),
              painter: NotchedBarPainter(
                notchCenter: selectedIndex * itemWidth + itemWidth / 2,
                notchRadius: 25,
                barColor: AppColors.deepBlue,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildNavItem(
                0,
                'assets/Icones/Home.png',
                itemWidth,
                barHeight,
                circleDiameter,
              ),
              _buildNavItem(
                1,
                'assets/Icones/Promo.png',
                itemWidth,
                barHeight,
                circleDiameter,
              ),
              _buildLogoItem(
                'assets/LogoNewa/Logo NEWA V B.png',
                itemWidth,
                barHeight,
                circleDiameter,
              ),
              _buildNavItem(
                3,
                'assets/Icones/Achat.png',
                itemWidth,
                barHeight,
                circleDiameter,
              ),
              _buildNavItem(
                4,
                'assets/Icones/Profile.png',
                itemWidth,
                barHeight,
                circleDiameter,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    onTabSelected(index);
  }

  Widget _buildNavItem(
    int index,
    String iconPath,
    double width,
    double barHeight,
    double circleDiameter,
  ) {
    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: SizedBox(
        width: width,
        height: barHeight,
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform:
                isSelected
                    ? Matrix4.translationValues(1, -14, 2)
                    : Matrix4.identity(),
            child: Container(
              width: circleDiameter,
              height: circleDiameter,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.deepBlue : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  iconPath,
                  width: 24,
                  height: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoItem(
    String logoPath,
    double width,
    double barHeight,
    double circleDiameter,
  ) {
    final isSelected = selectedIndex == 2;

    return GestureDetector(
      onTap: () => _onItemTapped(2),
      child: SizedBox(
        width: width,
        height: barHeight,
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            transform:
                isSelected
                    ? Matrix4.translationValues(1, -14, 2)
                    : Matrix4.identity(),
            child: Container(
              width: circleDiameter,
              height: circleDiameter,
              decoration: BoxDecoration(
                color: isSelected ? AppColors.deepBlue : Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  logoPath,
                  width: 30,
                  height: 30,
                  color: isSelected ? Colors.white : AppColors.deepBlue,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NotchedBarPainter extends CustomPainter {
  final double notchCenter;
  final double notchRadius;
  final Color barColor;

  NotchedBarPainter({
    required this.notchCenter,
    required this.notchRadius,
    required this.barColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(0, notchRadius);
    path.quadraticBezierTo(0, 0, notchRadius, 0);
    path.lineTo(notchCenter - notchRadius, 0);
    path.cubicTo(
      notchCenter - notchRadius / 2,
      0,
      notchCenter - notchRadius / 2,
      notchRadius * 0.6,
      notchCenter,
      notchRadius * 0.6,
    );
    path.cubicTo(
      notchCenter + notchRadius / 2,
      notchRadius * 0.6,
      notchCenter + notchRadius / 2,
      0,
      notchCenter + notchRadius,
      0,
    );

    path.lineTo(size.width - notchRadius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, notchRadius);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    final paint =
        Paint()
          ..color = barColor
          ..style = PaintingStyle.fill;
    canvas.drawPath(path, paint);

    final whiteCirclePaint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;

    canvas.drawCircle(
      Offset(notchCenter, notchRadius * 0.6),
      notchRadius + 5,
      whiteCirclePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
