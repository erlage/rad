import 'package:rad/src/core/framework.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/widget_object.dart';
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
    applyProps(widgetObject, this);

    Framework.buildWidget(
      widget: child,
      parentContext: context,
    );
  }

  @override
  void update(widgetObject, updatedRenderObject) {
    updatedRenderObject as PositionedRenderObject;

    clearProps(widgetObject, this);

    applyProps(widgetObject, updatedRenderObject);

    Framework.updateWidget(
      widget: child,
      parentContext: context,
    );
  }

  applyProps(WidgetObject widgetObj, PositionedRenderObject renderObj) {
    var sizeUnit = Utils.mapMeasuringUnit(renderObj.sizingUnit);
    var posUnit = Utils.mapMeasuringUnit(renderObj.positioningUnit);

    if (null != renderObj.top) {
      widgetObj.htmlElement.style.top = "${renderObj.top}$posUnit";
    }
    if (null != renderObj.bottom) {
      widgetObj.htmlElement.style.bottom = "${renderObj.bottom}$posUnit";
    }
    if (null != renderObj.left) {
      widgetObj.htmlElement.style.left = "${renderObj.left}$posUnit";
    }
    if (null != renderObj.right) {
      widgetObj.htmlElement.style.right = "${renderObj.right}$posUnit";
    }

    if (null != renderObj.width) {
      widgetObj.htmlElement.style.width = "${renderObj.width}$sizeUnit";
    }

    if (null != renderObj.height) {
      widgetObj.htmlElement.style.height = "${renderObj.height}$sizeUnit}";
    }
  }

  clearProps(WidgetObject widgetObj, PositionedRenderObject renderObj) {
    if (null != renderObj.top) {
      widgetObj.htmlElement.style.top = "";
    }
    if (null != renderObj.bottom) {
      widgetObj.htmlElement.style.bottom = "";
    }
    if (null != renderObj.left) {
      widgetObj.htmlElement.style.left = "";
    }
    if (null != renderObj.right) {
      widgetObj.htmlElement.style.right = "";
    }

    if (null != renderObj.width) {
      widgetObj.htmlElement.style.width = "";
    }

    if (null != renderObj.height) {
      widgetObj.htmlElement.style.height = "";
    }
  }
}
