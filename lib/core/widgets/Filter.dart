import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/theme/Colors.dart';

class Filter extends StatefulWidget {
  final double minPrice;
  final double maxPrice;
  final Function(double, double) onPriceRangeChanged;
  final double initialMinValue;
  final double initialMaxValue;

  const Filter({
    Key? key,
    required this.minPrice,
    required this.maxPrice,
    required this.onPriceRangeChanged,
    this.initialMinValue = 0,
    this.initialMaxValue = 0,
  }) : super(key: key);

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  late RangeValues _currentRangeValues;

  @override
  void initState() {
    super.initState();
    double initialMin = widget.initialMinValue > widget.minPrice 
        ? widget.initialMinValue : widget.minPrice;
    double initialMax = widget.initialMaxValue > 0 && widget.initialMaxValue <= widget.maxPrice 
        ? widget.initialMaxValue : widget.maxPrice;
        
    _currentRangeValues = RangeValues(initialMin, initialMax);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filtrer par prix',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.deepBlue,
                ),
              ),
              IconButton(
                icon: Icon(Icons.close, color: AppColors.deepBlue),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_currentRangeValues.start.toStringAsFixed(0)}Dh',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${_currentRangeValues.end.toStringAsFixed(0)}Dh',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: AppColors.deepBlue,
              inactiveTrackColor: Colors.grey.shade300,
              thumbColor: Colors.white,
              thumbShape: _CustomThumbShape(thumbRadius: 12),
              overlayColor: AppColors.deepBlue.withOpacity(0.2),
              valueIndicatorColor: AppColors.deepBlue,
              showValueIndicator: ShowValueIndicator.always,
            ),
            child: RangeSlider(
              values: _currentRangeValues,
              min: widget.minPrice,
              max: widget.maxPrice,
              divisions: ((widget.maxPrice - widget.minPrice) / 10).round(),
              labels: RangeLabels(
                '${_currentRangeValues.start.toStringAsFixed(0)}Dh',
                '${_currentRangeValues.end.toStringAsFixed(0)}Dh',
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _currentRangeValues = values;
                });
              },
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    _currentRangeValues = RangeValues(widget.minPrice, widget.maxPrice);
                  });
                },
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  side: BorderSide(color: AppColors.deepBlue),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  'Réinitialiser',
                  style: TextStyle(color: AppColors.deepBlue),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  widget.onPriceRangeChanged(
                    _currentRangeValues.start,
                    _currentRangeValues.end,
                  );
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.deepBlue,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text(
                  'Appliquer',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class _CustomThumbShape extends SliderComponentShape {
  final double thumbRadius;

  const _CustomThumbShape({required this.thumbRadius});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final Paint fillPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, thumbRadius, fillPaint);

    final Paint borderPaint = Paint()
      ..color = AppColors.deepBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawCircle(center, thumbRadius, borderPaint);
  }
}