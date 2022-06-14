import 'package:meta/meta.dart';

import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/objects/render_element.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// Base class for widgets that has exactly one child widget.
///
abstract class SingleChildWidget extends Widget {
  /// Child widget.
  ///
  final Widget child;

  const SingleChildWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  createRenderElement(parent) => SingleChildRenderElement(this, parent);
}

/// Single child render element.
///
class SingleChildRenderElement extends RenderElement {
  SingleChildRenderElement(
    SingleChildWidget widget,
    RenderElement parent,
  )   : _childWidgets = [widget.child],
        super(widget, parent);

  @override
  List<Widget> get childWidgets => _childWidgets;
  List<Widget> _childWidgets;

  @mustCallSuper
  @override
  void afterWidgetRebind({
    required oldWidget,
    required covariant SingleChildWidget newWidget,
    required updateType,
  }) {
    _childWidgets = [newWidget.child];
  }
}
