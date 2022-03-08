import 'dart:html';

import 'package:rad/src/widgets/props/common_props.dart';

class BlockquoteProps {
  String? cite;

  String? classes;

  BlockquoteProps({
    this.cite,
    this.classes,
  });

  // application

  /// Apply props.
  ///
  /// if [updatedProps] is not null, it'll do a update
  ///
  void apply(HtmlElement element, [BlockquoteProps? updatedProps]) {
    if (null == updatedProps) {
      return _applyProps(element, this);
    }

    if (_isChanged(updatedProps)) {
      _clearProps(element, this);
      _switchProps(updatedProps);
      _applyProps(element, this);
    }
  }

  bool _isChanged(BlockquoteProps props) {
    return cite != props.cite || classes != props.classes;
  }

  void _switchProps(BlockquoteProps updatedProps) {
    this
      ..cite = updatedProps.cite
      ..classes = updatedProps.classes;
  }

  // statics

  static void _applyProps(HtmlElement element, BlockquoteProps props) {
    element as QuoteElement;

    if (null != props.cite) {
      element.cite = props.cite!;
    }

    CommonProps.applyClasses(element, props.classes);
  }

  static void _clearProps(HtmlElement element, BlockquoteProps props) {
    element as QuoteElement;

    if (null != props.cite) {
      element.cite = "";
    }

    CommonProps.clearClasses(element, props.classes);
  }
}
