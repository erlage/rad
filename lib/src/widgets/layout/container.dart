import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/classes/framework.dart';
import 'package:rad/src/core/props/internal/size_props.dart';
import 'package:rad/src/core/props/internal/style_props.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/classes/abstract/widget.dart';
import 'package:rad/src/core/objects/render_object.dart';

/// A widget to contain a widget in itself.
///
/// This widget will be as big as possible.
///
/// Note that if both [margin] and [size] are set, then margin will not be
/// included in the box size. if [size] is not set, [margin] will always be
/// included in the box size doesn't matter whether [height] or [width] are
/// set or not.
///
class Container extends Widget {
  final String? key;

  final Widget child;

  // size props

  final String? size;
  final String? width;
  final String? height;
  final String? margin;
  final String? padding;

  final String? styles;

  const Container({
    this.key,
    this.styles,
    this.size,
    this.width,
    this.height,
    this.margin,
    this.padding,
    required this.child,
  });

  @override
  DomTag get tag => DomTag.div;

  @override
  String get type => (Container).toString();

  @override
  String get initialKey => key ?? System.keyNotSet;

  @override
  createRenderObject(context) {
    return ContainerRenderObject(
      child: child,
      context: context,
      styleProps: StyleProps(styles),
      sizeProps: SizeProps(
        size: size,
        width: width,
        height: height,
        margin: margin,
        padding: padding,
      ),
    );
  }
}

class ContainerRenderObject extends RenderObject {
  final Widget child;

  final SizeProps sizeProps;
  final StyleProps styleProps;

  ContainerRenderObject({
    required this.child,
    required this.sizeProps,
    required this.styleProps,
    required BuildContext context,
  }) : super(context);

  @override
  render(widgetObject) {
    sizeProps.apply(widgetObject.element);

    styleProps.apply(widgetObject.element);

    Framework.buildChildren(
      widgets: [child],
      parentContext: context,
    );
  }

  @override
  update(
    updateType,
    widgetObject,
    covariant ContainerRenderObject updatedRenderObject,
  ) {
    sizeProps.apply(widgetObject.element, updatedRenderObject.sizeProps);

    styleProps.apply(widgetObject.element, updatedRenderObject.styleProps);

    Framework.updateChildren(
      widgets: [updatedRenderObject.child],
      updateType: updateType,
      parentContext: context,
    );
  }
}
