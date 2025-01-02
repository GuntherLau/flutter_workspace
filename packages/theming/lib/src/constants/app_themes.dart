
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';
import 'custom_extension_style.dart';
import 'custom_bottom_nav_styles.dart';

class AppThemes {

  static final lightTheme = ThemeData(
    useMaterial3: true,

    extensions: <ThemeExtension<dynamic>>{CustomExtensionStyle(
        riveScaffoldBackgroundColor: const Color(0xFF329CFF),
        backgroundColor: const Color(0xFFF7F7FC),
        primaryTextColor: AppColors.black,
        drawerBackgroundColor: Colors.white
    )},

    // fontFamily: AppTextStyles.fontFamily,
    // textTheme: TextThemes.lightTextTheme,
    // primaryTextTheme: TextThemes.primaryTextTheme,
    primaryColor: AppColors.getMaterialColorFromColor(AppColors.primary),
    scaffoldBackgroundColor: AppColors.pageLightBackground,

    /// splashColor + highlightColor 消除水波纹特效
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,

    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.black,
        foregroundColor: AppColors.white
    ),

    // drawerTheme: DrawerThemeData(
    // ),
    appBarTheme: AppBarTheme(
        backgroundColor: AppColors.pageLightBackground,
        /// https://stackoverflow.com/questions/72379271/flutter-material3-disable-appbar-color-change-on-scroll
        surfaceTintColor: Colors.transparent
    ),
    bottomNavigationBarTheme: CustomBottomNavStyles.lightTheme,
    dividerTheme: const DividerThemeData(color: Colors.grey), colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      background: AppColors.pageLightBackground,
    ).copyWith(background: AppColors.pageLightBackground),
  );

  static final darkTheme = ThemeData(
      useMaterial3: true,

      extensions: <ThemeExtension<dynamic>>{CustomExtensionStyle(
          riveScaffoldBackgroundColor: const Color(0xFF394058),
          backgroundColor: const Color(0xFF010101),
          primaryTextColor: AppColors.white,
          drawerBackgroundColor: Colors.black
      )},

      // fontFamily: AppTextStyles.fontFamily,
      // textTheme: TextThemes.darkTextTheme,
      // primaryTextTheme: TextThemes.primaryTextTheme,
      primaryColor: AppColors.getMaterialColorFromColor(AppColors.primary),
      scaffoldBackgroundColor: AppColors.pageDarkBackground,

      /// splashColor + highlightColor 消除水波纹特效
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.black
      ),
      // drawerTheme: DrawerThemeData(
      // ),
      appBarTheme: AppBarTheme(
          backgroundColor: AppColors.pageDarkBackground,
          /// https://stackoverflow.com/questions/72379271/flutter-material3-disable-appbar-color-change-on-scroll
          surfaceTintColor: Colors.transparent
      ),

      bottomNavigationBarTheme: CustomBottomNavStyles.darkTheme,
      dividerTheme: const DividerThemeData(color: Colors.grey), colorScheme: ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        background: AppColors.pageDarkBackground,
      ).copyWith(background: AppColors.pageDarkBackground)
  );

}