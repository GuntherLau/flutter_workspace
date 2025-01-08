

import 'package:flutter/material.dart';
import 'package:theming/src/constants/custom_extension_style.dart';

class ThemeService {

  static final ThemeService _instance = ThemeService._internal();
  ThemeService._internal();
  static ThemeService get instance => _instance;

  // static getExtendedTheme<T>(BuildContext context) {
  //   final customExtensionStyle = Theme.of(context).extension<T>();
  //   return customExtensionStyle;
  // }

  CustomExtensionStyle getCustomExtensionStyle(BuildContext context) {
    final customExtensionStyle = Theme.of(context).extension<CustomExtensionStyle>();
    return customExtensionStyle!;
  }

  bool isDark(BuildContext context) {
    bool isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark;
  }

}
