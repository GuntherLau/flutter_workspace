import 'package:flutter/material.dart';

class DateUtil {
  static const Duration _oneDay = Duration(days: 1);

  //  是否是今天
  static bool isToday(DateTime dateTime) {
    DateTime now = DateTime.now();
    return dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day;
  }

  static bool isBeforeNow(DateTime date) {
    final DateTime now = DateTime.now();

    // Handle year
    if (date.year < now.year) return true;
    if (date.year > now.year) return false;

    // Handle month (both dates should be on the same year)
    if (date.month < now.month) return true;
    if (date.month > now.month) return false;

    return date.day < now.day;
  }

  static bool isBeforeSome(DateTime date, DateTime some) {
    final DateTime now = some;

    // Handle year
    if (date.year < now.year) return true;
    if (date.year > now.year) return false;

    // Handle month (both dates should be on the same year)
    if (date.month < now.month) return true;
    if (date.month > now.month) return false;

    return date.day < now.day;
  }

  /// 将一个月中的所有日期作为DateTime列表返回，从上一个星期日开始，直到该月的最后一天
  static List<DateTime> daysOfTheMonth(DateTime firstDay) {
    final result = <DateTime>[];

    // First Sunday of the previous month till the first day
    DateTime dateIterator = previousMonday(firstDay);
    while (dateIterator.isBefore(firstDay)) {
      result.add(dateIterator);
      dateIterator = dateIterator.add(_oneDay);
    }

    // First day of the month
    result.add(firstDay);
    dateIterator = dateIterator.add(_oneDay);

    // last day of the month
    while (dateIterator.day != 1) {
      result.add(dateIterator);
      dateIterator = dateIterator.add(_oneDay);
    }

    return result;
  }

  /// 返回从今天起的前一个星期天
  static DateTime previousSunday(DateTime time) {
    DateTime result = time;

    while (result.weekday != 7) {
      result = result.subtract(_oneDay);
    }

    return result;
  }

  /// 返回从今天起的前一个星期一
  static DateTime previousMonday(DateTime time) {
    DateTime result = time;

    while (result.weekday != DateTime.monday) {
      result = result.subtract(_oneDay);
    }

    return result;
  }

  /// 返回这个月的第一天
  /// far 距离今天多少个月
  static DateTime firstDayOfTheMonth(int far) {
    DateTime result = DateTime.now().add(Duration(days: 28 * far));
    while(result.month - DateTime.now().month != far) {
      result = result.add(_oneDay);
    }
    while (result.day != 1) {
      result = result.subtract(_oneDay);
    }
    return result;
  }

  static String getWeekDay(DateTime date) {
    // List<String> weekdays = [
    //   "gtd_monday".tr, //  周一
    //   "gtd_tuesday".tr, //  周二
    //   "gtd_wednesday".tr, //  周三
    //   "gtd_thursday".tr, //  周四
    //   "gtd_friday".tr, //  周五
    //   "gtd_saturday".tr, //  周六
    //   "gtd_sunday".tr //  周日
    // ];
    List<String> weekdays = [
      "M", //  周一
      "T", //  周二
      "W", //  周三
      "T", //  周四
      "F", //  周五
      "S", //  周六
      "S" //  周日
    ];
    String weekday = weekdays[date.weekday - 1];
    return weekday;
  }

  //  返回 "02-16 周一" 格式
  static String gtdPickedDateFormat(DateTime time) {
    String month = time.month.toString().padLeft(2, "0");
    String day = time.day.toString().padLeft(2, "0");
    return "$month-$day ${getWeekDay(time)}";
  }

  //  返回 "今天/x天后/x天前" 格式
  static String gtdDiffDateFormat(DateTime time) {
    String diffDay = "今天";
    Duration diff = time.difference(DateTime.now());
    if (!isToday(time)) {
      if (time.isAfter(DateTime.now())) {
        diffDay = "${diff.inDays + 1}天后";
      } else {
        diffDay = "${diff.inDays.abs()}天前";
      }
    }
    return diffDay;
  }

  //  返回 "yyyy年MM月dd日" 格式
  static String gtdChineseFormat(DateTime time) {
    return "${time.year}年${time.month.toString().padLeft(2, "0")}月${time.day.toString().padLeft(2, "0")}日";
  }

  static String gtdEndDateFormat(DateTime date) {
    String text = "";
    if (DateTime.now().year == date.year) {
      //  xx-xx 周x
      text =
      "${date.month.toString().padLeft(2, "0")}-${date.day.toString().padLeft(2, "0")} ${getWeekDay(date)}";
    } else {
      //  xxxx-xx-xx 周x
      text =
      "${date.year}-${date.month.toString().padLeft(2, "0")}-${date.day.toString().padLeft(2, "0")} ${getWeekDay(date)}";
    }
    return text;
  }

  TimeOfDay parseTimeOfDay(String s) {
    return TimeOfDay(hour:int.parse(s.split(":")[0]),minute: int.parse(s.split(":")[1]));
  }

  static DateTime convertTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, time.hour, time.minute);
  }

  //  计算两个日期之间相隔多少天
  static int howManyDaysBetween(DateTime dateA, DateTime dateB) {
    return dateA.difference(dateB).inDays.abs();
  }

  //  获取time是这个月的第几周
  static int getWeekIndex(DateTime time) {
    // var time = DateTime.now(); //当前时间
    int day = time.day; //今天几号：1~31
    int week = time.weekday; // 今天周几：1~7
    int weekIndex = 0;
    for (int i=day; i>=1; i--) {
      week--;
      if (week <= 0) { // 到了周天，要+1
        week = 7;
        weekIndex++;
      }
    }
    if (week != DateTime.sunday) { // 第一天不是周日的话，要+1
      weekIndex++;
    }
    return weekIndex;
  }

  static int weeksBetween(DateTime from, DateTime to) {
    from = DateTime.utc(from.year, from.month, from.day);
    to = DateTime.utc(to.year, to.month, to.day);
    return (to.difference(from).inDays / 7).ceil();
  }

  //  获取某个日期是今年的第几天
  static int getDayOfYear(DateTime date) {
    final int year = date.year;
    final int month = date.month;
    final int day = date.day;

    int days = 0;

    for (int i = 1; i < month; i++) {
      days += DateUtil.getMonthDays(year, i);
    }

    days += day;

    if (isLeapYear(year) && month > 2) {
      days++;
    }

    return days;
  }

  //  获取某个特定月份的天数
  static int getMonthDays(int year, int month) {
    switch (month) {
      case 1:
      case 3:
      case 5:
      case 7:
      case 8:
      case 10:
      case 12:
        return 31;
      case 2:
        if (isLeapYear(year)) {
          return 29;
        } else {
          return 28;
        }
      case 4:
      case 6:
      case 9:
      case 11:
        return 30;
      default:
        throw ArgumentError('Invalid month: $month');
    }
  }

  //  用于判断某一年是否为闰年
  //  公历年份能被 4 整除的为闰年，但不能被 100 整除的年份不是闰年
  //  能被 400 整除的年份是闰年
  static bool isLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || year % 400 == 0;
  }

  //  获取date的这一周的开始时间 星期天
  static DateTime getWeekStart(DateTime date) {
    final int weekIndex = getWeekIndex(date);
    DateTime temp = DateTime(date.year, date.month, date.day);
    for(int i=1; i<8; i++) {
      temp = date.subtract(Duration(days: i));
      if(getWeekIndex(temp) != weekIndex) {
        break;
      }
    }
    temp.add(_oneDay);
    return DateTime(temp.year, temp.month, temp.day);
  }

  static DateTime getWeekEnd(DateTime date) {
    final int weekIndex = getWeekIndex(date);
    DateTime temp = date.add(_oneDay);
    while(getWeekIndex(temp) != weekIndex) {
      temp = date.add(_oneDay);
    }
    return temp.subtract(_oneDay);
  }

}
