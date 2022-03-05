import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/classes/framework.dart';
import 'package:rad/src/core/props/internal/flex_item_props.dart';
import 'package:rad/src/core/props/internal/style_props.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/classes/abstract/widget.dart';
import 'package:rad/src/core/objects/render_object.dart';

class Flexible extends Widget {
  final String? key;

  final int flex;

  final Widget child;

  final String? styles;

  const Flexible({
    this.key,
    this.styles,
    required this.flex,
    required this.child,
  });

  @override
  DomTag get tag => DomTag.div;

  @override
  String get type => (Flexible).toString();

  @override
  String get initialKey => key ?? System.keyNotSet;

  @override
  createRenderObject(context) {
    return FlexibleRenderObject(
      child: child,
      context: context,
      styleProps: StyleProps(styles),
      flexItemProps: FlexItemProps(flex: flex),
    );
  }
}

class FlexibleRenderObject extends RenderObject {
  final Widget child;

  final StyleProps styleProps;

  final FlexItemProps flexItemProps;

  FlexibleRenderObject({
    required this.child,
    required this.styleProps,
    required this.flexItemProps,
    required BuildContext context,
  }) : super(context);

  @override
  render(widgetObject) {
    styleProps.apply(widgetObject.element);

    flexItemProps.apply(widgetObject.element);

    Framework.buildChildren(
      widgets: [child],
      parentContext: context,
    );
  }

  @override
  update(widgetObject, covariant FlexibleRenderObject updatedRenderObject) {
    styleProps.apply(widgetObject.element, updatedRenderObject.styleProps);

    flexItemProps.apply(
      widgetObject.element,
      updatedRenderObject.flexItemProps,
    );

    Framework.updateChildren(
      widgets: [updatedRenderObject.child],
      parentContext: context,
    );
  }
}
