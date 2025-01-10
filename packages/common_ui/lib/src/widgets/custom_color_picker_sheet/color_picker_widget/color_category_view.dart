

import 'package:flutter/material.dart';

class ColorCategoryView extends StatelessWidget {
  final int categoryIndex;
  final List<Color> colorCategory;
  final ValueChanged<int> onColorSelected;

  const ColorCategoryView({
    super.key,
    required this.categoryIndex,
    required this.colorCategory,
    required this.onColorSelected
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onColorSelected(categoryIndex);
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 9,
        height: MediaQuery.of(context).size.width / 9,
        decoration: BoxDecoration(
            color: colorCategory.length == 1 ? colorCategory[0] : null,
            gradient: colorCategory.length == 1 ? null : LinearGradient(
                colors: colorCategory,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight
            )
        ),
      ),
    );
  }

}