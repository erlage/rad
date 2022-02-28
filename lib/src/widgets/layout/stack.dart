import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/structures/buildable_context.dart';
import 'package:rad/src/core/structures/widget.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/framework.dart';

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

  final String? style;
  final List<Widget> children;

  const Stack({
    this.key,
    this.style,
    required this.children,
  });

  @override
  builder(context) {
    return StackRenderObject(
      style: style ?? '',
      children: children,
      context: context.mergeKey(key),
    );
  }
}

class StackRenderObject extends RenderObject<Stack> {
  final String style;
  final List<Widget> children;

  StackRenderObject({
    required this.style,
    required this.children,
    required BuildableContext context,
  }) : super(
          domTag: DomTag.div,
          buildableContext: context,
        );

  @override
  render(widgetObject) {
    if (style.isNotEmpty) {
      widgetObject.htmlElement.className += " $style";
    }

    Framework.buildMultipleChildWidgets(
      context: context,
      widgets: children,
    );
  }
}
