

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';

import '../constants/app_themes.dart';

class CustomThemeProvider extends StatelessWidget {

  final Widget child;
  const CustomThemeProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      initTheme: AppThemes.darkTheme,
      builder: (context, theme) {
        return child;
      },
    );
  }

}