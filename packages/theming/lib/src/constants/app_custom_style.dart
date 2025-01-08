

import 'dart:ui';

import 'package:flutter/material.dart';

import '../../main.dart';
import 'custom_extension_style.dart';

class AppCustomStyle {

  static final lightTheme = CustomExtensionStyle(
      riveScaffoldBackgroundColor: const Color(0xFF329CFF),
      backgroundColor: const Color(0xFFF7F7FC),
      primaryTextColor: AppColors.black,
      drawerBackgroundColor: Colors.white,
      calenderCellBgColor: Colors.white
  );

  static final darkTheme = CustomExtensionStyle(
      riveScaffoldBackgroundColor: const Color(0xFF394058),
      backgroundColor: const Color(0xFF010101),
      primaryTextColor: AppColors.white,
      drawerBackgroundColor: Colors.black,
      calenderCellBgColor: Colors.blueGrey
  );

}