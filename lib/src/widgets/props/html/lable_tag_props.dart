import 'dart:html';

class LabelTagProps {
  String? forAttribute;

  LabelTagProps(this.forAttribute);

  // application

  /// Apply props.
  ///
  /// if [updatedProps] is not null, it'll do a update
  ///
  void apply(HtmlElement element, [LabelTagProps? updatedProps]) {
    if (null == updatedProps) {
      return _applyProps(element, this);
    }

    if (_isChanged(updatedProps)) {
      _clearProps(element, this);
      _switchProps(updatedProps);
      _applyProps(element, this);
    }
  }

  bool _isChanged(LabelTagProps props) {
    return forAttribute != props.forAttribute;
  }

  void _switchProps(LabelTagProps updatedProps) {
    forAttribute = updatedProps.forAttribute;
  }

  // statics

  static void _applyProps(HtmlElement element, LabelTagProps props) {
    element as LabelElement;

    if (null != props.forAttribute) {
      element.htmlFor = props.forAttribute!;
    }
  }

  static void _clearProps(HtmlElement element, LabelTagProps props) {
    element as LabelElement;

    if (null != props.forAttribute) {
      element.htmlFor = "";
    }
  }
}
