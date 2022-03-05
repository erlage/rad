import 'dart:math';

import 'package:rad/src/core/enums.dart';

class Utils {
  static var _extraCounter = 0;
  static var _widgetCounter = 0;

  static String generateWidgetKey() {
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
    }
  }

  static String mapMeasuringUnit(MeasuringUnit unit) {
    switch (unit) {
      case MeasuringUnit.percent:
        return "%";

      case MeasuringUnit.pixel:
        return "px";
    }
  }

  static String mapAxisForFlex(Axis axis) {
    switch (axis) {
      case Axis.horizontal:
        return "row";

      case Axis.vertical:
        return "column";
    }
  }

  static String mapFlexWrap(FlexWrap flexWrap) {
    switch (flexWrap) {
      case FlexWrap.nowrap:
        return "nowrap";

      case FlexWrap.wrap:
        return "wrap";

      case FlexWrap.wrapReverse:
        return "wrap-reverse";
    }
  }

  static String mapMainAxisAlignment(MainAxisAlignment mainAxisAlignment) {
    switch (mainAxisAlignment) {
      case MainAxisAlignment.start:
        return "flex-start";

      case MainAxisAlignment.end:
        return "flex-end";

      case MainAxisAlignment.center:
        return "center";

      case MainAxisAlignment.spaceBetween:
        return "space-between";

      case MainAxisAlignment.spaceAround:
        return "space-around";

      case MainAxisAlignment.spaceEvenly:
        return "space-evenly";
    }
  }

  static String mapCrossAxisAlignment(CrossAxisAlignment crossAxisAlignment) {
    switch (crossAxisAlignment) {
      case CrossAxisAlignment.baseline:
        return "baseline";

      case CrossAxisAlignment.start:
        return "flex-start";

      case CrossAxisAlignment.end:
        return "flex-end";

      case CrossAxisAlignment.center:
        return "center";

      case CrossAxisAlignment.stretch:
        return "stretch";
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
