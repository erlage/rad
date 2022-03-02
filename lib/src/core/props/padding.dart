import "dart:html";

import "package:rad/src/core/enums.dart";
import "package:rad/src/core/constants.dart";

/// Padding property object.
///
class Padding {
  PaddingType type;

  double top;
  double bottom;
  double left;
  double right;

  /// Padding space inside an element.
  ///
  Padding({
    required this.top,
    required this.bottom,
    required this.left,
    required this.right,
  }) : type = PaddingType.allDifferent;

  /// Padding with only the given values.
  ///
  Padding.only({
    this.top = 0.0,
    this.bottom = 0.0,
    this.left = 0.0,
    this.right = 0.0,
  }) : type = PaddingType.only;

  /// Symmetrical Padding.
  ///
  Padding.symmetric({
    double vertical = 0.0,
    double horizontal = 0.0,
  })  : type = PaddingType.symmetric,
        top = vertical,
        bottom = vertical,
        left = horizontal,
        right = horizontal;

  /// Same padding space on all four sides
  ///
  Padding.all(double value)
      : type = PaddingType.allSame,
        top = value,
        bottom = value,
        left = value,
        right = value;

  // application

  /// Apply padding.
  ///
  /// if [updatedPadding] is not null, it"ll do a update.
  ///
  void apply(HtmlElement element, [Padding? updatedPadding]) {
    if (null == updatedPadding) {
      return _applyPadding(element, this);
    }

    if (_isChanged(updatedPadding)) {
      _clearPadding(element, this);
      _updatePadding(updatedPadding);
      _applyPadding(element, this);
    }
  }

  // internals

  bool _isChanged(Padding padding) {
    return top != padding.top ||
        bottom != padding.bottom ||
        right != padding.right ||
        left != padding.left ||
        type != padding.type;
  }

  void _updatePadding(Padding padding) {
    this
      ..top = padding.top
      ..bottom = padding.bottom
      ..right = padding.right
      ..left = padding.left
      ..type = padding.type;
  }

  // statics

  static void _applyPadding(HtmlElement element, Padding padding) {
    switch (padding.type) {
      case PaddingType.only:
        if (padding.top != 0.0) {
          element.style.setProperty(Props.paddingTop, "${padding.top}px");
        }

        if (padding.bottom != 0.0) {
          element.style.setProperty(Props.paddingBottom, "${padding.bottom}px");
        }

        if (padding.left != 0.0) {
          element.style.setProperty(Props.paddingLeft, "${padding.left}px");
        }

        if (padding.right != 0.0) {
          element.style.setProperty(Props.paddingRight, "${padding.right}px");
        }

        break;

      case PaddingType.allSame:
      case PaddingType.symmetric:
      case PaddingType.allDifferent:
        element.style.setProperty(
          Props.padding,
          "${padding.top}px ${padding.right}px ${padding.bottom}px ${padding.left}px",
        );

        break;
    }
  }

  static void _clearPadding(HtmlElement element, Padding padding) {
    switch (padding.type) {
      case PaddingType.only:
        if (padding.top != 0.0) {
          element.style.removeProperty(Props.paddingTop);
        }

        if (padding.bottom != 0.0) {
          element.style.removeProperty(Props.paddingBottom);
        }

        if (padding.left != 0.0) {
          element.style.removeProperty(Props.paddingLeft);
        }

        if (padding.right != 0.0) {
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
