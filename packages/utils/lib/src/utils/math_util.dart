

import 'dart:math' as math;

class MathUtil {

  /**
   * 角度转换成弧度
   * 角度 = 弧度 * 180 / pi
   */
  static double radiansToDegrees(double radians) {
    return radians * 180 / math.pi;
  }

  //  向上取整（返回int）3.1返回4
  static int ceil(double num) {
    return num.ceil();
  }

  //  向下取整(返回int) 3.1返回3
  static int truncate(double num) {
    return num.truncate();
  }

  //  四舍五入取整(返回int) 3.1返回3
  static int round(double num) {
    return num.round();
  }

  //  向上取整（返回double）3.1返回4.0
  static double ceilToDouble(double num) {
    return num.ceilToDouble();
  }

  //  向下取整(返回double) 3.1返回3.0
  static double truncateToDouble(double num) {
    return num.truncateToDouble();
  }

  //  四舍五入取整(返回double) 3.1返回3.0
  static double roundToDouble(double num) {
    return num.roundToDouble();
  }

  //  toStringAsFixed()会进行四舍五入 10/3会返回3.33
  static String toStringAsFixed(double num, int length) {
    return num.toStringAsFixed(length);
  }

  //  返回int类型随机数
  static int randomInt(int min, int max) {
    return min + math.Random().nextInt(max - min);
  }

  static bool randomBool() {
    return math.Random().nextBool();
  }

}