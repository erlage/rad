import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/framework.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/props/internal/position_props.dart';
import 'package:rad/src/core/props/internal/size_props.dart';
import 'package:rad/src/core/structures/build_context.dart';
import 'package:rad/src/core/structures/widget.dart';
import 'package:rad/src/core/objects/render_object.dart';

/// A widget that controls position of it's child. Can be used
/// anywhere but it's usually used inside a [Stack] or [OverlayEntry]
/// widget.
///
class Positioned extends Widget {
  final String? key;

  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final MeasuringUnit? positioningUnit;

  final double? width;
  final double? height;
  final MeasuringUnit? sizingUnit;

  final Widget child;

  const Positioned({
    this.key,
    this.top,
    this.bottom,
    this.left,
    this.right,
    this.width,
    this.height,
    this.sizingUnit,
    this.positioningUnit,
    required this.child,
  });

  /// Creates a Positioned object with [width] and [height] set
  /// to 100.
  Positioned.filled({
    this.key,
    this.top,
    this.bottom,
    this.left,
    this.right,
    this.positioningUnit,
    required this.child,
  })  : width = 100,
        height = 100,
        sizingUnit = MeasuringUnit.percent;

  @override
  DomTag get tag => DomTag.div;

  @override
  String get type => (Positioned).toString();

  @override
  String get initialKey => key ?? Constants.keyNotSet;

  @override
  buildRenderObject(context) {
    return PositionedRenderObject(
      child: child,
      context: context,
      sizeProps: SizeProps(
        width: width,
        height: height,
        sizingUnit: sizingUnit,
      ),
      posProps: PositionProps(
        top: top,
        bottom: bottom,
        left: left,
        right: right,
        positioningUnit: positioningUnit,
      ),
    );
  }
}

class PositionedRenderObject extends RenderObject {
  final Widget child;

  final SizeProps sizeProps;
  final PositionProps posProps;

  PositionedRenderObject({
    required this.child,
    required this.sizeProps,
    required this.posProps,
    required BuildContext context,
  }) : super(context);

  @override
  render(widgetObject) {
    sizeProps.apply(widgetObject.element);

    posProps.apply(widgetObject.element);

    Framework.buildChildren(
      widgets: [child],
      parentContext: context,
    );
  }

  @override
  void update(widgetObject, updatedRenderObject) {
    updatedRenderObject as PositionedRenderObject;

    sizeProps.apply(widgetObject.element, updatedRenderObject.sizeProps);

    posProps.apply(widgetObject.element, updatedRenderObject.posProps);

    Framework.updateChildren(
      widgets: [updatedRenderObject.child],
      parentContext: context,
    );
  }
}
