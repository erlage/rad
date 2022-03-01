import 'dart:html';

import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/props.dart';
import 'package:rad/src/core/utils.dart';

class SizingProps {
  double? width;
  double? height;

  String unit;

  SizingProps({
    this.width,
    this.height,
    required MeasuringUnit sizingUnit,
  }) : unit = Utils.mapMeasuringUnit(sizingUnit);

  // application

  /// Apply props.
  ///
  /// if [updatedProps] is not null, it'll do a update
  ///
  void apply(HtmlElement element, [SizingProps? updatedProps]) {
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

  bool _isChanged(SizingProps props) {
    return width != props.width || height != props.height || unit != props.unit;
  }

  void _switchProps(SizingProps props) {
    width = props.width;
    height = props.height;
    unit = props.unit;
  }

  // statics

  static void _applyProps(HtmlElement element, SizingProps props) {
    if (null != props.width) {
      element.style.setProperty(Props.width, "${props.width}${props.unit}");
    }

    if (null != props.height) {
      element.style.setProperty(Props.height, "${props.height}${props.unit}");
    }
  }

  static void _clearProps(HtmlElement element, SizingProps props) {
    if (null != props.width) {
      element.style.removeProperty(Props.width);
    }

    if (null != props.height) {
      element.style.removeProperty(Props.height);
    }
  }
}
