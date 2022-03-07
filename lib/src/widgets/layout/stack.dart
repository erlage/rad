import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/props/internal/style_props.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/classes/abstract/widget.dart';
import 'package:rad/src/widgets/abstract/multi_child_render_object.dart';

/// A widget that positions its children relative to the edges of its box.
///
/// This class is useful if you want to overlap several children in a simple
/// way, for example having some text and an image, overlaid with a gradient and
/// a button attached to the bottom.
///
/// Each child of a [Stack] widget is either _positioned_ or _non-positioned_.
/// Positioned children are those wrapped in a [Positioned] widget.
///
/// The stack paints its children in order with the first child being at the
/// bottom. If you want to change the order in which the children paint, you
/// can rebuild the stack with the children in the new order.
///
/// If you want to add/remove Stack childrens after initialization consider
/// user a [Overlay] widget.
///
/// See also:
///
///  * [Overlay], A stack of entries that can be managed independently.
///
class Stack extends Widget {
  final String? key;

  final String? styles;
  final List<Widget> children;

  const Stack({
    this.key,
    this.styles,
    required this.children,
  });

  @override
  DomTag get tag => DomTag.div;

  @override
  String get type => (Stack).toString();

  @override
  String get initialKey => key ?? System.keyNotSet;

  @override
  createRenderObject(context) {
    return StackRenderObject(
      context: context,
      children: children,
      styleProps: StyleProps(styles),
    );
  }
}

class StackRenderObject extends MultiChildRenderObject {
  final StyleProps styleProps;

  StackRenderObject({
    required List<Widget> children,
    required this.styleProps,
    required BuildContext context,
  }) : super(children, context);

  @override
  beforeRender(widgetObject) {
    styleProps.apply(widgetObject.element);
  }

  @override
  beforeUpdate(
    widgetObject,
    covariant StackRenderObject updatedRenderObject,
  ) {
    styleProps.apply(widgetObject.element, updatedRenderObject.styleProps);
  }
}
