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
  /// Note that at this point, element might not be present in the actual DOM.
  /// For getting access to widget's element use [afterMount] hook.
  ///
  ElementDescription? render({
    required WidgetConfiguration configuration,
  }) {
    return null;
  }

  /// After mount hook.
  ///
  /// This hook gets called after widget's element is mounted and is available
  /// in actual DOM.
  ///
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

  /// After widget's rebind hook.
  ///
  void afterWidgetRebind({
    required Widget oldWidget,
    required Widget newWidget,
    required UpdateType updateType,
  }) {}

  /// Before UnMount hook.
  ///
  void beforeUnMount() {}
}
