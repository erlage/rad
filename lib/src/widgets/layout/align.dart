import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/classes/framework.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/props/alignment.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/classes/abstract/widget.dart';

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
  DomTag get tag => DomTag.div;

  @override
  String get type => "$Align";

  @override
  String get initialKey => key ?? System.keyNotSet;

  @override
  createRenderObject(context) {
    return AlignRenderObject(
      child: child,
      context: context,
      alignment: alignment,
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
    Framework.buildChildren(
      widgets: [child],
      parentContext: context,
      elementCallback: (element) => alignment.apply(element),
    );
  }

  @override
  update(
    updateType,
    widgetObject,
    covariant AlignRenderObject updatedRenderObject,
  ) {
    Framework.updateChildren(
      widgets: [updatedRenderObject.child],
      updateType: updateType,
      parentContext: context,
      elementCallback: (element) => alignment.apply(
        element,
        updatedRenderObject.alignment,
      ),
    );
  }
}
