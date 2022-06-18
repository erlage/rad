import 'dart:math';

import 'package:rad/src/core/common/objects/app_options.dart';
import 'package:rad/src/core/common/objects/common_render_elements.dart';
import 'package:rad/src/core/services/abstract.dart';

/// Key generator service.
///
class KeyGenService extends Service {
  final KeyGenOptions options;

  final _random = Random();

  /// Number of generated keys from generateRandomKey()
  ///
  var _extraCounter = -1;

  KeyGenService(RootElement rootElement, this.options) : super(rootElement);

  /// Generates a new string key.
  ///
  String generateStringKey() {
    ++_extraCounter;

    return '${_extraCounter}_${rootElement.appTargetId}';
  }

  /// Generate random string of requested length.
  ///
  String random([int length = 6]) {
    var cSet = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => cSet.codeUnitAt(
          _random.nextInt(
            cSet.length,
          ),
        ),
      ),
    );
  }
}
