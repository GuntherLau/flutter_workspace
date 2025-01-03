

import 'package:flutter/material.dart';

import 'color_types.dart';

class ShadingListController {
  ValueChanged<List<Color>>? $primaryColorChange;

  void onPrimaryColorChanged(List<Color> primaryColor) {
    if($primaryColorChange != null) {
      $primaryColorChange!(primaryColor);
    }
  }

}

class ShadingList extends StatefulWidget {

  final ShadingListController shadingListController;
  final ValueChanged<Color> onColorChanged;

  const ShadingList({
    super.key,
    required this.shadingListController,
    required this.onColorChanged
  });

  @override
  State<ShadingList> createState() => _ShadingListState();
}

class _ShadingListState extends State<ShadingList> {

  late List<Map<Color, String>> _list;
  Color _currentShading = Colors.transparent;

  @override
  void initState() {
    widget.shadingListController.$primaryColorChange = (primaryColor) {
      setState(() {
        _list = _shadingTypes(primaryColor);
      });
    };
    // for (List<Color> _colors in colorTypes) {
    //   _shadingTypes(_colors).forEach((Map<Color, String> color) {
    //     if (widget.pickerColor.value == color.keys.first.value) {
    //       return setState(() {
    //         _currentColorType = _colors;
    //         _currentShading = color.keys.first;
    //       });
    //     }
    //   });
    // }
    _list = _shadingTypes(colorTypes[0]);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        Map<Color, String> color = _list[index];
        final Color _color = color.keys.first;
        return GestureDetector(
          onTap: () {
            setState(() => _currentShading = _color);
            widget.onColorChanged(_color);
          },
          child: Container(
            color: const Color(0x00000000),
            // margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.fromLTRB(0, 7, 0, 7),
            child: Align(
              child: AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                duration: const Duration(milliseconds: 500),
                width: _currentShading == _color ? 335 : 230,
                height: 50,
                decoration: BoxDecoration(
                  color: _color,
                  boxShadow: _currentShading == _color
                      ? [
                    (_color == Colors.white) || (_color == Colors.black)
                        ? BoxShadow(
                      color: (Theme.of(context).brightness == Brightness.light) ? Colors.grey[300]! : Colors.black38,
                      blurRadius: 10,
                    )
                        : BoxShadow(
                      color: _color,
                      blurRadius: 10,
                    ),
                  ]
                      : null,
                  border: (_color == Colors.white) || (_color == Colors.black)
                      ? Border.all(color: (Theme.of(context).brightness == Brightness.light) ? Colors.grey[300]! : Colors.black38, width: 1)
                      : null,
                ),
                child: const SizedBox(),
              ),
            ),
          ),
        );
      },
      itemCount: _list.length,
    );
  }

  List<Map<Color, String>> _shadingTypes(List<Color> colors) {
    List<Map<Color, String>> result = [];

    for (Color colorType in colors) {
      if (colorType == Colors.grey) {
        result.addAll([50, 100, 200, 300, 350, 400, 500, 600, 700, 800, 850, 900]
            .map((int shade) => {Colors.grey[shade]!: shade.toString()})
            .toList());
      } else if (colorType == Colors.black || colorType == Colors.white) {
        result.addAll([
          {Colors.black: ''},
          {Colors.white: ''}
        ]);
      } else if (colorType is MaterialAccentColor) {
        result.addAll([100, 200, 400, 700].map((int shade) => {colorType[shade]!: 'A$shade'}).toList());
      } else if (colorType is MaterialColor) {
        result.addAll([50, 100, 200, 300, 400, 500, 600, 700, 800, 900]
            .map((int shade) => {colorType[shade]!: shade.toString()})
            .toList());
      } else {
        result.add({const Color(0x00000000): ''});
      }
    }

    return result;
  }

}