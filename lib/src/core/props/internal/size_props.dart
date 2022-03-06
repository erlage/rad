import 'dart:html';

import 'package:rad/src/core/constants.dart';

class SizeProps {
  String? margin;
  String? padding;

  String? width;
  String? height;
  String? size;

  SizeProps({
    this.size,
    this.width,
    this.height,
  });

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
        margin != props.margin ||
        padding != props.padding;
  }

  void _switchProps(SizeProps props) {
    this
      ..size = props.size
      ..width = props.width
      ..height = props.height
      ..margin = props.margin
      ..padding = props.padding;
  }

  // statics

  static void _applyProps(HtmlElement element, SizeProps props) {
    var size = props.size;

    if (null != size && size.isNotEmpty) {
      var sizeProps = size.split(" ");

      if (sizeProps.isNotEmpty) {
        if ("unset" != sizeProps.first) {
          element.style.setProperty(Props.width, sizeProps.first);
        }

        if (sizeProps.length > 1) {
          element.style.setProperty(Props.height, sizeProps[1]);
        }
      }
    } else {
      if (null != props.width) {
        element.style.setProperty(Props.width, props.width);
      }

      if (null != props.height) {
        element.style.setProperty(Props.height, props.height);
      }
    }

    if (null != props.margin) {
      element.style.setProperty(Props.margin, props.margin);
    }

    if (null != props.padding) {
      element.style.setProperty(Props.padding, props.padding);
    }
  }

  static void _clearProps(HtmlElement element, SizeProps props) {
    var size = props.size;

    if (null != size && size.isNotEmpty) {
      var sizeProps = size.split(" ");

      if (sizeProps.isNotEmpty) {
        if ("unset" != sizeProps.first) {
          element.style.removeProperty(Props.width);
        }

        if (sizeProps.length > 1) {
          element.style.removeProperty(Props.height);
        }
      }
    } else {
      if (null != props.width) {
        element.style.removeProperty(Props.width);
      }

      if (null != props.height) {
        element.style.removeProperty(Props.height);
      }
    }

    if (null != props.margin) {
      element.style.removeProperty(Props.margin);
    }

    if (null != props.padding) {
      element.style.removeProperty(Props.padding);
    }
  }
}
