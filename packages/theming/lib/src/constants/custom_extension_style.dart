
import 'package:flutter/material.dart';

class CustomExtensionStyle extends ThemeExtension<CustomExtensionStyle> {

  final Color? riveScaffoldBackgroundColor;
  final Color? backgroundColor;
  final Color? primaryTextColor;
  final Color? drawerBackgroundColor;

  const CustomExtensionStyle({
    required this.riveScaffoldBackgroundColor,
    required this.backgroundColor,
    required this.primaryTextColor,
    required this.drawerBackgroundColor
  });

  @override
  ThemeExtension<CustomExtensionStyle> copyWith({
    Color? riveScaffoldBackgroundColor,
    Color? backgroundColor,
    Color? primaryTextColor,
    Color? drawerBackgroundColor
  }) {
    return CustomExtensionStyle(
        riveScaffoldBackgroundColor: riveScaffoldBackgroundColor ?? this.riveScaffoldBackgroundColor,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        primaryTextColor: primaryTextColor ?? this.primaryTextColor,
        drawerBackgroundColor: drawerBackgroundColor ?? this.drawerBackgroundColor
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
        drawerBackgroundColor: Color.lerp(drawerBackgroundColor, other.drawerBackgroundColor, t)
    );
  }

}