import 'package:tard/src/core/enums.dart';
import 'package:tard/src/core/classes/painter.dart';
import 'package:tard/src/core/structures/widget.dart';
import 'package:tard/src/core/structures/render_object.dart';
import 'package:tard/src/core/structures/build_context.dart';
import 'package:tard/src/core/structures/widget_object.dart';

class Container extends Widget {
  final String? key;
  final String? classes;

  final Widget child;

  const Container({
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
