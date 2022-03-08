import 'dart:html';

class LabelTagProps {
  String? htmlFor;

  LabelTagProps(this.htmlFor);

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
    return htmlFor != props.htmlFor;
  }

  void _switchProps(LabelTagProps updatedProps) {
    htmlFor = updatedProps.htmlFor;
  }

  // statics

  static void _applyProps(HtmlElement element, LabelTagProps props) {
    element as LabelElement;

    if (null != props.htmlFor) {
      element.htmlFor = props.htmlFor!;
    }
  }

  static void _clearProps(HtmlElement element, LabelTagProps props) {
    element as LabelElement;

    if (null != props.htmlFor) {
      element.htmlFor = "";
    }
  }
}
