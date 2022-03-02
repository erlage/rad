import 'dart:html';

import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/classes/framework.dart';
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
  String get initialKey => key ?? System.keyNotSet;

  @override
  createRenderObject(context) {
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
      elementCallback: (element) => updateStyleProps(
        element: element,
        previousAlignment: null,
        updatedAlignment: props.alignment,
      ),
    );
  }

  @override
  update(widgetObject, updatedRenderObject) {
    updatedRenderObject as AlignRenderObject;

    var previousAlignment = props.alignment;

    switchProps(updatedRenderObject.props);

    var updatedAlignment = props.alignment;

    Framework.updateChildren(
      widgets: [props.child],
      parentContext: context,
      elementCallback: (element) => updateStyleProps(
        element: element,
        previousAlignment: previousAlignment,
        updatedAlignment: updatedAlignment,
      ),
    );
  }

  void switchProps(AlignProps props) {
    this.props = props;
  }

  updateStyleProps({
    required Element element,
    required Alignment updatedAlignment,
    Alignment? previousAlignment,
  }) {
    if (null != previousAlignment) {
      element.classes.remove(getAlignmentStyle(previousAlignment));
    }

    element.classes.add(getAlignmentStyle(updatedAlignment));
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
