import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class TabTodayComponent extends StatefulWidget {
  @override
  State<TabTodayComponent> createState() => _TabTodayComponentState();
}

class _TabTodayComponentState extends State<TabTodayComponent> {
  final logic = Get.put(TabTodayLogic());
  final state = Get.find<TabTodayLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Text("Today", style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white
      )),
    );
  }

  @override
  void dispose() {
    Get.delete<TabTodayLogic>();
    super.dispose();
  }
}