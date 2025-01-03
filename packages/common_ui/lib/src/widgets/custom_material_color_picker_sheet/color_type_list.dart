

import 'package:flutter/material.dart';

import 'color_types.dart';

class ColorTypeList extends StatefulWidget {

  final ValueChanged<List<Color>>? onPrimaryChanged;

  const ColorTypeList({
    super.key,
    required this.onPrimaryChanged
  });

  @override
  State<ColorTypeList> createState() => _ColorTypeListState();
}

class _ColorTypeListState extends State<ColorTypeList> {


  List<Color> _currentColorType = colorTypes[0];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        List<Color> _colors = colorTypes[index];
        Color _colorType = _colors[0];
        return GestureDetector(
          onTap: () {
            if (widget.onPrimaryChanged != null) {
              widget.onPrimaryChanged!(_colors);
            }
            setState(() => _currentColorType = _colors);
          },
          child: Container(
            color: const Color(0x00000000),
            padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
            margin: EdgeInsets.only(left: index == 0 ? 12 : 0, right: 12),
            child: Align(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                  color: _colorType,
                  shape: BoxShape.circle,
                  boxShadow: _currentColorType == _colors
                      ? [
                    _colorType == Theme.of(context).cardColor
                        ? BoxShadow(
                      color: (Theme.of(context).brightness == Brightness.light) ? Colors.grey[300]! : Colors.black38,
                      blurRadius: 10,
                    )
                        : BoxShadow(
                      color: _colorType,
                      blurRadius: 10,
                    ),
                  ]
                      : null,
                  border: _colorType == Theme.of(context).cardColor
                      ? Border.all(color: (Theme.of(context).brightness == Brightness.light) ? Colors.grey[300]! : Colors.black38, width: 1)
                      : null,
                ),
              ),
            ),
          ),
        );
      },
      itemCount: colorTypes.length,
    );
  }
}