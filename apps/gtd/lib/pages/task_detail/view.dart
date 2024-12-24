import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'logic.dart';

class TaskDetailPage extends StatefulWidget {
  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  final logic = Get.find<TaskDetailLogic>();
  final state = Get.find<TaskDetailLogic>().state;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void dispose() {
    Get.delete<TaskDetailLogic>();
    super.dispose();
  }
}