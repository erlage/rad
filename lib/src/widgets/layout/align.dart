import 'package:rad/src/core/framework.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/structures/build_context.dart';
import 'package:rad/src/core/structures/widget.dart';

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

  @override
  String get type => (Align).toString();

  @override
  DomTag get tag => DomTag.div;

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
      context: context.mergeKey(key),
    );
  }
}

class AlignRenderObject extends RenderObject {
  final Widget child;
  final Alignment alignment;

  AlignRenderObject({
    required this.child,
    required this.alignment,
    required BuildContext context,
  }) : super(context);

  @override
  build(widgetObject) {
    Framework.buildWidget(
      widget: child,
      parentContext: context,
      styles: [
        getAlignmentStyle(this),
      ],
    );
  }

  @override
  update(widgetObject, updatedRenderObject) {
    updatedRenderObject as AlignRenderObject;

    Framework.updateWidget(
      widget: child,
      parentContext: context,
      styles: [
        getAlignmentStyle(updatedRenderObject),
      ],
    );
  }

  getAlignmentStyle(AlignRenderObject renderObject) {
    switch (renderObject.alignment) {
      case Alignment.topRight:
        return "rad-align-top-right";

      case Alignment.bottomRight:
        return "rad-align-bottom-right";

      case Alignment.bottomLeft:
        return "rad-align-bottom-left";

      case Alignment.topLeft:
        return "rad-align-top-left";

      // dart tooling supports exhaustive checking... that's cool!
    }
  }
}
