import 'package:rad/src/core/framework.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/structures/buildable_context.dart';
import 'package:rad/src/core/structures/widget.dart';
import 'package:rad/src/core/objects/render_object.dart';

/// A widget that aligns its child within itself.
///
/// This widget will be as big as possible.
///
/// See also:
///
///  * [Alignment], widget's alignment
///
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
    var stylesToInjectIntoChilds = <String>[];

    switch (alignment) {
      case Alignment.topRight:
        stylesToInjectIntoChilds.add("rad-align-top-right");
        break;

      case Alignment.bottomRight:
        stylesToInjectIntoChilds.add("rad-align-bottom-right");
        break;

      case Alignment.bottomLeft:
        stylesToInjectIntoChilds.add("rad-align-bottom-left");
        break;

      case Alignment.topLeft:
        stylesToInjectIntoChilds.add("rad-align-top-left");
        break;

      // dart tooling supports exhaustive checking... that's cool!
    }

    Framework.buildWidget(
      widget: child,
      parentContext: context,
      styles: stylesToInjectIntoChilds,
    );
  }
}
