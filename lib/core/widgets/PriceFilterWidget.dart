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
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 12, bottom: 8),
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Icon(Icons.close, size: 28),
                ),
                SizedBox(width: 20),
                Text(
                  'Filtrer',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          Expanded(
            child: Container(
              color: Colors.white,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    _buildFilterTile('Prix', 'price'),
                    _buildDivider(),
                    _buildFilterTile('Catégories', 'categories'),
                    _buildDivider(),
                    _buildFilterTile('Marque', 'brands'),
                    _buildDivider(),
                    _buildFilterTile('Taille', 'sizes'),
                    _buildDivider(),
                    _buildFilterTile('Note', 'rating'),
                  ],
                ),
              ),
            ),
          ),
          
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(20),
            child: SafeArea(
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
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
                        padding: EdgeInsets.symmetric(vertical: 18),
                        side: BorderSide(color: Colors.grey[400]!),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Réinitialiser',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        widget.onPriceRangeChanged(
                          _currentRangeValues.start,
                          _currentRangeValues.end,
                        );
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 18),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Appliquer',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterTile(String title, String filterKey) {
    bool isExpanded = expandedFilter == filterKey;
    int selectedCount = _getSelectedCount(filterKey);
    
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              expandedFilter = isExpanded ? null : filterKey;
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (selectedCount > 0) ...[
                      SizedBox(width: 8),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
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
                    ],
                  ],
                ),
                Icon(
                  isExpanded ? Icons.keyboard_arrow_up : Icons.chevron_right,
                  color: Colors.grey[600],
                  size: 28,
                ),
              ],
            ),
          ),
        ),
        
        if (isExpanded)
          Container(
            color: Colors.grey[50],
            padding: EdgeInsets.all(20),
            child: _buildFilterContent(filterKey),
          ),
      ],
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.grey[200],
      indent: 24,
      endIndent: 24,
    );
  }

  int _getSelectedCount(String filterKey) {
    switch (filterKey) {
      case 'price':
        return (_currentRangeValues.start != widget.minPrice || 
                _currentRangeValues.end != widget.maxPrice) ? 1 : 0;
      case 'categories':
        return selectedCategories.length;
      case 'brands':
        return selectedBrands.length;
      case 'sizes':
        return selectedSizes.length;
      case 'rating':
        return selectedRating > 0 ? 1 : 0;
      default:
        return 0;
    }
  }

  Widget _buildFilterContent(String filterKey) {
    switch (filterKey) {
      case 'price':
        return _buildPriceFilter();
      case 'categories':
        return _buildCheckboxList(availableCategories, selectedCategories);
      case 'brands':
        return _buildCheckboxList(availableBrands, selectedBrands);
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
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${_currentRangeValues.start.toStringAsFixed(0)} DH',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '${_currentRangeValues.end.toStringAsFixed(0)} DH',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: Colors.black,
            inactiveTrackColor: Colors.grey[300],
            thumbColor: Colors.black,
            overlayColor: Colors.black.withOpacity(0.1),
            trackHeight: 4,
            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
          ),
          child: RangeSlider(
            values: _currentRangeValues,
            min: widget.minPrice,
            max: widget.maxPrice,
            divisions: 50,
            onChanged: (values) {
              setState(() {
                _currentRangeValues = values;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCheckboxList(List<String> items, List<String> selectedItems) {
    return Column(
      children: [
        if (selectedItems.isNotEmpty)
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 16),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: selectedItems.map((item) {
                return Chip(
                  label: Text(
                    item,
                    style: TextStyle(fontSize: 12),
                  ),
                  backgroundColor: Colors.black.withOpacity(0.08),
                  deleteIcon: Icon(Icons.close, size: 16),
                  onDeleted: () {
                    setState(() {
                      selectedItems.remove(item);
                    });
                  },
                );
              }).toList(),
            ),
          ),
        
        Container(
          constraints: BoxConstraints(maxHeight: 300),
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              final isSelected = selectedItems.contains(item);
              return CheckboxListTile(
                title: Text(
                  item,
                  style: TextStyle(fontSize: 14),
                ),
                value: isSelected,
                activeColor: Colors.black,
                contentPadding: EdgeInsets.zero,
                dense: true,
                onChanged: (value) {
                  setState(() {
                    if (value == true) {
                      selectedItems.add(item);
                    } else {
                      selectedItems.remove(item);
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
      spacing: 12,
      runSpacing: 12,
      children: availableSizes.map((size) {
        final isSelected = selectedSizes.contains(size);
        return ChoiceChip(
          label: Text('$size ml'),
          selected: isSelected,
          selectedColor: Colors.black,
          backgroundColor: Colors.grey[200],
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
          onSelected: (selected) {
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
            final isFilled = index < selectedRating;
            return IconButton(
              icon: Icon(
                isFilled ? Icons.star_rounded : Icons.star_outline_rounded,
                color: isFilled ? Colors.amber : Colors.grey[400],
                size: 36,
              ),
              onPressed: () {
                setState(() {
                  selectedRating = (selectedRating == index + 1) ? 0 : index + 1.0;
                });
              },
            );
          }),
        ),
        SizedBox(height: 8),
        Text(
          selectedRating > 0 
              ? '${selectedRating.toInt()} étoile${selectedRating > 1 ? 's' : ''} et plus'
              : 'Toutes les notes',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}