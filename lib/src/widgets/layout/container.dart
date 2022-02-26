import 'package:trad/src/core/enums.dart';
import 'package:trad/src/core/classes/painter.dart';
import 'package:trad/src/core/structures/widget.dart';
import 'package:trad/src/core/structures/render_object.dart';
import 'package:trad/src/core/structures/build_context.dart';
import 'package:trad/src/core/structures/widget_object.dart';

class Container extends Widget {
  final String? key;
  final String? style;

  final Widget child;

  const Container({
    this.key,
    this.style,
    required this.child,
  });

  @override
  RenderObject builder(BuildableContext context) {
    return ContainerRenderObject(
      child: child,
      style: style,
      buildableContext: context.mergeKey(key),
    );
  }
}

class ContainerRenderObject extends RenderObject<Container> {
  final Widget child;
  final String? style;

  ContainerRenderObject({
    required this.child,
    required this.style,
    required BuildableContext buildableContext,
  }) : super(
          buildableContext: buildableContext,
          domTag: DomTag.span,
        );

  @override
  render(WidgetObject widgetObject) {
    if (null != style) {
      widgetObject.htmlElement.className = style!; // (!) https://dart.dev/tools/non-promotion-reasons
    }

    Painter(widgetObject).renderSingleWidget(child);
  }
}
