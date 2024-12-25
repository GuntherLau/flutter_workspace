import 'package:flutter/material.dart';

import 'app_colors.dart';

class CustomBottomNavStyles {
  static final BottomNavigationBarThemeData lightTheme = BottomNavigationBarThemeData(
    backgroundColor: AppColors.bottomNavLightBackground,
    // elevation: 0,
    unselectedItemColor: AppColors.itemUnselectedLightColor,
    selectedItemColor: AppColors.itemSelectedLightColor,
  );

  static final BottomNavigationBarThemeData darkTheme = BottomNavigationBarThemeData(
    backgroundColor: AppColors.bottomNavDarkBackground,
    // elevation: 0,
    unselectedItemColor: AppColors.itemUnselectedDarkColor,
    selectedItemColor: AppColors.itemSelectedDarkColor,
  );
}