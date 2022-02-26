import 'package:trad/src/core/enums.dart';
import 'package:trad/src/core/classes/painter.dart';
import 'package:trad/src/core/structures/widget.dart';
import 'package:trad/src/core/structures/render_object.dart';
import 'package:trad/src/core/structures/build_context.dart';
import 'package:trad/src/core/structures/widget_object.dart';

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
  RenderObject builder(BuildableContext context) {
    return StackRenderObject(
      style: style,
      children: children,
      context: context.mergeKey(key),
    );
  }
}

class StackRenderObject extends RenderObject<Stack> {
  final String? style;
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
  render(WidgetObject widgetObject) {
    if (null != style) {
      widgetObject.htmlElement.className = style!; // (!) https://dart.dev/tools/non-promotion-reasons
    }

    Painter(widgetObject).renderMultipleWidgets(children);
  }
}
