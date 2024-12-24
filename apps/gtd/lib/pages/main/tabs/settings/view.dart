import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class TabSettingsComponent extends StatefulWidget {
  @override
  State<TabSettingsComponent> createState() => _TabSettingsComponentState();
}

class _TabSettingsComponentState extends State<TabSettingsComponent> {
  final logic = Get.put(TabSettingsLogic());
  final state = Get.find<TabSettingsLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Text("Settings", style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white
      )),
    );
  }

  @override
  void dispose() {
    Get.delete<TabSettingsLogic>();
    super.dispose();
  }
}