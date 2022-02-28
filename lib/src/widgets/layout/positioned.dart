import 'package:rad/src/core/framework.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/structures/build_context.dart';
import 'package:rad/src/core/structures/widget.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/utils.dart';

/// A widget that controls position of it's child. Can be used
/// anywhere but it's usually used inside a [Stack] or [OverlayEntry]
/// widget.
///
class Positioned extends Widget {
  final String? key;

  final int? top;
  final int? bottom;
  final int? left;
  final int? right;
  final MeasuringUnit? positioningUnit;

  final int? width;
  final int? height;
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
  String get type => (Positioned).toString();

  @override
  DomTag get tag => DomTag.div;

  @override
  builder(context) {
    return PositionedRenderObject(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      width: width,
      height: height,
      sizingUnit: sizingUnit ?? MeasuringUnit.pixel,
      positioningUnit: positioningUnit ?? MeasuringUnit.pixel,
      child: child,
      context: context.mergeKey(key),
    );
  }
}

class PositionedRenderObject extends RenderObject {
  final Widget child;

  final int? top;
  final int? bottom;
  final int? left;
  final int? right;
  final MeasuringUnit positioningUnit;

  final int? width;
  final int? height;
  final MeasuringUnit sizingUnit;

  PositionedRenderObject({
    this.top,
    this.bottom,
    this.left,
    this.right,
    this.width,
    this.height,
    required this.positioningUnit,
    required this.sizingUnit,
    required this.child,
    required BuildContext context,
  }) : super(context);

  @override
  build(widgetObject) {
    var sizingUnit = Utils.mapMeasuringUnit(this.sizingUnit);
    var positioningUnit = Utils.mapMeasuringUnit(this.positioningUnit);

    if (null != top) {
      widgetObject.htmlElement.style.top = top.toString() + positioningUnit;
    }
    if (null != bottom) {
      widgetObject.htmlElement.style.bottom =
          bottom.toString() + positioningUnit;
    }
    if (null != left) {
      widgetObject.htmlElement.style.left = left.toString() + positioningUnit;
    }
    if (null != right) {
      widgetObject.htmlElement.style.right = right.toString() + positioningUnit;
    }

    if (null != width) {
      widgetObject.htmlElement.style.width = width.toString() + sizingUnit;
    }
    if (null != height) {
      widgetObject.htmlElement.style.height = height.toString() + sizingUnit;
    }

    Framework.buildWidget(
      widget: child,
      parentContext: context,
    );
  }

  @override
  void update(widgetObject, updatedRenderObject) {
    updatedRenderObject as PositionedRenderObject;

    // TODO

    Framework.updateWidget(
      widget: child,
      parentContext: context,
    );
  }
}
