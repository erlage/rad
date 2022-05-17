import 'package:meta/meta.dart';

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/element_description.dart';

/// Widget's Render object.
///
@immutable
abstract class RenderObject {
  final BuildContext context;

  const RenderObject(this.context);

  /*
  |--------------------------------------------------------------------------
  | lifecycle hooks
  |--------------------------------------------------------------------------
  */

  /// Render hook.
  ///
  /// Implementation can optionally return description of element.
  ///
  ElementDescription? render({
    required WidgetConfiguration configuration,
  }) {
    return null;
  }

  void beforeMount() {}

  void afterMount() {}

  /// Update hook.
  ///
  /// Implementation can optionally return description of element.
  ///
  ElementDescription? update({
    required UpdateType updateType,
    required WidgetConfiguration oldConfiguration,
    required WidgetConfiguration newConfiguration,
  }) {
    return null;
  }

  void afterWidgetRebind({
    required Widget oldWidget,
    required Widget newWidget,
    required UpdateType updateType,
  }) {}

  void beforeUnMount() {}
}
