import 'dart:html';

import 'package:rad/src/core/classes/utils.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/constants.dart';

class FlexProps {
  Axis axis;

  double? gap;

  FlexWrap flexWrap;

  MainAxisAlignment mainAxisAlignment;
  CrossAxisAlignment crossAxisAlignment;

  FlexProps({
    this.gap,
    required this.axis,
    required this.flexWrap,
    required this.mainAxisAlignment,
    required this.crossAxisAlignment,
  });

  /// Apply props.
  ///
  /// if [updatedProps] is not null, it'll do a update
  ///
  void apply(HtmlElement element, [FlexProps? updatedProps]) {
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

  bool _isChanged(FlexProps props) {
    return gap != props.gap ||
        axis != props.axis ||
        flexWrap != props.flexWrap ||
        mainAxisAlignment != props.mainAxisAlignment ||
        crossAxisAlignment != props.crossAxisAlignment;
  }

  void _switchProps(FlexProps props) {
    this
      ..gap = props.gap
      ..axis = props.axis
      ..flexWrap = props.flexWrap
      ..mainAxisAlignment = props.mainAxisAlignment
      ..crossAxisAlignment = props.crossAxisAlignment;
  }

  // statics

  static void _applyProps(HtmlElement element, FlexProps props) {
    if (null != props.gap) {
      element.style.setProperty(Props.gap, "${props.gap}px");
    }

    element.style.setProperty(
      Props.flexDirection,
      Utils.mapAxisForFlex(props.axis),
    );

    element.style.setProperty(
      Props.justifyContent,
      Utils.mapMainAxisAlignment(props.mainAxisAlignment),
    );

    element.style.setProperty(
      Props.alignItems,
      Utils.mapCrossAxisAlignment(props.crossAxisAlignment),
    );

    element.style.setProperty(
      Props.flexWrap,
      Utils.mapFlexWrap(props.flexWrap),
    );
  }

  static void _clearProps(HtmlElement element, FlexProps props) {
    if (null != props.gap) {
      element.style.removeProperty(Props.gap);
    }
  }
}
