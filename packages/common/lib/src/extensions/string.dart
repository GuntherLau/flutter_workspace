import 'package:flutter/material.dart';

extension StringExtension on String {

  //  #000000 => Color(0xFF000000)
  Color get color {
    int hexColor = int.parse(trim().substring(1), radix: 16);
    return Color.fromARGB(255, (hexColor >> 16) & 0xFF, (hexColor >> 8) & 0xFF, hexColor & 0xFF);
  }

}