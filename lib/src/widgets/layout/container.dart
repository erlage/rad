import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/framework.dart';
import 'package:rad/src/core/props/internal/sizing_props.dart';
import 'package:rad/src/core/props/internal/styling_props.dart';
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
  final MeasuringUnit? sizingUnit;

  final String? styles;

  final Widget child;

  const Container({
    this.key,
    this.styles,
    this.width,
    this.height,
    this.sizingUnit,
    required this.child,
  });

  @override
  DomTag get tag => DomTag.div;

  @override
  String get type => (Container).toString();

  @override
  String get initialKey => key ?? Constants.keyNotSet;

  @override
  buildRenderObject(context) {
    return ContainerRenderObject(
      child: child,
      context: context,
      sizingProps: SizingProps(
        width: width,
        height: height,
        sizingUnit: sizingUnit ?? MeasuringUnit.pixel,
      ),
      stylingProps: StylingProps(styles),
    );
  }
}

class ContainerRenderObject extends RenderObject {
  final Widget child;

  final SizingProps sizingProps;
  final StylingProps stylingProps;

  ContainerRenderObject({
    required this.child,
    required this.sizingProps,
    required this.stylingProps,
    required BuildContext context,
  }) : super(context);

  @override
  render(widgetObject) {
    sizingProps.apply(widgetObject.element);

    stylingProps.apply(widgetObject.element);

    Framework.buildChildren(widgets: [child], parentContext: context);
  }

  @override
  update(widgetObject, updatedRenderObject) {
    updatedRenderObject as ContainerRenderObject;

    sizingProps.apply(widgetObject.element, updatedRenderObject.sizingProps);

    stylingProps.apply(widgetObject.element, updatedRenderObject.stylingProps);

    Framework.updateChildren(
      widgets: [updatedRenderObject.child],
      parentContext: context,
    );
  }
}
