import 'dart:html';

import 'package:rad/src/core/constants.dart';
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

  final Alignment alignment;

  final Widget child;

  const Align({
    this.key,
    required this.child,
    required this.alignment,
  });

  @override
  DomTag get tag => DomTag.div;

  @override
  String get type => (Align).toString();

  @override
  String get initialKey => key ?? Constants.keyNotSet;

  @override
  buildRenderObject(context) {
    return AlignRenderObject(
      context: context,
      props: AlignProps(
        child: child,
        alignment: alignment,
      ),
    );
  }
}

class AlignProps {
  final Widget child;
  final Alignment alignment;

  AlignProps({
    required this.child,
    required this.alignment,
  });
}

class AlignRenderObject extends RenderObject {
  AlignProps props;

  AlignRenderObject({
    required this.props,
    required BuildContext context,
  }) : super(context);

  @override
  render(widgetObject) {
    Framework.buildChildren(
      widgets: [props.child],
      parentContext: context,
      elementCallback: (element) => updateStyleProps(this, element),
    );
  }

  @override
  update(widgetObject, updatedRenderObject) {
    updatedRenderObject as AlignRenderObject;

    switchProps(updatedRenderObject.props);

    Framework.updateChildren(
      widgets: [props.child],
      parentContext: context,
      elementCallback: (element) => updateStyleProps(
        updatedRenderObject,
        element,
      ),
    );
  }

  void switchProps(AlignProps props) {
    this.props = props;
  }

  updateStyleProps(AlignRenderObject renderObject, Element element) {
    // remove previous
    element.classes.remove(getAlignmentStyle(props.alignment));

    // add current
    element.classes.add(getAlignmentStyle(renderObject.props.alignment));
  }

  getAlignmentStyle(Alignment alignment) {
    switch (alignment) {
      case Alignment.topRight:
        return "rad-align-top-right";

      case Alignment.bottomRight:
        return "rad-align-bottom-right";

      case Alignment.bottomLeft:
        return "rad-align-bottom-left";

      case Alignment.topLeft:
        return "rad-align-top-left";
    }
  }
}
