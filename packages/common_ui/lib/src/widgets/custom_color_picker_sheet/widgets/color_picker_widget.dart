import 'package:flutter/material.dart';

import '../service.dart';
import 'color_category_view.dart';
import 'color_page_view.dart';

class ColorPickerWidget extends StatefulWidget {

  final ValueChanged<Color> onChanged;
  final int? defaultCategoryIndex;
  final int? defaultColorIndex;

  const ColorPickerWidget({
    super.key,
    required this.onChanged,
    this.defaultCategoryIndex,
    this.defaultColorIndex
  });

  @override
  State<ColorPickerWidget> createState() => _ColorPickerWidgetState();
}

class _ColorPickerWidgetState extends State<ColorPickerWidget> {

  late PageController pageController;
  late int _selectedCategoryIndex;
  late int _selectedColorIndex;

  @override
  void initState() {
    _selectedCategoryIndex = widget.defaultCategoryIndex ?? 0;
    _selectedColorIndex = widget.defaultColorIndex ?? 0;
    pageController = PageController(initialPage: _selectedCategoryIndex);
    pageController.addListener(() {
      setState(() {
        _selectedColorIndex = 0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final int columns = 6;
    final int rows = 3;
    List<Widget> selectors = [];
    final List<Widget> pages = [];

    List<List<Color>> colorTypes = ColorPickerService.instance.colorTypes;
    for(int i=0; i<colorTypes.length; i++) {
      selectors.add(ColorCategoryView(
        categoryIndex: i,
        colorCategory: colorTypes[i],
        onColorSelected: (categoryIndex) {
          setState(() {
            _selectedCategoryIndex = categoryIndex;
            _selectedColorIndex = 0;
          });
          //  返回选中的颜色
          widget.onChanged(colorTypes[categoryIndex][0]);
          pageController.animateToPage(
            categoryIndex,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
      ));
      pages.add(ColorPageView(
        key: UniqueKey(),
        colorList: ColorPickerService.instance.subColors(i),
        categoryIndex: i,
        selectedCategoryIndex: _selectedCategoryIndex,
        selectedColorIndex: _selectedColorIndex,
        onSelected: (categoryIndex, colorIndex) {
          List<Map<Color, String>> colorList = ColorPickerService.instance.subColors(categoryIndex);
          setState(() {
            _selectedCategoryIndex = categoryIndex;
            _selectedColorIndex = colorIndex;
          });
          //  返回选中的颜色
          widget.onChanged(colorList[colorIndex].keys.first);
          if(categoryIndex != pageController.page?.toInt()) {
            pageController.animateToPage(
              categoryIndex,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        },
      ));
    }

    return Column(
      children: [
        Container(
          height: 50,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child:FittedBox(
            fit: BoxFit.scaleDown,
            child: Row(
              children: selectors,
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: (MediaQuery.of(context).size.width / columns) * rows,
          child: PageView(
            pageSnapping: true,
            controller: pageController,
            children: pages,
          ),
        ),
      ],
    );
  }
}