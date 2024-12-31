

import 'package:storage/main.dart';

import '../model/task.dart';

extension SqliteServiceExtension on SqliteService {

  Future<List<Task>> queryByFinishTime<T>(DateTime finishTime) async {
    return queryByCondition("finishTime >= ?", [finishTime.millisecondsSinceEpoch], Task.fromJson);
  }
}