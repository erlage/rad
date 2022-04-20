import 'dart:math';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/key.dart';

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

  /// Generates a global key for widget.
  ///
  GlobalKey generateGlobalKey() {
    _widgetCounter++;

    return GlobalKey(
      "$systemPrefix${rootContext.appTargetId}_$_widgetCounter",
    );
  }

  /// Get a global key for widget using key that's provided explicitly.
  ///
  /// If provided [key] is a non global key, then it'll use [parentContext] to
  /// generate a global key. Therefore non global keys must be unique under same
  /// parent.
  ///
  /// If provided [key] is a global key, then it'll return it as it as.
  ///
  GlobalKey getGlobalKeyUsingKey(Key key, BuildContext parentContext) {
    // a global key is provided, directly use it.

    if (key is GlobalKey) return key;

    // a local key is provided, generate global key from it.

    if (key is LocalKey) {
      return GlobalKey(
        "${parentContext.appTargetId}_${key.value}",
      );
    }

    // a non-local key is provided, generate global key from it.

    return GlobalKey(
      "${parentContext.key.value}_${key.value}",
    );
  }

  String generateRandomKey() {
    _extraCounter++;

    return "${_extraCounter}_${rootContext.appTargetId}";
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
