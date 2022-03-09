import 'dart:html';

class ImageTagProps {
  String? src;

  String? alt;

  ImageTagProps({this.src, this.alt});

  // application

  /// Apply props.
  ///
  /// if [updatedProps] is not null, it'll do a update
  ///
  void apply(HtmlElement element, [ImageTagProps? updatedProps]) {
    if (null == updatedProps) {
      return _applyProps(element, this);
    }

    if (_isChanged(updatedProps)) {
      _clearProps(element, this);
      _switchProps(updatedProps);
      _applyProps(element, this);
    }
  }

  bool _isChanged(ImageTagProps props) {
    return src != props.src || alt != props.alt;
  }

  void _switchProps(ImageTagProps updatedProps) {
    this
      ..src = updatedProps.src
      ..alt = updatedProps.alt;
  }

  // statics

  static void _applyProps(HtmlElement element, ImageTagProps props) {
    element as ImageElement;
  }

  static void _clearProps(HtmlElement element, ImageTagProps props) {
    element as ImageElement;

    if (null != props.src) {
      element.src = "";
    }

    if (null != props.alt) {
      element.alt = "";
    }
  }
}
