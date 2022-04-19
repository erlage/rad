import 'dart:math';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/objects/build_context.dart';

/// Key generator service.
///
class KeyGen {
  /// Random instance.
  ///
  final _random = Random();

  /// Root context.
  ///
  final BuildContext rootContext;

  final systemPrefix = Constants.contextGenKeyPrefix;

  var _extraCounter = 0;
  var _widgetCounter = 0;

  KeyGen(this.rootContext);

  String generateWidgetKey() {
    _widgetCounter++;

    return "$systemPrefix${rootContext.appTargetKey}_$_widgetCounter";
  }

  String generateRandomKey() {
    _extraCounter++;

    return "${_extraCounter}_${rootContext.appTargetKey}";
  }

  String random([int length = 6]) {
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
