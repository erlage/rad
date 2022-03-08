import 'dart:math';

import 'package:rad/src/core/enums.dart';

class Utils {
  static var _extraCounter = 0;
  static var _widgetCounter = 0;

  static String generateWidgetId() {
    _widgetCounter++;
    return _widgetCounter.toString() + "_" + Utils.random();
  }

  static String generateRandomId() {
    _extraCounter++;
    return _extraCounter.toString() + "_" + Utils.random();
  }

  static String mapDomTag(DomTag tag) {
    switch (tag) {
      case DomTag.div:
        return "div";

      case DomTag.span:
        return "span";

      case DomTag.anchor:
        return "a";

      case DomTag.blockquote:
        return "blockquote";

      case DomTag.horizontalRule:
        return "hr";

      case DomTag.label:
        return "label";

      case DomTag.iFrame:
        return "iframe";
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
