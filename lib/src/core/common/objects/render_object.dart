import 'package:meta/meta.dart';

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/element_description.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// Widget's Render object.
///
@immutable
class RenderObject {
  final BuildContext context;

  const RenderObject(this.context);

  /*
  |--------------------------------------------------------------------------
  | lifecycle hooks
  |--------------------------------------------------------------------------
  */

  /// Render hook.
  ///
  /// Implementation can optionally return description of element that will be
  /// applied on element associated with current widget. If current widget has
  /// no [Widget.correspondingTag] then description will returned by this
  /// method will be thrown away.
  ///
  /// This hook gets called exactly once during lifetime of a widget.
  ///
  ElementDescription? render({
    required WidgetConfiguration configuration,
  }) {
    return null;
  }

  /// After mount hook.
  ///
  /// Framework calls this hook when after mounting current widget in both
  /// trees(render-tree and dom-tree).
  ///
  /// This hook gets called exactly once during lifetime of a widget.
  ///
  void afterMount() {}

  /// Update hook.
  ///
  /// Implementation can optionally return description of element that will be
  /// applied on element associated with current widget. If current widget has
  /// no [Widget.correspondingTag] then description will returned by this
  /// method will be thrown away.
  ///
  /// This hook gets called everytime [Widget.isConfigurationChanged] returns
  /// true.
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
  /// This hook gets called everytime a state change happens in the parent
  /// context of current widget.
  ///
  void afterWidgetRebind({
    required Widget oldWidget,
    required Widget newWidget,
    required UpdateType updateType,
  }) {}

  /// Before unMount hook.
  ///
  /// Framework calls this hook when its about to remove widget from both trees
  /// (render-tree and dom-tree).
  ///
  /// This hook gets called exactly once during lifetime of a widget.
  ///
  void beforeUnMount() {}
}
