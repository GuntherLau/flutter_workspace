import 'package:get/get.dart';
import 'package:gtd/model/task.dart';
import 'package:gtd/services/extension_sqlite_service.dart';
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
    state.tasks.value = await SqliteService.instance.queryByFinishTime<Task>(DateTime.now());
    print("unfinishTasks:${state.tasks.length}");
    for(var task in state.tasks){
      print("task:${task.name} finishTime:${task.finishTime}");
    }

  }

}
