import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theming/main.dart';

import 'logic.dart';

class TabTodayComponent extends StatefulWidget {
  @override
  State<TabTodayComponent> createState() => _TabTodayComponentState();
}

class _TabTodayComponentState extends State<TabTodayComponent> with CustomThemeSwitchingMixin<TabTodayComponent> {
  final logic = Get.put(TabTodayLogic());
  final state = Get.find<TabTodayLogic>().state;

  @override
  void dispose() {
    Get.delete<TabTodayLogic>();
    super.dispose();
  }

  @override
  Widget buildWithTheme(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: const Text("Today", style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white
        )),
      ),
    );
  }
}