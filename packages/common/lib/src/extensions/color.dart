
import 'dart:ui';

extension ColorExtension on Color {

  //  Color(0xFF000000) => #000000
  String get hex {
    return '#${value.toRadixString(16).substring(2)}';
  }

}