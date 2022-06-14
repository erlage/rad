import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/render_element.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// Framework's action.
///
abstract class WidgetUpdateObject {
  final WidgetUpdateType widgetUpdateType;

  const WidgetUpdateObject(this.widgetUpdateType);
}

class WidgetUpdateObjectActionAdd extends WidgetUpdateObject {
  /// New widget.
  ///
  final List<Widget> widgets;

  /// Widget position in parent's child list.
  ///
  final int widgetPositionIndex;

  /// Mount index is the index at which this widget should be mounted.
  ///
  final int? mountAtIndex;

  /// Append a widget to the same update object.
  ///
  void appendAnotherWidget(Widget widget) => widgets.add(widget);

  WidgetUpdateObjectActionAdd({
    required this.widgets,
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
  final RenderElement existingRenderElement;

  /// New mount index.
  ///
  final int? newMountAtIndex;

  WidgetUpdateObjectActionUpdate({
    required this.widget,
    required this.widgetPositionIndex,
    required this.existingRenderElement,
    required this.newMountAtIndex,
  }) : super(WidgetUpdateType.update);
}

class WidgetUpdateObjectActionDispose extends WidgetUpdateObject {
  /// Existing widget node that should be disposed.
  ///
  final RenderElement existingElement;

  WidgetUpdateObjectActionDispose(
    this.existingElement,
  ) : super(WidgetUpdateType.dispose);
}

class WidgetUpdateObjectActionDisposeMultiple extends WidgetUpdateObject {
  /// Existing nodes to dispose
  ///
  final Iterable<RenderElement> elementsToDispose;

  WidgetUpdateObjectActionDisposeMultiple(
    this.elementsToDispose,
  ) : super(WidgetUpdateType.disposeMultiple);
}

class WidgetUpdateObjectActionCleanParent extends WidgetUpdateObject {
  static const _cached = WidgetUpdateObjectActionCleanParent._();

  factory WidgetUpdateObjectActionCleanParent() => _cached;

  const WidgetUpdateObjectActionCleanParent._()
      : super(
          WidgetUpdateType.cleanParent,
        );
}

enum ListenerType { one, two }

class ListenerOne {
  final type = ListenerType.one;
}

class ListenerTwo extends ListenerOne {
  @override
  ListenerType get type => ListenerType.one;
}
