import 'dart:html';

import 'package:rad/src/core/constants.dart';
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
  DomTag get tag => DomTag.div;

  @override
  String get type => (Positioned).toString();

  @override
  String get initialKey => key ?? Constants.keyNotSet;

  @override
  buildRenderObject(context) {
    return PositionedRenderObject(
      context: context,
      props: PositionedProps(
        top: top,
        bottom: bottom,
        left: left,
        right: right,
        width: width,
        height: height,
        sizingUnit: sizingUnit ?? MeasuringUnit.pixel,
        positioningUnit: positioningUnit ?? MeasuringUnit.pixel,
        child: child,
      ),
    );
  }
}

class PositionedProps {
  final Widget child;

  final int? top;
  final int? bottom;
  final int? left;
  final int? right;
  final MeasuringUnit positioningUnit;

  final int? width;
  final int? height;
  final MeasuringUnit sizingUnit;

  PositionedProps({
    this.top,
    this.bottom,
    this.left,
    this.right,
    this.width,
    this.height,
    required this.positioningUnit,
    required this.sizingUnit,
    required this.child,
  });
}

class PositionedRenderObject extends RenderObject {
  PositionedProps props;

  PositionedRenderObject({
    required this.props,
    required BuildContext context,
  }) : super(context);

  @override
  render(widgetObject) {
    applyProps(widgetObject.htmlElement);

    Framework.buildChildren(
      widgets: [props.child],
      parentContext: context,
    );
  }

  @override
  void update(widgetObject, updatedRenderObject) {
    updatedRenderObject as PositionedRenderObject;

    clearProps(widgetObject.htmlElement);

    switchProps(updatedRenderObject.props);

    applyProps(widgetObject.htmlElement);

    Framework.updateChildren(
      widgets: [props.child],
      parentContext: context,
    );
  }

  void switchProps(PositionedProps props) {
    this.props = props;
  }

  applyProps(HtmlElement htmlElement) {
    var sizeUnit = Utils.mapMeasuringUnit(props.sizingUnit);
    var posUnit = Utils.mapMeasuringUnit(props.positioningUnit);

    if (null != props.top) {
      htmlElement.style.top = "${props.top}$posUnit";
    }
    if (null != props.bottom) {
      htmlElement.style.bottom = "${props.bottom}$posUnit";
    }
    if (null != props.left) {
      htmlElement.style.left = "${props.left}$posUnit";
    }
    if (null != props.right) {
      htmlElement.style.right = "${props.right}$posUnit";
    }

    if (null != props.width) {
      htmlElement.style.width = "${props.width}$sizeUnit";
    }

    if (null != props.height) {
      htmlElement.style.height = "${props.height}$sizeUnit}";
    }
  }

  clearProps(HtmlElement htmlElement) {
    if (null != props.top) {
      htmlElement.style.top = "";
    }
    if (null != props.bottom) {
      htmlElement.style.bottom = "";
    }
    if (null != props.left) {
      htmlElement.style.left = "";
    }
    if (null != props.right) {
      htmlElement.style.right = "";
    }

    if (null != props.width) {
      htmlElement.style.width = "";
    }

    if (null != props.height) {
      htmlElement.style.height = "";
    }
  }
}
