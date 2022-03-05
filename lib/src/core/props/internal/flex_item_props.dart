import 'dart:html';

import 'package:rad/src/core/constants.dart';

class FlexItemProps {
  final int flex;

  FlexItemProps({
    required this.flex,
  });

  /// Apply props.
  ///
  /// if [updatedProps] is not null, it'll do a update
  ///
  void apply(HtmlElement element, [FlexItemProps? updatedProps]) {
    if (null == updatedProps) {
      return _applyProps(element, this);
    }

    if (_isChanged(updatedProps)) {
      _applyProps(element, updatedProps);
    }
  }

  /*
  |--------------------------------------------------------------------------
  | internals
  |--------------------------------------------------------------------------
  */

  bool _isChanged(FlexItemProps props) => flex != props.flex;

  // statics

  static void _applyProps(HtmlElement element, FlexItemProps props) {
    element.style.setProperty(Props.flex, "${props.flex}");
  }
}
