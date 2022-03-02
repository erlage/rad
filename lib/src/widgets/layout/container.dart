import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/classes/framework.dart';
import 'package:rad/src/core/props/internal/size_props.dart';
import 'package:rad/src/core/props/internal/style_props.dart';
import 'package:rad/src/core/structures/build_context.dart';
import 'package:rad/src/core/structures/widget.dart';
import 'package:rad/src/core/objects/render_object.dart';

/// A widget to contain a widget in itself.
///
/// This widget will be as big as possible if [width]
/// and/or [height] factors are not.
///
class Container extends Widget {
  final String? key;

  final double? width;
  final double? height;
  final MeasuringUnit? sizeUnit;

  final String? styles;

  final Widget child;

  const Container({
    this.key,
    this.styles,
    this.width,
    this.height,
    this.sizeUnit,
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
      sizeProps: SizeProps(
        width: width,
        height: height,
        sizeUnit: sizeUnit,
      ),
      styleProps: StyleProps(styles),
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
  update(widgetObject, updatedRenderObject) {
    updatedRenderObject as ContainerRenderObject;

    sizeProps.apply(widgetObject.element, updatedRenderObject.sizeProps);

    styleProps.apply(widgetObject.element, updatedRenderObject.styleProps);

    Framework.updateChildren(
      widgets: [updatedRenderObject.child],
      parentContext: context,
    );
  }
}
