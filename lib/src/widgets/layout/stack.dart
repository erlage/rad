import 'dart:html';

import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/framework.dart';
import 'package:rad/src/core/structures/build_context.dart';
import 'package:rad/src/core/structures/widget.dart';

/// A widget that positions its children relative to the edges of its box.
///
/// This class is useful if you want to overlap several children in a simple
/// way, for example having some text and an image, overlaid with a gradient and
/// a button attached to the bottom.
///
/// Each child of a [Stack] widget is either _positioned_ or _non-positioned_.
/// Positioned children are those wrapped in a [Positioned] widget.
///
/// The stack paints its children in order with the first child being at the
/// bottom. If you want to change the order in which the children paint, you
/// can rebuild the stack with the children in the new order.
///
/// If you want to add/remove Stack childrens after initialization consider
/// user a [Overlay] widget.
///
/// See also:
///
///  * [Overlay], A stack of entries that can be managed independently.
///
class Stack extends Widget {
  final String? key;

  final String? styles;
  final List<Widget> children;

  const Stack({
    this.key,
    this.styles,
    required this.children,
  });

  @override
  DomTag get tag => DomTag.div;

  @override
  String get type => (Stack).toString();

  @override
  String get initialKey => key ?? Constants.keyNotSet;

  @override
  buildRenderObject(context) {
    return StackRenderObject(
      context: context,
      props: StackProps(
        children: children,
        styles: null != styles ? styles!.split(" ") : [],
      ),
    );
  }
}

class StackProps {
  final List<String> styles;
  final List<Widget> children;

  StackProps({
    required this.styles,
    required this.children,
  });
}

class StackRenderObject extends RenderObject {
  StackProps props;

  StackRenderObject({
    required this.props,
    required BuildContext context,
  }) : super(context);

  @override
  render(widgetObject) {
    applyProps(widgetObject.htmlElement);

    Framework.buildChildren(
      widgets: props.children,
      parentContext: context,
    );
  }

  @override
  update(widgetObject, updatedRenderObject) {
    updatedRenderObject as StackRenderObject;

    clearProps(widgetObject.htmlElement);

    switchProps(updatedRenderObject.props);

    applyProps(widgetObject.htmlElement);

    Framework.updateChildren(
      widgets: props.children,
      parentContext: context,
    );
  }

  void switchProps(StackProps props) {
    this.props = props;
  }

  void applyProps(HtmlElement htmlElement) {
    if (props.styles.isNotEmpty) {
      htmlElement.classes.addAll(props.styles);
    }
  }

  void clearProps(HtmlElement htmlElement) {
    if (props.styles.isNotEmpty) {
      htmlElement.classes.removeAll(props.styles);
    }
  }
}
