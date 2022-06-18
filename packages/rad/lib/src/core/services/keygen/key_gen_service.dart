import 'dart:math';

import 'package:rad/src/core/common/objects/app_options.dart';
import 'package:rad/src/core/common/objects/common_render_elements.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/services/abstract.dart';

/// Key generator service.
///
class KeyGenService extends Service {
  final KeyGenOptions options;

  final _random = Random();

  /// Number of generated keys from generateRandomKey()
  ///
  var _extraCounter = -1;

  /// Compatibility hasher instances that are available for reuse.
  ///
  final _availableHashers = <_CompatibilityHashGenerator>[];

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

  /// Create compatibility hash generator.
  ///
  _CompatibilityHashGenerator createCompatibilityHashGenerator() {
    if (_availableHashers.isNotEmpty) {
      return _availableHashers.removeLast();
    }

    return _CompatibilityHashGenerator();
  }

  /// Dispose hasher instance so it can be reused.
  ///
  void disposeHashGenerator(_CompatibilityHashGenerator generator) {
    generator._revive();

    _availableHashers.add(generator);
  }
}

/// Widget's compatibility hash generator.
///
class _CompatibilityHashGenerator {
  final _counters = <String, int>{};

  /// Create unique hash for widget that can be used to find a matching widget
  /// at the same level of tree.
  ///
  String createCompatibilityHash({
    required Key? widgetKey,
    required String widgetRuntimeType,
  }) {
    if (null != widgetKey) {
      return '$widgetRuntimeType:k:${widgetKey.value}';
    }

    return '$widgetRuntimeType:nk:${_generateCountForType(widgetRuntimeType)}';
  }

  int _generateCountForType(String type) {
    var count = _counters[type];

    count ??= 0;

    _counters[type] = count + 1;

    return count;
  }

  /// Clear hasher state so that instance can be re-used.
  ///
  void _revive() {
    _counters.clear();
  }
}
