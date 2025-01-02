
import 'package:common/main.dart';
import 'package:flutter/material.dart';

class AppColors {

  static final Color pageLightBackground = "#f0f0f0".color;
  static final Color pageDarkBackground = "#F223355".color;

  static final Color primary = "#F50C9FF".color;
  static final Color secondary = "#FC698C".color;
  static final Color black = "#000000".color;
  static final Color white = "#FFFFFF".color;

  static final itemUnselectedLightColor = "#a0a8b5".color;
  static final itemUnselectedDarkColor = "#708096".color;

  static final itemSelectedLightColor = "#000a44".color;
  static final itemSelectedDarkColor = "#d6dae0".color;

  static final bottomNavLightBackground = white;
  static final bottomNavDarkBackground = "#2a4261".color;


  /// Returns a shade of a [Color] from a double value
  ///
  /// The 'darker' boolean determines whether the shade
  /// should be .1 darker or lighter than the provided color
  static Color getShade(Color color, {bool darker = false, double value = .1}) {
    assert(value >= 0 && value <= 1, 'shade values must be between 0 and 1');

    final hsl = HSLColor.fromColor(color);
    final hslDark = hsl.withLightness(
      (darker ? (hsl.lightness - value) : (hsl.lightness + value)).clamp(0.0, 1.0),
    );
    return hslDark.toColor();
  }

  /// Returns a [MaterialColor] from a [Color] object
  static MaterialColor getMaterialColorFromColor(Color color) {
    final colorShades = <int, Color>{
      50: getShade(color, value: 0.5),
      100: getShade(color, value: 0.4),
      200: getShade(color, value: 0.3),
      300: getShade(color, value: 0.2),
      400: getShade(color, value: 0.1),
      500: color, //Primary value
      600: getShade(color, value: 0.1, darker: true),
      700: getShade(color, value: 0.15, darker: true),
      800: getShade(color, value: 0.2, darker: true),
      900: getShade(color, value: 0.25, darker: true),
    };
    return MaterialColor(color.value, colorShades);
  }

}