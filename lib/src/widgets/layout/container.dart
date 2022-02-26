import 'package:tard/src/core/enums.dart';
import 'package:tard/src/core/classes/painter.dart';
import 'package:tard/src/core/structures/widget.dart';
import 'package:tard/src/core/structures/render_object.dart';
import 'package:tard/src/core/structures/build_context.dart';
import 'package:tard/src/core/structures/widget_object.dart';

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
      widgetObject.htmlElement.className = style!;
    }

    Painter(widgetObject).renderSingleWidget(child);
  }
}
