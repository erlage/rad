import 'package:trad/src/core/framework.dart';
import 'package:trad/src/core/enums.dart';
import 'package:trad/src/core/structures/buildable_context.dart';
import 'package:trad/src/core/structures/widget.dart';
import 'package:trad/src/core/objects/render_object.dart';

class Align extends Widget {
  final String? key;

  final Widget child;
  final Alignment alignment;

  const Align({
    this.key,
    required this.child,
    required this.alignment,
  });

  @override
  builder(context) {
    return AlignRenderObject(
      child: child,
      alignment: alignment,
      buildableContext: context.mergeKey(key),
    );
  }
}

class AlignRenderObject extends RenderObject<Align> {
  final Widget child;
  final Alignment alignment;

  final BuildableContext buildableContext;

  AlignRenderObject({
    required this.child,
    required this.alignment,
    required this.buildableContext,
  }) : super(
          domTag: DomTag.div,
          buildableContext: buildableContext,
        );

  @override
  render(widgetObject) {
    switch (alignment) {
      case Alignment.topRight:
        widgetObject.htmlElement.classes.add("trad-align-top-right");
        break;

      case Alignment.bottomRight:
        widgetObject.htmlElement.classes.add("trad-align-bottom-right");
        break;

      case Alignment.bottomLeft:
        widgetObject.htmlElement.classes.add("trad-align-bottom-left");
        break;

      case Alignment.topLeft:
        widgetObject.htmlElement.classes.add("trad-align-top-left");
        break;

      // dart tooling supports exhaustive checking... that's cool!
    }

    Framework.renderSingleChildWidget(
      context: context,
      widget: child,
    );
  }
}
