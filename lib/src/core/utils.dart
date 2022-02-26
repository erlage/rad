import 'dart:math';

import 'package:trad/src/core/enums.dart';

class Utils {
  static String mapDomTag(DomTag tag) {
    switch (tag) {
      case DomTag.div:
        return "div";

      case DomTag.span:
      default:
        return "span";
    }
  }

  static String mapMeasuringUnit(MeasuringUnit unit) {
    switch (unit) {
      case MeasuringUnit.percent:
        return "%";

      case MeasuringUnit.pixel:
      default:
        return "px";
    }
  }

  static String random([int length = 6]) {
    var cSet = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => cSet.codeUnitAt(
          (Random()).nextInt(
            cSet.length,
          ),
        ),
      ),
    );
  }
}
