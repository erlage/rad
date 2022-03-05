import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/classes/framework.dart';
import 'package:rad/src/core/props/internal/flex_props.dart';
import 'package:rad/src/core/props/internal/style_props.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/classes/abstract/widget.dart';
import 'package:rad/src/core/objects/render_object.dart';

class Flex extends Widget {
  final String? key;

  final Axis axis;

  final double? gap;

  final FlexWrap? flexWrap;

  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  final String? styles;

  final List<Widget> children;

  const Flex({
    this.key,
    this.gap,
    this.styles,
    this.flexWrap,
    required this.axis,
    required this.mainAxisAlignment,
    required this.crossAxisAlignment,
    required this.children,
  });

  @override
  DomTag get tag => DomTag.div;

  @override
  String get type => (Flex).toString();

  @override
  String get initialKey => key ?? System.keyNotSet;

  @override
  createRenderObject(context) {
    return FlexRenderObject(
      context: context,
      children: children,
      styleProps: StyleProps(styles),
      flexProps: FlexProps(
        gap: gap,
        axis: axis,
        flexWrap: flexWrap ?? FlexWrap.nowrap,
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
      ),
    );
  }
}

class FlexRenderObject extends RenderObject {
  final FlexProps flexProps;

  final StyleProps styleProps;

  final List<Widget> children;

  FlexRenderObject({
    required this.children,
    required this.flexProps,
    required this.styleProps,
    required BuildContext context,
  }) : super(context);

  @override
  render(widgetObject) {
    styleProps.apply(widgetObject.element);

    flexProps.apply(widgetObject.element);

    Framework.buildChildren(
      widgets: children,
      parentContext: context,
    );
  }

  @override
  update(widgetObject, covariant FlexRenderObject updatedRenderObject) {
    styleProps.apply(widgetObject.element, updatedRenderObject.styleProps);

    flexProps.apply(widgetObject.element, updatedRenderObject.flexProps);

    Framework.updateChildren(
      widgets: updatedRenderObject.children,
      parentContext: context,
    );
  }
}
