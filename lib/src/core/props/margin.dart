import "dart:html";

import "package:rad/src/core/enums.dart";
import "package:rad/src/core/constants.dart";

/// Margin property object.
///
class Margin {
  MarginType type;

  double top;
  double bottom;
  double left;
  double right;

  /// Whether margin has to be included in box"s size
  ///
  bool flagContainInBoxSize = false;

  /// Margin around an element.
  ///
  Margin({
    required this.top,
    required this.bottom,
    required this.left,
    required this.right,
  }) : type = MarginType.allDifferent;

  /// Margin with only the given values.
  ///
  Margin.only({
    this.top = 0.0,
    this.bottom = 0.0,
    this.left = 0.0,
    this.right = 0.0,
  }) : type = MarginType.only;

  /// Symmetrical margin.
  ///
  Margin.symmetric({
    double vertical = 0.0,
    double horizontal = 0.0,
  })  : type = MarginType.symmetric,
        top = vertical,
        bottom = vertical,
        left = horizontal,
        right = horizontal;

  /// Same margin for all four sides.
  ///
  Margin.all(double value)
      : type = MarginType.allSame,
        top = value,
        bottom = value,
        left = value,
        right = value;

  // application

  /// Apply margin.
  ///
  /// if [updatedMargin] is not null, it"ll do a update.
  ///
  void apply(HtmlElement element, [Margin? updatedMargin]) {
    if (null == updatedMargin) {
      return _applyMargin(element, this);
    }

    if (_isChanged(updatedMargin)) {
      _clearMargin(element, this);
      _updateMargin(updatedMargin);
      _applyMargin(element, this);
    }
  }

  /*
  |--------------------------------------------------------------------------
  | internals
  |--------------------------------------------------------------------------
  */

  bool _isChanged(Margin margin) {
    return top != margin.top ||
        bottom != margin.bottom ||
        right != margin.right ||
        left != margin.left ||
        type != margin.type;
  }

  void _updateMargin(Margin margin) {
    this
      ..top = margin.top
      ..bottom = margin.bottom
      ..right = margin.right
      ..left = margin.left;
  }

  // statics

  static void _applyMargin(HtmlElement element, Margin margin) {
    switch (margin.type) {
      case MarginType.only:
        if (margin.top != 0.0) {
          element.style.setProperty(Props.marginTop, "${margin.top}px");
        }

        if (margin.bottom != 0.0) {
          element.style.setProperty(Props.marginBottom, "${margin.bottom}px");
        }

        if (margin.left != 0.0) {
          element.style.setProperty(Props.marginLeft, "${margin.left}px");
        }

        if (margin.right != 0.0) {
          element.style.setProperty(Props.marginRight, "${margin.right}px");
        }

        break;

      case MarginType.allSame:
      case MarginType.symmetric:
      case MarginType.allDifferent:
        element.style.setProperty(
          Props.margin,
          "${margin.top}px ${margin.right}px ${margin.bottom}px ${margin.left}px",
        );

        break;
    }

    // contain margin in box size by reducing box size

    if (margin.flagContainInBoxSize) {
      element.style.setProperty(
        Props.width,
        "calc(100% - ${(margin.left + margin.right)}px)",
      );

      element.style.setProperty(
        Props.height,
        "calc(100% - ${(margin.top + margin.bottom)}px)",
      );
    }
  }

  static void _clearMargin(HtmlElement element, Margin margin) {
    switch (margin.type) {
      case MarginType.only:
        if (margin.top != 0.0) {
          element.style.removeProperty(Props.marginTop);
        }

        if (margin.bottom != 0.0) {
          element.style.removeProperty(Props.marginBottom);
        }

        if (margin.left != 0.0) {
          element.style.removeProperty(Props.marginLeft);
        }

        if (margin.right != 0.0) {
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
