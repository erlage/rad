import 'dart:html';

import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/classes/utils.dart';

class SizeProps {
  double? width;
  double? height;

  String? size;

  String unit;

  SizeProps({
    this.size,
    this.width,
    this.height,
    MeasuringUnit? sizeUnit,
  }) : unit = Utils.mapMeasuringUnit(sizeUnit ?? MeasuringUnit.pixel);

  // application

  /// Apply props.
  ///
  /// if [updatedProps] is not null, it'll do a update
  ///
  void apply(HtmlElement element, [SizeProps? updatedProps]) {
    if (null == updatedProps) {
      return _applyProps(element, this);
    }

    if (_isChanged(updatedProps)) {
      _clearProps(element, this);
      _switchProps(updatedProps);
      _applyProps(element, this);
    }
  }

  /*
  |--------------------------------------------------------------------------
  | internals
  |--------------------------------------------------------------------------
  */

  bool _isChanged(SizeProps props) {
    return size != props.size ||
        width != props.width ||
        height != props.height ||
        unit != props.unit;
  }

  void _switchProps(SizeProps props) {
    this
      ..size = props.size
      ..width = props.width
      ..height = props.height
      ..unit = props.unit;
  }

  // statics

  static void _applyProps(HtmlElement element, SizeProps props) {
    var size = props.size;

    if (null != size && size.isNotEmpty) {
      var sizeProps = size.split(" ");

      if (null != props.width) {
        element.style.setProperty(Props.width, sizeProps.first);
      }

      if (sizeProps.length > 1) {
        element.style.setProperty(Props.height, sizeProps[1]);
      }
    } else {
      if (null != props.width) {
        element.style.setProperty(Props.width, "${props.width}${props.unit}");
      }

      if (null != props.height) {
        element.style.setProperty(Props.height, "${props.height}${props.unit}");
      }
    }
  }

  static void _clearProps(HtmlElement element, SizeProps props) {
    var size = props.size;

    if (null != size && size.isNotEmpty) {
      var sizeProps = size.split(" ");

      if (null != props.width) {
        element.style.removeProperty(Props.width);
      }

      if (sizeProps.length > 1) {
        element.style.removeProperty(Props.height);
      }
    } else {
      if (null != props.width) {
        element.style.removeProperty(Props.width);
      }

      if (null != props.height) {
        element.style.removeProperty(Props.height);
      }
    }
  }
}
