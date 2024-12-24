import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'tabs/settings/view.dart';
import 'tabs/statistics/view.dart';
import 'tabs/today/view.dart';

class MainState {
  MainState() {
    ///Initialize variables
  }

  final bottomNavIndex = 0.obs;
  final List<BottomNavigationBarItem> bottomButtons = [
    const BottomNavigationBarItem(icon: Icon(CupertinoIcons.today), label: "Today"),
    const BottomNavigationBarItem(icon: Icon(CupertinoIcons.chart_bar), label: "Statistics"),
    const BottomNavigationBarItem(icon: Icon(CupertinoIcons.settings), label: "Settings")
  ];
  final List<Widget> pages = [
    TabTodayComponent(),
    TabStatisticsComponent(),
    TabSettingsComponent(),
  ];

}
