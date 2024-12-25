import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:theming/main.dart';

import 'logic.dart';

class TabSettingsComponent extends StatefulWidget {
  @override
  State<TabSettingsComponent> createState() => _TabSettingsComponentState();
}

class _TabSettingsComponentState extends State<TabSettingsComponent> with CustomThemeSwitchingStatefulMixin<TabSettingsComponent> {
  final logic = Get.put(TabSettingsLogic());
  final state = Get.find<TabSettingsLogic>().state;

  @override
  void dispose() {
    Get.delete<TabSettingsLogic>();
    super.dispose();
  }

  @override
  Widget buildWithTheme(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: const Text("Settings", style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white
        )),
      ),
    );
  }
}