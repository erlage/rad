import 'dart:html';

import 'package:rad/src/core/classes/debug.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// [RenderObject] contains logic to build a widget's interface.
///
/// It also contains logic for handling updates and cascading them
/// to its childs.
///
abstract class RenderObject {
  final BuildContext context;

  const RenderObject(this.context);

  /*
  |--------------------------------------------------------------------------
  | rendering process related
  |--------------------------------------------------------------------------
  */

  void dispatchRender(HtmlElement element, WidgetConfiguration configuration) {
    if (Debug.widgetLogs) {
      print("Render: $context");
    }

    render(element, configuration);
  }

  void dispatchUpdate({
    required HtmlElement element,
    required UpdateType updateType,
    required WidgetConfiguration oldConfiguration,
    required WidgetConfiguration newConfiguration,
  }) {
    if (Debug.widgetLogs) {
      print("Update: $context");
    }

    update(
      element: element,
      updateType: updateType,
      oldConfiguration: oldConfiguration,
      newConfiguration: newConfiguration,
    );
  }

  /*
  |--------------------------------------------------------------------------
  | lifecycle hooks
  |--------------------------------------------------------------------------
  */

  /// Build widget interface
  ///
  void render(HtmlElement element, WidgetConfiguration configuration) {}

  /// Update widget interface
  ///
  void update({
    required HtmlElement element,
    required UpdateType updateType,
    required WidgetConfiguration oldConfiguration,
    required WidgetConfiguration newConfiguration,
  }) {}

  /// Before element mounts.
  ///
  void beforeMount() {}

  /// After element mounts.
  ///
  void afterMount() {}

  /// When widget configuration is changed.
  ///
  void afterWidgetRebind(UpdateType updateType, Widget oldWidget) {}

  /// Before element unmounts.
  ///
  void beforeUnMount() {}
}
