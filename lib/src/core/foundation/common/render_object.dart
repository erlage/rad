import 'dart:html';

import 'package:meta/meta.dart';
import 'package:rad/src/core/utilities/services_registry.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/foundation/common/build_context.dart';
import 'package:rad/src/core/foundation/scheduler/scheduler.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// [RenderObject] contains logic to build a widget's interface.
///
/// These objects also contains logic for handling updates.
///
@immutable
abstract class RenderObject {
  final BuildContext context;

  const RenderObject(this.context);

  /// Get task scheduler for app instance that's enclosing the current context.
  ///
  Scheduler get scheduler => ServicesRegistry.instance.getScheduler(context);

  /*
  |--------------------------------------------------------------------------
  | rendering process related
  |--------------------------------------------------------------------------
  */

  void dispatchRender(HtmlElement element, WidgetConfiguration configuration) {
    render(element, configuration);
  }

  void dispatchUpdate({
    required HtmlElement element,
    required UpdateType updateType,
    required WidgetConfiguration oldConfiguration,
    required WidgetConfiguration newConfiguration,
  }) {
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
