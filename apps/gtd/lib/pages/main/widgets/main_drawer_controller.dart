

import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:state_management/main.dart';

class MainDrawerController extends GetxController {

  final zoomDrawerController = ZoomDrawerController();

  void toggleDrawer() {
    zoomDrawerController.toggle?.call();
    update();
  }

}