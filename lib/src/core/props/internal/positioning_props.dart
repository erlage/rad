import 'dart:html';

import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/props.dart';
import 'package:rad/src/core/utils.dart';

class PositioningProps {
  double? top;
  double? bottom;
  double? left;
  double? right;

  String unit;

  PositioningProps({
    this.top,
    this.bottom,
    this.left,
    this.right,
    MeasuringUnit? positioningUnit,
  }) : unit = Utils.mapMeasuringUnit(positioningUnit ?? MeasuringUnit.pixel);

  /// Apply props.
  ///
  /// if [updatedProps] is not null, it'll do a update.
  ///
  void apply(HtmlElement element, [PositioningProps? updatedProps]) {
    if (null == updatedProps) {
      return _applyProps(element, this);
    }

    if (_isChanged(updatedProps)) {
      _clearProps(element, this);
      _switchProps(updatedProps);
      _applyProps(element, this);
    }
  }

  // internals

  bool _isChanged(PositioningProps props) {
    return top != props.top ||
        bottom != props.bottom ||
        right != props.right ||
        left != props.left ||
        unit != props.unit;
  }

  void _switchProps(PositioningProps props) {
    top = props.top;
    bottom = props.bottom;
    left = props.left;
    right = props.right;

    unit = props.unit;
  }

  // statics

  static void _applyProps(HtmlElement element, PositioningProps props) {
    if (null != props.top) {
      element.style.setProperty(Props.top, "${props.top}${props.unit}");
    }

    if (null != props.bottom) {
      element.style.setProperty(Props.bottom, "${props.bottom}${props.unit}");
    }

    if (null != props.left) {
      element.style.setProperty(Props.left, "${props.left}${props.unit}");
    }

    if (null != props.right) {
      element.style.setProperty(Props.right, "${props.right}${props.unit}");
    }
  }

  static void _clearProps(HtmlElement element, PositioningProps props) {
    if (null != props.top) {
      element.style.removeProperty(Props.top);
    }

    if (null != props.bottom) {
      element.style.removeProperty(Props.bottom);
    }

    if (null != props.left) {
      element.style.removeProperty(Props.left);
    }

    if (null != props.right) {
      element.style.removeProperty(Props.right);
    }
  }
}
