import 'dart:html';

import 'package:rad/src/core/constants.dart';

class PositionProps {
  String? top;
  String? bottom;
  String? left;
  String? right;
  String? position;

  PositionProps({
    this.top,
    this.bottom,
    this.left,
    this.right,
    this.position,
  });

  /// Apply props.
  ///
  /// if [updatedProps] is not null, it'll do a update.
  ///
  void apply(HtmlElement element, [PositionProps? updatedProps]) {
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

  bool _isChanged(PositionProps props) {
    return top != props.top ||
        bottom != props.bottom ||
        right != props.right ||
        left != props.left ||
        position != props.position;
  }

  void _switchProps(PositionProps props) {
    this
      ..top = props.top
      ..bottom = props.bottom
      ..left = props.left
      ..right = props.right
      ..position = props.position;
  }

  // statics

  static void _applyProps(HtmlElement element, PositionProps props) {
    var position = props.position;

    if (null != position && position.isNotEmpty) {
      var positionProps = position.split(" ");

      var propertyList = [Props.top, Props.right, Props.bottom, Props.left];

      for (var property in propertyList) {
        var propertyIndex = propertyList.indexOf(property);

        if (positionProps.length > propertyIndex) {
          var propValue = positionProps.elementAt(propertyIndex);

          if ("_" != propValue) {
            element.style.setProperty(property, propValue);
          }
        }
      }
    } else {
      if (null != props.top) {
        element.style.setProperty(Props.top, props.top);
      }

      if (null != props.bottom) {
        element.style.setProperty(Props.bottom, props.bottom);
      }

      if (null != props.left) {
        element.style.setProperty(Props.left, props.left);
      }

      if (null != props.right) {
        element.style.setProperty(Props.right, props.right);
      }
    }
  }

  static void _clearProps(HtmlElement element, PositionProps props) {
    var position = props.position;

    if (null != position && position.isNotEmpty) {
      var positionProps = position.split(" ");

      var propertyList = [Props.top, Props.right, Props.bottom, Props.left];

      for (var property in propertyList) {
        var propertyIndex = propertyList.indexOf(property);

        if (positionProps.length > propertyIndex) {
          var propValue = positionProps.elementAt(propertyIndex);

          if ("_" != propValue) {
            element.style.removeProperty(property);
          }
        }
      }
    } else {
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
}
