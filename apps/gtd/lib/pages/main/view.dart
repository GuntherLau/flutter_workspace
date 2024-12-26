import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:theming/main.dart';

import '../../widgets/custom_quick_add_task_sheet.dart';
import 'logic.dart';
import 'state.dart';
import 'widgets/main_drawer.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final MainLogic logic = Get.put(MainLogic());
  final MainState state = Get.find<MainLogic>().state;

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Builder(builder: (context) {
        return ZoomDrawer(
          controller: logic.mainDrawerController.zoomDrawerController,
          menuScreen: MainDrawer(),
          mainScreen: _buildContent(context),
          mainScreenScale: 0.2,
          mainScreenTapClose: true,
          borderRadius: 24.0,
          showShadow: true,
          angle: 0,
          drawerShadowsBackgroundColor: Colors.grey,
          slideWidth: MediaQuery.of(context).size.width * 0.65,
        );
      }),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<MainLogic>();
    super.dispose();
  }

  Widget _buildContent(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _buildTabView(context),
      bottomNavigationBar: _buildBottomNav(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCustomQuickAddTaskSheet(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  _buildTabView(BuildContext content) {
    return Obx(() => IndexedStack(
      index: state.bottomNavIndex.value,
      children: List.generate(state.pages.length, (index) => state.pages[index]).toList(),
    ));
  }

  _buildBottomNav(BuildContext context) {
    return Obx(() => BottomNavigationBar(
      currentIndex: state.bottomNavIndex.value,
      type: BottomNavigationBarType.fixed,
      items: List.generate(state.bottomButtons.length, (index) {
        return state.bottomButtons[index];
      }),
      onTap: logic.onBottomNavClicked,
    ));
  }

}
