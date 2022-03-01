import 'dart:html';

import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/constants.dart';

/// Padding property object.
///
class PaddingSize {
  PaddingType type;

  double top;
  double bottom;
  double left;
  double right;

  /// Padding space inside an element.
  ///
  PaddingSize({
    required this.top,
    required this.bottom,
    required this.left,
    required this.right,
  }) : type = PaddingType.allDifferent;

  /// Padding with only the given values.
  ///
  PaddingSize.only({
    this.top = 0.0,
    this.bottom = 0.0,
    this.left = 0.0,
    this.right = 0.0,
  }) : type = PaddingType.only;

  /// Symmetrical Padding.
  ///
  PaddingSize.symmetric({
    double vertical = 0.0,
    double horizontal = 0.0,
  })  : type = PaddingType.symmetric,
        top = vertical,
        bottom = vertical,
        left = horizontal,
        right = horizontal;

  /// Same padding space on all four sides
  ///
  PaddingSize.all(double value)
      : type = PaddingType.allSame,
        top = value,
        bottom = value,
        left = value,
        right = value;

  // application

  /// Apply padding size.
  ///
  /// if [updatedPaddingSize] is not null, it'll do a update.
  ///
  void apply(HtmlElement element, [PaddingSize? updatedPaddingSize]) {
    if (null == updatedPaddingSize) {
      return _applySize(element, this);
    }

    if (_isChanged(updatedPaddingSize)) {
      _clearSize(element, this);
      _updateSize(updatedPaddingSize);
      _applySize(element, this);
    }
  }

  // internals

  bool _isChanged(PaddingSize paddingSize) {
    return top != paddingSize.top ||
        bottom != paddingSize.bottom ||
        right != paddingSize.right ||
        left != paddingSize.left ||
        type != paddingSize.type;
  }

  void _updateSize(PaddingSize paddingSize) {
    top = paddingSize.top;
    bottom = paddingSize.bottom;
    right = paddingSize.right;
    left = paddingSize.left;

    type = paddingSize.type;
  }

  // statics

  static void _applySize(HtmlElement element, PaddingSize size) {
    switch (size.type) {
      case PaddingType.only:
        if (size.top != 0.0) {
          element.style.setProperty(Props.paddingTop, "${size.top}px");
        }

        if (size.bottom != 0.0) {
          element.style.setProperty(Props.paddingBottom, "${size.bottom}px");
        }

        if (size.left != 0.0) {
          element.style.setProperty(Props.paddingLeft, "${size.left}px");
        }

        if (size.right != 0.0) {
          element.style.setProperty(Props.paddingRight, "${size.right}px");
        }

        break;

      case PaddingType.allSame:
      case PaddingType.symmetric:
      case PaddingType.allDifferent:
        element.style.setProperty(
          Props.padding,
          "${size.top}px ${size.right}px ${size.bottom}px ${size.left}px",
        );

        break;
    }
  }

  static void _clearSize(HtmlElement element, PaddingSize size) {
    switch (size.type) {
      case PaddingType.only:
        if (size.top != 0.0) {
          element.style.removeProperty(Props.paddingTop);
        }

        if (size.bottom != 0.0) {
          element.style.removeProperty(Props.paddingBottom);
        }

        if (size.left != 0.0) {
          element.style.removeProperty(Props.paddingLeft);
        }

        if (size.right != 0.0) {
          element.style.removeProperty(Props.paddingRight);
        }

        break;

      case PaddingType.allSame:
      case PaddingType.symmetric:
      case PaddingType.allDifferent:
        element.style.removeProperty(Props.padding);

        break;
    }
  }
}
