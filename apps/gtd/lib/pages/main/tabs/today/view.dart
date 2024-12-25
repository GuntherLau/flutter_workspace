
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gtd/pages/main/widgets/main_drawer_controller.dart';
import 'package:theming/main.dart';

import 'logic.dart';

class TabTodayComponent extends StatefulWidget {
  @override
  State<TabTodayComponent> createState() => _TabTodayComponentState();
}

class _TabTodayComponentState extends State<TabTodayComponent> with CustomThemeSwitchingStatefulMixin<TabTodayComponent> {
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
      appBar: AppBar(
        title: const Text("Today"),
        leading: IconButton(
          icon: const Icon(Icons.list),
          onPressed: () {
            Get.find<MainDrawerController>().zoomDrawerController.toggle?.call();
          },
        ),
        actions: [

          IconButton(
            icon: const Icon(Icons.list),
            onPressed: () {
              Get.find<MainDrawerController>().zoomDrawerController.toggle?.call();
            },
          )
        ],
      ),
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