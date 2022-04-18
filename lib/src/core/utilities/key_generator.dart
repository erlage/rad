import 'dart:math';

class KeyGenerator {
  static var _extraCounter = 0;
  static var _widgetCounter = 0;
  static final _random = Random();

  static String generateWidgetKey() {
    _widgetCounter++;
    return "_gen_" + _widgetCounter.toString() + "_" + KeyGenerator.random();
  }

  static String generateRandomKey() {
    _extraCounter++;
    return _extraCounter.toString() + "_" + KeyGenerator.random();
  }

  static String random([int length = 6]) {
    var cSet = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => cSet.codeUnitAt(
          (_random).nextInt(
            cSet.length,
          ),
        ),
      ),
    );
  }
}
