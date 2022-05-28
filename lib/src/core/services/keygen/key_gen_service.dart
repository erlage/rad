import 'dart:math';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/objects/app_options.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/services/abstract.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// Key generator service.
///
class KeyGenService extends Service {
  final KeyGenOptions options;

  final _random = Random();

  /// Number of generated keys from generateGlobalKey()
  ///
  var _keyCounter = -1;

  /// Number of generated keys from generateRandomKey()
  ///
  var _extraCounter = -1;

  /// Compatibility hasher instances that are available for reuse.
  ///
  final _availableHashers = <_CompatibilityHashGenerator>[];

  KeyGenService(BuildContext context, this.options) : super(context);

  /// Generates a new string key.
  ///
  String generateStringKey() {
    ++_extraCounter;

    return '${_extraCounter}_${rootContext.appTargetId}';
  }

  /// Generates a new global key.
  ///
  GlobalKey generateGlobalKey() {
    ++_keyCounter;

    return GlobalKey.generateForFramework(
      '_${rootContext.appTargetId}_$_keyCounter',
    );
  }

  /// Get a global key for widget using key that's provided explicitly.
  ///
  GlobalKey getGlobalKeyUsingKey(Key key, BuildContext parentContext) {
    if (key is GlobalKey) {
      return key;
    }

    if (key is LocalKey) {
      return GlobalKey('${parentContext.appTargetId}_${key.value}');
    }

    return GlobalKey('${parentContext.key.value}__${key.value}');

    // Using different separator for local(_) and for non-local(__) keys ensure
    // that generated keys will be different even if value of appTargetId is
    // exactly same as value of parentContext.key.value(happens at root point)
  }

  /// Create [GlobalKey] for widget.
  ///
  GlobalKey computeWidgetKey({
    required Widget widget,
    required BuildContext parentContext,
  }) {
    // whether key is provided explicitly in widget constructor

    var isKeyProvided = Constants.contextKeyNotSet != widget.initialKey;

    if (isKeyProvided) {
      return getGlobalKeyUsingKey(widget.initialKey, parentContext);
    }

    return generateGlobalKey();
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
    required GlobalKey widgetKey,
    required String widgetRuntimeType,
  }) {
    if (widgetKey.isFrameworkGenerated) {
      return '$widgetRuntimeType:${_generateCountForType(widgetRuntimeType)}';
    }

    return '$widgetRuntimeType:${widgetKey.value}';
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
