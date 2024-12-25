

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class CustomThemeSwitcher  extends StatelessWidget {
  const CustomThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeSwitcher.withTheme(
      builder: (_, switcher, theme) {
        return IconButton(
          onPressed: () => switcher.changeTheme(
            theme: theme.brightness == Brightness.light
                ? AppThemes.darkTheme
                : AppThemes.lightTheme,
          ),
          icon: Icon(theme.brightness == Brightness.light ? Icons.sunny : Icons.brightness_3, size: 25),
        );
      },
    );
  }

}