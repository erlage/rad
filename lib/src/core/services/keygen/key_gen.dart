import 'dart:math';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/objects/app_options.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/services/abstract.dart';

/// Key generator service.
///
class KeyGen extends Service {
  final KeyGenOptions options;

  final _random = Random();

  // number of generated keys from generateGlobalKey()
  var _keyCounter = 0;

  // number of generated keys from generateRandomKey()
  var _extraCounter = 0;

  KeyGen(BuildContext context, this.options) : super(context);

  /// Generates a new global key for widget.
  ///
  GlobalKey generateGlobalKey() {
    _keyCounter++;

    return GlobalKey(
      "${Constants.contextGenKeyPrefix}${rootContext.appTargetId}_$_keyCounter",
    );
  }

  /// Get a global key for widget using key that's provided explicitly.
  ///
  GlobalKey getGlobalKeyUsingKey(Key key, BuildContext parentContext) {
    if (key is GlobalKey) {
      return key;
    }

    if (key is LocalKey) {
      return GlobalKey(
        "${parentContext.appTargetId}_${key.value}",
      );
    }

    return GlobalKey(
      "${parentContext.key.value}__${key.value}",
    );

    // Using different separator for local(_) and for non-local(__) keys ensure
    // that generated keys will be different even if value of appTargetId is
    // exactly same as value of parentContext.key.value(happens at root point)
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
