import 'dart:math';

class Utils {
  static String random([int length = 6]) => String.fromCharCodes(Iterable.generate(
      length,
      (_) => 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890'
          .codeUnitAt((Random()).nextInt('AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890'.length))));
}
