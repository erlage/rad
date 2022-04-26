import 'dart:html';

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

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

  /// Render widget interface
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

  void beforeMount() {}

  void afterMount() {}

  void afterWidgetRebind({
    required Widget oldWidget,
    required Widget newWidget,
    required UpdateType updateType,
  }) {}

  void beforeUnMount() {}
}
