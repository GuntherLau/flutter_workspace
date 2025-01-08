
extension DateTimeExt on DateTime {

  String get yyyyMM {
    DateTime date = toLocal();
    String year = date.year.toString();
    String month = date.month.toString().padLeft(2, '0');
    return "$year-$month";
  }

  String get yyyyMMdd {
    DateTime date = toLocal();
    String year = date.year.toString();
    String month = date.month.toString().padLeft(2, '0');
    String day = date.day.toString().padLeft(2, '0');
    return "$year-$month-$day";
  }

  String get hhMM {
    DateTime date = toLocal();
    String hour = date.hour.toString().padLeft(2, '0');
    String minute = date.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }

  String get yyyyMMdd$hhMMss {
    DateTime date = toLocal();
    String year = date.year.toString();
    String month = date.month.toString().padLeft(2, '0');
    String day = date.day.toString().padLeft(2, '0');
    String hour = date.hour.toString().padLeft(2, '0');
    String minute = date.minute.toString().padLeft(2, '0');
    String second = date.second.toString().padLeft(2, '0');
    return "$year-$month-$day $hour:$minute:$second";
  }

  /// 判断是否是同一天（年月日相等）
  bool isSameDay(DateTime? selectedDate) {
    if (selectedDate == null) return false;

    DateTime date = selectedDate.toLocal();

    if (year != date.year) return false;

    if (month != date.month) return false;

    return day == date.day;
  }

}