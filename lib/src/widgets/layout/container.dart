import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/classes/framework.dart';
import 'package:rad/src/core/props/internal/size_props.dart';
import 'package:rad/src/core/props/internal/style_props.dart';
import 'package:rad/src/core/props/margin.dart';
import 'package:rad/src/core/props/padding.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/classes/abstract/widget.dart';
import 'package:rad/src/core/objects/render_object.dart';

/// A widget to contain a widget in itself.
///
/// This widget will be as big as possible if [width]
/// and/or [height] factors are not.
///
class Container extends Widget {
  final String? key;

  final Widget child;

  final double? width;
  final double? height;
  final MeasuringUnit? sizeUnit;

  final String? styles;

  final Margin? margin;
  final Padding? padding;

  const Container({
    this.key,
    this.styles,
    this.width,
    this.height,
    this.sizeUnit,
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
    var margin = this.margin;

    if (null != margin) {
      margin.flagContainInBoxSize = true;
    }

    return ContainerRenderObject(
      child: child,
      context: context,
      margin: margin,
      padding: padding,
      styleProps: StyleProps(styles),
      sizeProps: SizeProps(
        width: width,
        height: height,
        sizeUnit: sizeUnit,
      ),
    );
  }
}

class ContainerRenderObject extends RenderObject {
  final Widget child;

  final SizeProps sizeProps;
  final StyleProps styleProps;

  final Margin? margin;
  final Padding? padding;

  ContainerRenderObject({
    required this.child,
    required this.margin,
    required this.padding,
    required this.sizeProps,
    required this.styleProps,
    required BuildContext context,
  }) : super(context);

  @override
  render(widgetObject) {
    sizeProps.apply(widgetObject.element);

    styleProps.apply(widgetObject.element);

    var padding = this.padding;
    if (null != padding) {
      padding.apply(widgetObject.element);
    }

    var margin = this.margin;
    if (null != margin) {
      margin.size = sizeProps;

      margin.apply(widgetObject.element);
    }

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

    var padding = this.padding;
    if (null != padding) {
      padding.apply(widgetObject.element, updatedRenderObject.padding);
    }

    var margin = this.margin;
    if (null != margin) {
      margin.size = updatedRenderObject.sizeProps;

      margin.apply(widgetObject.element, updatedRenderObject.margin);
    }

    Framework.updateChildren(
      widgets: [updatedRenderObject.child],
      parentContext: context,
    );
  }
}
