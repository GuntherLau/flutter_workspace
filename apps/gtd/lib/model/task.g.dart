// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      repeatType: (json['repeatType'] as num?)?.toInt(),
      jsonWeek: json['jsonWeek'] as String?,
      weekRandom: (json['weekRandom'] as num?)?.toInt(),
      jsonMonth: json['jsonMonth'] as String?,
      monthRandom: (json['monthRandom'] as num?)?.toInt(),
      needRemind: (json['needRemind'] as num?)?.toInt(),
      alarmIndex: (json['alarmIndex'] as num?)?.toInt(),
      jsonRemind: json['jsonRemind'] as String?,
      createTime: (json['createTime'] as num?)?.toInt(),
      finishTime: (json['finishTime'] as num?)?.toInt(),
      finishType: (json['finishType'] as num?)?.toInt(),
      dailyTimes: (json['dailyTimes'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'repeatType': instance.repeatType,
      'jsonWeek': instance.jsonWeek,
      'weekRandom': instance.weekRandom,
      'jsonMonth': instance.jsonMonth,
      'monthRandom': instance.monthRandom,
      'needRemind': instance.needRemind,
      'alarmIndex': instance.alarmIndex,
      'jsonRemind': instance.jsonRemind,
      'createTime': instance.createTime,
      'finishTime': instance.finishTime,
      'finishType': instance.finishType,
      'dailyTimes': instance.dailyTimes,
    };
