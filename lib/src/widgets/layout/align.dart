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

  const Align({
    this.key,
    required this.child,
    required this.alignment,
  });

  @override
  String get type => (Align).toString();

  @override
  DomTag get tag => DomTag.div;

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

  @override
  update(widgetObject, updatedRenderObject) {
    updatedRenderObject as AlignRenderObject;

    // TODO implement

    Framework.updateWidget(
      widget: child,
      parentContext: context,
    );
  }
}
