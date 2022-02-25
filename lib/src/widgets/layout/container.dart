import '/src/core/enums.dart';
import '/src/core/classes/painter.dart';
import '/src/core/structures/widget.dart';
import '/src/core/structures/render_object.dart';
import '/src/core/structures/build_context.dart';
import '/src/core/structures/widget_object.dart';

class Container extends Widget {
  final String? key;
  final String? classes;

  final Widget child;

  Container({
    this.key,
    this.classes,
    required this.child,
  });

  @override
  RenderObject builder(BuildableContext context) {
    return ContainerRenderObject(
      child: child,
      classes: classes,
      buildableContext: context.mergeKey(key),
    );
  }
}

class ContainerRenderObject extends RenderObject<Container> {
  final Widget child;
  final String? classes;

  ContainerRenderObject({
    required this.child,
    required this.classes,
    required BuildableContext buildableContext,
  }) : super(
          buildableContext: buildableContext,
          domTag: DomTag.span,
        );

  @override
  render(WidgetObject widgetObject) {
    if (null != classes) {
      widgetObject.htmlElement.className = classes!;
    }

    Painter(widgetObject).renderSingleWidget(child);
  }
}
