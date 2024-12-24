import 'package:get/get.dart';

import 'logic.dart';

class TaskDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TaskDetailLogic());
  }
}
