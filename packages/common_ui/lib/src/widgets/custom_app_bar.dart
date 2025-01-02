import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'custom_leading_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? appBarTitleText;
  final List<Widget>? actions;
  final bool showLeading;
  final Widget? leading;
  final Widget? titleView;
  final Color? backgroundColor;
  final double? leadingWidth;
  final double? titleSpacing;
  final AppBarTheme? appBarTheme;
  final double? elevation;
  final double? height;
  final SystemUiOverlayStyle? systemOverlayStyle;

  const CustomAppBar({
    super.key,
    this.appBarTitleText,
    this.actions,
    this.showLeading = true,
    this.leading,
    this.titleView,
    this.backgroundColor,
    this.leadingWidth,
    this.titleSpacing,
    this.appBarTheme,
    this.elevation = 0,
    this.height,
    this.systemOverlayStyle,
  });

  @override
  Size get preferredSize {
    return height != null
        ? Size(AppBar().preferredSize.width, height!)
        : AppBar().preferredSize;
  }

  @override
  Widget build(BuildContext context) {
    final theme = appBarTheme;// ?? ThemeService().theme.appBarTheme;
    return SizedBox(
      height: AppBar().preferredSize.height + MediaQuery.of(context).padding.top,
      child: AppBar(
        // iconTheme: theme.iconTheme,
        backgroundColor: backgroundColor,// ?? theme.backgroundColor,
        leading: leading ?? Container(
            alignment: Alignment.centerRight,
            child: const CustomLeadingWidget()
        ),
        leadingWidth: leadingWidth,
        elevation: elevation,
        automaticallyImplyLeading: showLeading,
        actions: actions,
        titleSpacing: titleSpacing,
        centerTitle: true,
        systemOverlayStyle: systemOverlayStyle,
        title: titleView ??
            Text(
              appBarTitleText ?? '',
              // style: ThemeService().theme.textTheme.titleSmall?.copyWith(
              //     fontSize: 16.sp,
              //     fontFamily: FontThemes.medium,
              //     color: Colors.white
              // ),
            ),
      ),
    );
  }

  static fillHeight(BuildContext context) {
    return AppBar().preferredSize.height + MediaQuery.of(context).padding.top;
  }

}