import 'package:trad/src/core/framework.dart';
import 'package:trad/src/core/enums.dart';
import 'package:trad/src/core/structures/widget.dart';
import 'package:trad/src/core/objects/render_object.dart';
import 'package:trad/src/core/structures/buildable_context.dart';
import 'package:trad/src/core/utils.dart';

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
      buildableContext: context.mergeKey(key),
    );
  }
}

class PositionedRenderObject extends RenderObject<Positioned> {
  final Widget child;

  final int? top;
  final int? bottom;
  final int? left;
  final int? right;
  final MeasuringUnit positioningUnit;

  final int? width;
  final int? height;
  final MeasuringUnit sizingUnit;

  final BuildableContext buildableContext;

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
    required this.buildableContext,
  }) : super(
          domTag: DomTag.span,
          buildableContext: buildableContext,
        );

  @override
  render(widgetObject) {
    var sizingUnit = Utils.mapMeasuringUnit(this.sizingUnit);
    var positioningUnit = Utils.mapMeasuringUnit(this.positioningUnit);

    if (null != top) {
      widgetObject.htmlElement.style.top = top.toString() + positioningUnit;
    }
    if (null != bottom) {
      widgetObject.htmlElement.style.bottom = bottom.toString() + positioningUnit;
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

    Framework.renderSingleChildWidget(
      context: context,
      widget: child,
    );
  }
}
