

import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';

class CustomThemeSwitchingWidget extends StatelessWidget {

  final BuilderWithTheme builder;

  const CustomThemeSwitchingWidget({super.key,  required this.builder});

  @override
  Widget build(BuildContext context) {
    return ThemeSwitcher.withTheme(
      builder: (context, switcher, theme) {
        return builder(context, switcher, theme);
      },
    );
  }

}