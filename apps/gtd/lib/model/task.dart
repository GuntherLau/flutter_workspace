import 'package:common/main.dart';
import 'package:json_annotation/json_annotation.dart';

import '../main.dart';
part 'task.g.dart';

enum TaskRepeatType {
  weekRegular,
  weekRandom,
  monthRegular,
  monthRandom,
}

extension TaskRepeatTypeExtension on TaskRepeatType {
  int get value {
    switch (this) {
      case TaskRepeatType.weekRegular:
        return 0;
      case TaskRepeatType.weekRandom:
        return 1;
      case TaskRepeatType.monthRegular:
        return 2;
      case TaskRepeatType.monthRandom:
        return 3;
    }
  }
}

enum TaskNeedRemind {
  false_,
  true_,
}

@reflectorModel
@JsonSerializable()
class Task extends JsonSerializableModel {
  String? id;
  String? name;        //  名称
  int? repeatType;     //  重复周期，0:周定期,1:周随机,2:月定期,3:月随机
  String? jsonWeek;    //  周定期
  int? weekRandom;     //  周随机
  String? jsonMonth;   //  月定期
  int? monthRandom;    //  月随机
  int? needRemind;     //  是否提醒 0: false, 1:true
  int? alarmIndex;     //  铃声
  String? jsonRemind;  //  提醒时间
  int? createTime;     //  开始日期
  int? finishTime;     //  结束日期
  int? finishType;     //  结束类型，0:7天，1:21天，2:1个月，3:3个月，4：半年，5：1年，6：无限期，7：自定义（自定义时finish_time不能为空）
  int? dailyTimes;     //  每日x次

  Task({
    this.id,
    this.name,
    this.repeatType,
    this.jsonWeek,
    this.weekRandom,
    this.jsonMonth,
    this.monthRandom,
    this.needRemind,
    this.alarmIndex,
    this.jsonRemind,
    this.createTime,
    this.finishTime,
    this.finishType,
    this.dailyTimes,
  });

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TaskToJson(this);

  Task.defaultValue() {
    id = '';
    name = '';
    repeatType = 0;
    jsonWeek = '';
    weekRandom = 0;
    jsonMonth = '';
    monthRandom = 0;
    needRemind = 0;
    alarmIndex = 0;
    jsonRemind = '';
    createTime = 0;
    finishTime = 0;
    finishType = 0;
    dailyTimes = 0;
  }

  @override
  String toString() {
    return 'Task{id: $id, name: $name, repeatType: $repeatType, jsonWeek: $jsonWeek, weekRandom: $weekRandom, jsonMonth: $jsonMonth, monthRandom: $monthRandom, needRemind: $needRemind, alarmIndex: $alarmIndex, jsonRemind: $jsonRemind, createTime: $createTime, finishTime: $finishTime, finishType: $finishType, dailyTimes: $dailyTimes}';
  }
}