import 'package:get/get.dart';
import 'package:gtd/model/task.dart';
import 'package:storage/main.dart';

import 'state.dart';

class TabTodayLogic extends GetxController {
  final TabTodayState state = TabTodayState();

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    loadTasks();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  Future<void> loadTasks() async {
    List<Task> tasks = await SqliteService.instance.queryAll<Task>(Task.fromJson);
    print("任务总数:${tasks.length}");
  }

}
