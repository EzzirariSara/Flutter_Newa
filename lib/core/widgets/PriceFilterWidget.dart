import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/theme/Colors.dart';

class PriceFilterWidget extends StatefulWidget {
  final double minPrice;
  final double maxPrice;
  final Function(double, double) onPriceRangeChanged;
  final double initialMinValue;
  final double initialMaxValue;

  const PriceFilterWidget({
    Key? key,
    required this.minPrice,
    required this.maxPrice,
    required this.onPriceRangeChanged,
    this.initialMinValue = 0,
    this.initialMaxValue = 0,
  }) : super(key: key);

  @override
  State<PriceFilterWidget> createState() => _PriceFilterWidgetState();
}

class _PriceFilterWidgetState extends State<PriceFilterWidget> {
  late RangeValues _currentRangeValues;
  
  List<String> selectedBrands = [];
  List<String> selectedSizes = [];
  List<String> selectedCategories = [];
  double selectedRating = 0;
  
  final List<String> availableBrands = ['DOLOGEL', 'CERAVE', 'PHYSIODOSE', 'PAYOT', 'ANIAN', 'LA ROCHE-POSAY', 'AVENE', 'VICHY', 'BIODERMA', 'EUCERIN'];
  final List<String> availableSizes = ['50', '100', '150', '200'];
  final List<String> availableCategories = ['Soins visage', 'Soins corps', 'Hygiène', 'Capillaire', 'Maquillage', 'Parfums', 'Bébé & Maman', 'Homme', 'Bio & Naturel', 'Compléments alimentaires'];
  
  String? expandedFilter;

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Filtres',
                style: TextStyle(
                  fontSize: 20,
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
          const SizedBox(height: 10),
          
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildFilterCard(
                    title: 'Prix',
                    icon: Icons.euro,
                    filterKey: 'price',
                    selectedCount: _currentRangeValues.start != widget.minPrice || _currentRangeValues.end != widget.maxPrice ? 1 : 0,
                  ),
                  
                  _buildFilterCard(
                    title: 'Catégories',
                    icon: Icons.category,
                    filterKey: 'categories',
                    selectedCount: selectedCategories.length,
                  ),
                  
                  _buildFilterCard(
                    title: 'Marque',
                    icon: Icons.business,
                    filterKey: 'brands',
                    selectedCount: selectedBrands.length,
                  ),
                  
                  _buildFilterCard(
                    title: 'Taille',
                    icon: Icons.straighten,
                    filterKey: 'sizes',
                    selectedCount: selectedSizes.length,
                  ),
                  
                  _buildFilterCard(
                    title: 'Note',
                    icon: Icons.star,
                    filterKey: 'rating',
                    selectedCount: selectedRating > 0 ? 1 : 0,
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    _currentRangeValues = RangeValues(widget.minPrice, widget.maxPrice);
                    selectedBrands = [];
                    selectedCategories = [];
                    selectedSizes = [];
                    selectedRating = 0;
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
        ],
      ),
    );
  }

  Widget _buildFilterCard({
    required String title, 
    required IconData icon, 
    required String filterKey,
    required int selectedCount,
  }) {
    bool isExpanded = expandedFilter == filterKey;
    
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  expandedFilter = isExpanded ? null : filterKey;
                });
              },
              child: Row(
                children: [
                  Icon(icon, color: AppColors.deepBlue),
                  SizedBox(width: 8),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.deepBlue,
                    ),
                  ),
                  if (selectedCount > 0)
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.deepBlue,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        selectedCount.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  Spacer(),
                  Icon(
                    isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: AppColors.deepBlue,
                  ),
                ],
              ),
            ),
            
            if (isExpanded) ...[
              Divider(height: 24),
              _buildFilterContent(filterKey),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFilterContent(String filterKey) {
    switch (filterKey) {
      case 'price':
        return _buildPriceFilter();
      case 'categories':
        return _buildCategoriesFilter();
      case 'brands':
        return _buildBrandFilter();
      case 'sizes':
        return _buildSizeFilter();
      case 'rating':
        return _buildRatingFilter();
      default:
        return SizedBox();
    }
  }

  Widget _buildPriceFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            divisions: ((widget.maxPrice - widget.minPrice) / 5).round().clamp(1, 100),
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
      ],
    );
  }

  Widget _buildCategoriesFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (selectedCategories.isNotEmpty)
          Container(
            width: double.infinity, 
            margin: EdgeInsets.only(bottom: 12),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: selectedCategories.map((category) {
                return Chip(
                  label: Text(category),
                  backgroundColor: AppColors.deepBlue.withOpacity(0.1),
                  deleteIcon: Icon(Icons.close, size: 18),
                  onDeleted: () {
                    setState(() {
                      selectedCategories.remove(category);
                    });
                  },
                  labelStyle: TextStyle(fontSize: 12),
                  labelPadding: EdgeInsets.symmetric(horizontal: 4),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                );
              }).toList(),
            ),
          ),
        
        Container(
          constraints: BoxConstraints(maxHeight: 200),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: availableCategories.length,
            itemBuilder: (context, index) {
              final category = availableCategories[index];
              final isSelected = selectedCategories.contains(category);
              
              return CheckboxListTile(
                title: Text(category),
                value: isSelected,
                activeColor: AppColors.deepBlue,
                contentPadding: EdgeInsets.zero,
                dense: true,
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      selectedCategories.add(category);
                    } else {
                      selectedCategories.remove(category);
                    }
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBrandFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (selectedBrands.isNotEmpty)
          Container(
            width: double.infinity, 
            margin: EdgeInsets.only(bottom: 12),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: selectedBrands.map((brand) {
                return Chip(
                  label: Text(brand),
                  backgroundColor: AppColors.deepBlue.withOpacity(0.1),
                  deleteIcon: Icon(Icons.close, size: 18),
                  onDeleted: () {
                    setState(() {
                      selectedBrands.remove(brand);
                    });
                  },
                  labelStyle: TextStyle(fontSize: 12),
                  labelPadding: EdgeInsets.symmetric(horizontal: 4),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                );
              }).toList(),
            ),
          ),
        
        Container(
          constraints: BoxConstraints(maxHeight: 200),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: availableBrands.length,
            itemBuilder: (context, index) {
              final brand = availableBrands[index];
              final isSelected = selectedBrands.contains(brand);
              
              return CheckboxListTile(
                title: Text(brand),
                value: isSelected,
                activeColor: AppColors.deepBlue,
                contentPadding: EdgeInsets.zero,
                dense: true,
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      selectedBrands.add(brand);
                    } else {
                      selectedBrands.remove(brand);
                    }
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSizeFilter() {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: availableSizes.map((size) {
        final isSelected = selectedSizes.contains(size);
        
        return FilterChip(
          label: Text('${size}ml'),
          selected: isSelected,
          selectedColor: AppColors.deepBlue.withOpacity(0.2),
          checkmarkColor: AppColors.deepBlue,
          labelStyle: TextStyle(
            color: isSelected ? AppColors.deepBlue : Colors.black,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
          side: BorderSide(
            color: isSelected ? AppColors.deepBlue : Colors.grey,
          ),
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                selectedSizes.add(size);
              } else {
                selectedSizes.remove(size);
              }
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildRatingFilter() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return IconButton(
              icon: Icon(
                index < selectedRating.round() ? Icons.star : Icons.star_border,
                color: index < selectedRating.round() ? Colors.amber : Colors.grey,
                size: 30,
              ),
              onPressed: () {
                setState(() {
                  selectedRating = (selectedRating == index + 1) ? 0 : index + 1.0;
                });
              },
              padding: EdgeInsets.symmetric(horizontal: 4),
              constraints: BoxConstraints(),
            );
          }),
        ),
        SizedBox(height: 8),
        Text(
          selectedRating > 0 
              ? "★ ${selectedRating.toStringAsFixed(1)} et plus"
              : "Aucune note sélectionnée",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
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