import 'dart:html';

class BlockquoteProps {
  String? cite;

  BlockquoteProps(this.cite);

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
    return cite != props.cite;
  }

  void _switchProps(BlockquoteProps updatedProps) {
    cite = updatedProps.cite;
  }

  // statics

  static void _applyProps(HtmlElement element, BlockquoteProps props) {
    element as QuoteElement;

    if (null != props.cite) {
      element.cite = props.cite!;
    }
  }

  static void _clearProps(HtmlElement element, BlockquoteProps props) {
    element as QuoteElement;

    if (null != props.cite) {
      element.cite = "";
    }
  }
}
