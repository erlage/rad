import 'package:rad/src/core/renderer/render_node.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// Framework's action.
///
abstract class WidgetUpdateObject {
  final WidgetUpdateType widgetUpdateType;

  WidgetUpdateObject(this.widgetUpdateType);
}

enum WidgetUpdateType {
  add,
  update,
  dispose,

  /// Add new widgets without cleaning parent contents.
  ///
  addAllWithoutClean,
}

class WidgetUpdateObjectActionAdd extends WidgetUpdateObject {
  /// New widget.
  ///
  final Widget widget;

  /// Widget position in parent's child list.
  ///
  final int widgetPositionIndex;

  /// Mount index is the index at which this widget should be mounted.
  ///
  final int? mountAtIndex;

  WidgetUpdateObjectActionAdd({
    required this.widget,
    required this.mountAtIndex,
    required this.widgetPositionIndex,
  }) : super(WidgetUpdateType.add);
}

class WidgetUpdateObjectActionAddAllWithoutClean extends WidgetUpdateObject {
  /// New widgets.
  ///
  final List<Widget> widgets;

  WidgetUpdateObjectActionAddAllWithoutClean({
    required this.widgets,
  }) : super(WidgetUpdateType.addAllWithoutClean);
}

class WidgetUpdateObjectActionUpdate extends WidgetUpdateObject {
  /// New widget.
  ///
  final Widget widget;

  /// Widget position in parent's child list.
  ///
  final int widgetPositionIndex;

  /// Existing widget node that should be updated.
  ///
  final RenderNode existingRenderNode;

  /// New mount index.
  ///
  final int? newMountAtIndex;

  WidgetUpdateObjectActionUpdate({
    required this.widget,
    required this.widgetPositionIndex,
    required this.existingRenderNode,
    required this.newMountAtIndex,
  }) : super(WidgetUpdateType.update);
}

class WidgetUpdateObjectActionDispose extends WidgetUpdateObject {
  /// Existing widget node that should be disposed.
  ///
  final RenderNode existingRenderNode;

  WidgetUpdateObjectActionDispose(
    this.existingRenderNode,
  ) : super(WidgetUpdateType.dispose);
}
