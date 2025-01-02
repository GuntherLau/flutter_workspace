

import 'package:flutter/material.dart';
import 'package:theming/src/constants/custom_extension_style.dart';

class ThemeService {


  // static getExtendedTheme<T>(BuildContext context) {
  //   final customExtensionStyle = Theme.of(context).extension<T>();
  //   return customExtensionStyle;
  // }

  static getCustomExtensionStyle(BuildContext context) {
    final customExtensionStyle = Theme.of(context).extension<CustomExtensionStyle>();
    return customExtensionStyle;
  }

}
