import 'dart:html';

import 'package:rad/src/core/constants.dart';

/// Alignment property object.
///
class Alignment {
  final double top;
  final double left;

  /// Element's Alignment.
  ///
  /// Rad uses a sane alignment values that are staightforward
  /// to understand and work with.
  ///
  /// `Alignment(0, 0)` represents the top left point..
  ///
  /// `Alignment(100, 100)` represents the bottom right point.
  ///
  const Alignment(this.top, this.left);

  /// The top left corner.
  static const Alignment topLeft = Alignment(0, 0);

  /// The center point along the top edge.
  static const Alignment topCenter = Alignment(0, 50);

  /// The top right corner.
  static const Alignment topRight = Alignment(0, 100);

  /// The center point along the left edge.
  static const Alignment centerLeft = Alignment(50, 0);

  /// The center point, both horizontally and vertically.
  static const Alignment center = Alignment(50, 50);

  /// The center point along the right edge.
  static const Alignment centerRight = Alignment(50, 100);

  /// The bottom left corner.
  static const Alignment bottomLeft = Alignment(100, 0);

  /// The center point along the bottom edge.
  static const Alignment bottomCenter = Alignment(100, 50);

  /// The bottom right corner.
  static const Alignment bottomRight = Alignment(100, 100);

  // application

  /// Apply alignment.
  ///
  /// if [updatedAlignment] is not null, it'll do a update.
  ///
  void apply(HtmlElement element, [Alignment? updatedAlignment]) {
    if (null == updatedAlignment) {
      return _applyAlignment(element, this);
    }

    if (_isChanged(updatedAlignment)) {
      // since alignment cant be null & it always have values for both left and right
      // directions, we can ignore cleaning previous alignment
      // _clearAlignment(element, this);

      // this also means we don't have to keep track of current alignment because it's
      // not used anymore.
      // _updateAlignment(updatedAlignment)

      _applyAlignment(element, updatedAlignment);
    }
  }

  /*
  |--------------------------------------------------------------------------
  | internals
  |--------------------------------------------------------------------------
  */

  bool _isChanged(Alignment alignment) {
    return top != alignment.top || left != alignment.left;
  }

  // statics

  static void _applyAlignment(HtmlElement element, Alignment alignment) {
    element.style.setProperty(Props.top, "${alignment.top}%");
    element.style.setProperty(Props.left, "${alignment.left}%");

    element.style.setProperty(
      Props.transform,
      "translate(-${alignment.left}%, -${alignment.top}%)",
    );
  }
}
