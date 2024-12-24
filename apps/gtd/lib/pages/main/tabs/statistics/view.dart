import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class TabStatisticsComponent extends StatefulWidget {
  @override
  State<TabStatisticsComponent> createState() => _TabStatisticsComponentState();
}

class _TabStatisticsComponentState extends State<TabStatisticsComponent> {
  final logic = Get.put(TabStatisticsLogic());
  final state = Get.find<TabStatisticsLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: const Text("Statistics", style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white
      )),
    );
  }

  @override
  void dispose() {
    Get.delete<TabStatisticsLogic>();
    super.dispose();
  }
}