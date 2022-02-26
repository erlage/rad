import 'package:trad/src/core/enums.dart';
import 'package:trad/src/core/classes/painter.dart';
import 'package:trad/src/core/structures/widget.dart';
import 'package:trad/src/core/structures/render_object.dart';
import 'package:trad/src/core/structures/build_context.dart';

class Container extends Widget {
  final String? key;

  final Widget child;
  final String? style;

  const Container({
    this.key,
    this.style,
    required this.child,
  });

  @override
  builder(context) {
    return ContainerRenderObject(
      child: child,
      style: style ?? '',
      buildableContext: context.mergeKey(key),
    );
  }
}

class ContainerRenderObject extends RenderObject<Container> {
  final Widget child;
  final String style;

  final BuildableContext buildableContext;

  ContainerRenderObject({
    required this.child,
    required this.style,
    required this.buildableContext,
  }) : super(
          domTag: DomTag.span,
          buildableContext: buildableContext,
        );

  @override
  render(widgetObject) {
    if (style.isNotEmpty) {
      widgetObject.htmlElement.className = style;
    }

    Painter(widgetObject).renderSingleWidget(child);
  }
}
