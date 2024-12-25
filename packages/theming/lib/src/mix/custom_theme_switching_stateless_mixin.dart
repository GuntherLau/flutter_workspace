import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';

abstract class CustomThemeSwitchingStatelessMixin extends StatelessWidget {

  const CustomThemeSwitchingStatelessMixin({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: buildWithTheme(context),
    );
  }

  /// 子类需要实现的构建方法
  Widget buildWithTheme(BuildContext context);

}
