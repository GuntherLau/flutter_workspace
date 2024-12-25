
import 'package:flutter/material.dart';

class CustomExtensionStyle extends ThemeExtension<CustomExtensionStyle> {

  final Color? riveScaffoldBackgroundColor;
  final Color? backgroundColor;
  final Color? primaryTextColor;

  const CustomExtensionStyle({
    required this.riveScaffoldBackgroundColor,
    required this.backgroundColor,
    required this.primaryTextColor
  });

  @override
  ThemeExtension<CustomExtensionStyle> copyWith({
    Color? riveScaffoldBackgroundColor,
    Color? backgroundColor,
    Color? primaryTextColor
  }) {
    return CustomExtensionStyle(
        riveScaffoldBackgroundColor: riveScaffoldBackgroundColor ?? this.riveScaffoldBackgroundColor,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        primaryTextColor: primaryTextColor ?? this.primaryTextColor
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
        primaryTextColor: Color.lerp(primaryTextColor, other.primaryTextColor, t)
    );
  }

}