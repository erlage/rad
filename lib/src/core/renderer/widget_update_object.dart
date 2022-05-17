import 'package:rad/src/core/renderer/render_node.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// A simple object used to wrap Widget update entries
/// before dispatching them.
///
class WidgetUpdateObject {
  /// New instance of widget.
  ///
  final Widget widget;

  /// Existing render node to update.
  ///
  final RenderNode? node;

  WidgetUpdateObject(this.widget, this.node);
}
