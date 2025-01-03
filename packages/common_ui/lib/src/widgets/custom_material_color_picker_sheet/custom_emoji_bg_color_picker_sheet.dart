


import 'package:flutter/material.dart';

Future<Color?> showCustomEmojiBgColorPickerSheet(BuildContext context) async {
  double maxHeight = MediaQuery.of(context).size.height;
  double height = MediaQuery.of(context).size.height / 2 - MediaQuery.of(context).padding.bottom;
  Color? result = await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      // backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
          initialChildSize: height / maxHeight,
          minChildSize: height * 0.3 / maxHeight,
          maxChildSize: height / maxHeight,
          expand: false,
          builder: (_, controller) => CustomEmojiBgColorPickerSheet(
            onColorSelected: (color) {
            },
          )
      )
  );
  return result;
}

class CustomEmojiBgColorPickerSheet extends StatefulWidget {
  final Function(Color) onColorSelected;
  final Color? selectedColor;

  CustomEmojiBgColorPickerSheet({
    required this.onColorSelected,
    this.selectedColor
  });

  @override
  State<CustomEmojiBgColorPickerSheet> createState() => _CustomEmojiBgColorPickerSheetState();
}

class _CustomEmojiBgColorPickerSheetState extends State<CustomEmojiBgColorPickerSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Column(
        children: [
          // Expanded(
          //   child: EmojiBgColorPicker(
          //     onColorSelected: widget.onColorSelected,
          //     selectedColor: widget.selectedColor,
          //   ),
          // ),
        ],
      ),
    );
  }
}