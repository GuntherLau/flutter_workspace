import 'dart:math';
import 'dart:ui';

class RandomUtil {

  static int nextInt({ int min = 0, int max = 100 }) {
    var x = Random().nextInt(max) + min;
    return x.floor();
  }

  static Color nextColor() {
    return Color.fromRGBO(
        nextInt(max: 255),
        nextInt(max: 255),
        nextInt(max: 255),
        1
    );
  }

}