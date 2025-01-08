
import 'package:flutter/material.dart';

class CustomExtensionStyle extends ThemeExtension<CustomExtensionStyle> {

  final Color? riveScaffoldBackgroundColor;
  final Color? backgroundColor;
  final Color? primaryTextColor;
  final Color? drawerBackgroundColor;
  final Color? calenderCellBgColor;

  CustomExtensionStyle({
    required this.riveScaffoldBackgroundColor,
    required this.backgroundColor,
    required this.primaryTextColor,
    required this.drawerBackgroundColor,
    this.calenderCellBgColor
  });

  @override
  ThemeExtension<CustomExtensionStyle> copyWith({
    Color? riveScaffoldBackgroundColor,
    Color? backgroundColor,
    Color? primaryTextColor,
    Color? drawerBackgroundColor,
    Color? calenderCellBgColor
  }) {
    return CustomExtensionStyle(
        riveScaffoldBackgroundColor: riveScaffoldBackgroundColor ?? this.riveScaffoldBackgroundColor,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        primaryTextColor: primaryTextColor ?? this.primaryTextColor,
        drawerBackgroundColor: drawerBackgroundColor ?? this.drawerBackgroundColor,
        calenderCellBgColor: calenderCellBgColor ?? this.calenderCellBgColor
    );
  }

  @override
  ThemeExtension<CustomExtensionStyle> lerp(covariant ThemeExtension<CustomExtensionStyle>? other, double t) {
    if (other is! CustomExtensionStyle) {
      return this;
    }
    return CustomExtensionStyle(
        riveScaffoldBackgroundColor: Color.lerp(riveScaffoldBackgroundColor, other.riveScaffoldBackgroundColor, t),
        backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
        primaryTextColor: Color.lerp(primaryTextColor, other.primaryTextColor, t),
        drawerBackgroundColor: Color.lerp(drawerBackgroundColor, other.drawerBackgroundColor, t),
        calenderCellBgColor: Color.lerp(calenderCellBgColor, other.calenderCellBgColor, t)
    );
  }

}