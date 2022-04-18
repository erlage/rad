import 'dart:html';

import 'package:meta/meta.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// Widget's Render object contains logic to build and update interface.
///
/// These objects also contains logic for handling updates.
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
