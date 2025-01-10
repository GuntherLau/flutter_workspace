
import 'dart:ui';

import 'package:flutter/material.dart';

class ColorPickerService {

  static final ColorPickerService _instance = ColorPickerService._internal();
  ColorPickerService._internal();
  static ColorPickerService get instance => _instance;

  final List<List<Color>> _colorTypes = [
    [Colors.red, Colors.redAccent],
    [Colors.pink, Colors.pinkAccent],
    [Colors.purple, Colors.purpleAccent],
    [Colors.deepPurple, Colors.deepPurpleAccent],
    [Colors.indigo, Colors.indigoAccent],
    [Colors.blue, Colors.blueAccent],
    [Colors.lightBlue, Colors.lightBlueAccent],
    [Colors.cyan, Colors.cyanAccent],
    [Colors.teal, Colors.tealAccent],
    [Colors.green, Colors.greenAccent],
    [Colors.lightGreen, Colors.lightGreenAccent],
    [Colors.lime, Colors.limeAccent],
    [Colors.yellow, Colors.yellowAccent],
    [Colors.amber, Colors.amberAccent],
    [Colors.orange, Colors.orangeAccent],
    [Colors.deepOrange, Colors.deepOrangeAccent],
    [Colors.brown],
    [Colors.grey],
    [Colors.blueGrey],
    [Colors.black],
  ];

  List<List<Color>> get colorTypes => _colorTypes;

  List<Map<Color, String>> subColors(int index) {
    return _shadingTypes(_colorTypes[index]);
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

  Color getColorByIndex(int categoryIndex, int colorIndex) {
    return subColors(categoryIndex)[colorIndex].keys.first;
  }

  ColorInfo? getInfo(Color color) {
    for(int i=0; i<_colorTypes.length; i++) {
      List<Map<Color, String>> colorList = subColors(i);
      for(int j=0; j<colorList.length; j++) {
        if(colorList[j].keys.first == color) {
          return ColorInfo(i, j);
        }
      }
    }
    return null;
  }


}

class ColorInfo {
  int categoryIndex;
  int colorIndex;

  ColorInfo(this.categoryIndex, this.colorIndex);
}