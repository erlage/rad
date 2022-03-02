import 'package:rad/src/core/structures/build_context.dart';
import 'package:rad/src/core/objects/widget_object.dart';

/// [RenderObject] contains logic to build a widget's interface.
///
/// It also contains logic for handling updates and cascading them
/// to its childs.
///
abstract class RenderObject {
  final BuildContext context;

  RenderObject(this.context);

  // lifecycle hooks

  void beforeMount() {}

  void afterMount() {}

  void beforeUnMount() {}

  /// Build interface
  ///
  /// The framework will call this method when it wants a widget
  /// to build itself.
  ///
  /// Implementation of this method is responsible for building
  /// its child widgets(if there are any).
  ///
  void render(WidgetObject widgetObject);

  /// Update widget interface & state
  ///
  /// This method get's called with updated [RenderObject] for current widget.
  ///
  /// [updatedRenderObject] contains fresh interface description of current
  /// widget. This can be used to update widget's internal state.
  ///
  /// Note: Widget must cascade update to its childs after updating
  /// its own state. Even if there's nothing to update in current widget's state,
  /// cascading update ensure that all required widget will update themselves
  /// if their interface description has changed.
  ///
  /// StatefulWidget should ignore this method because it has its own state
  /// and [updatedRenderObject] doesn't know anything about it. Using this object
  /// will results in loss of internal state in StatefulWidget
  ///
  void update(WidgetObject widgetObject, RenderObject updatedRenderObject) {}
}
