import 'dart:html';

import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/props.dart';

/// Margin property object.
///
class MarginSize {
  MarginType type;

  double top;
  double bottom;
  double left;
  double right;

  /// Margin around an element.
  ///
  MarginSize({
    required this.top,
    required this.bottom,
    required this.left,
    required this.right,
  }) : type = MarginType.allDifferent;

  /// Margin with only the given values.
  ///
  MarginSize.only({
    this.top = 0.0,
    this.bottom = 0.0,
    this.left = 0.0,
    this.right = 0.0,
  }) : type = MarginType.only;

  /// Symmetrical margin.
  ///
  MarginSize.symmetric({
    double vertical = 0.0,
    double horizontal = 0.0,
  })  : type = MarginType.symmetric,
        top = vertical,
        bottom = vertical,
        left = horizontal,
        right = horizontal;

  /// Same margin for all four sides.
  ///
  MarginSize.all(double value)
      : type = MarginType.allSame,
        top = value,
        bottom = value,
        left = value,
        right = value;

  // application

  /// Apply size.
  ///
  /// if [updatedMarginSize] is not null, it'll do a update.
  ///
  void apply(HtmlElement element, [MarginSize? updatedMarginSize]) {
    if (null == updatedMarginSize) {
      return _applySize(element, this);
    }

    if (_isChanged(updatedMarginSize)) {
      _clearSize(element, this);
      _updateSize(updatedMarginSize);
      _applySize(element, this);
    }
  }

  // internals

  bool _isChanged(MarginSize marginSize) {
    return top != marginSize.top ||
        bottom != marginSize.bottom ||
        right != marginSize.right ||
        left != marginSize.left ||
        type != marginSize.type;
  }

  void _updateSize(MarginSize marginSize) {
    top = marginSize.top;
    bottom = marginSize.bottom;
    right = marginSize.right;
    left = marginSize.left;

    type = marginSize.type;
  }

  // statics

  static void _applySize(HtmlElement element, MarginSize size) {
    switch (size.type) {
      case MarginType.only:
        if (size.top != 0.0) {
          element.style.setProperty(Props.marginTop, "${size.top}px");
        }

        if (size.bottom != 0.0) {
          element.style.setProperty(Props.marginBottom, "${size.bottom}px");
        }

        if (size.left != 0.0) {
          element.style.setProperty(Props.marginLeft, "${size.left}px");
        }

        if (size.right != 0.0) {
          element.style.setProperty(Props.marginRight, "${size.right}px");
        }

        break;

      case MarginType.allSame:
      case MarginType.symmetric:
      case MarginType.allDifferent:
        element.style.setProperty(
          Props.margin,
          "${size.top}px ${size.right}px ${size.bottom}px ${size.left}px",
        );

        break;
    }
  }

  static void _clearSize(HtmlElement element, MarginSize size) {
    switch (size.type) {
      case MarginType.only:
        if (size.top != 0.0) {
          element.style.removeProperty(Props.marginTop);
        }

        if (size.bottom != 0.0) {
          element.style.removeProperty(Props.marginBottom);
        }

        if (size.left != 0.0) {
          element.style.removeProperty(Props.marginLeft);
        }

        if (size.right != 0.0) {
          element.style.removeProperty(Props.marginRight);
        }

        break;

      case MarginType.allSame:
      case MarginType.symmetric:
      case MarginType.allDifferent:
        element.style.removeProperty(Props.margin);

        break;
    }
  }
}
