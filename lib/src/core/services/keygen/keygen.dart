import 'dart:math';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/objects/build_context.dart';

/// Key generator service.
///
class KeyGen {
  /// Root context.
  ///
  final BuildContext rootContext;

  KeyGen(this.rootContext);

  var _extraCounter = 0;
  var _widgetCounter = 0;
  final _random = Random();

  String generateWidgetKey() {
    _widgetCounter++;
    return System.contextGenKeyPrefix +
        _widgetCounter.toString() +
        "_" +
        rootContext.appTargetKey;
  }

  String generateRandomKey() {
    _extraCounter++;
    return _extraCounter.toString() + "_" + rootContext.appTargetKey;
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
