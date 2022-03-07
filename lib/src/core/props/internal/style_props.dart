import 'dart:html';

class StyleProps {
  String? classes;

  StyleProps(this.classes);

  // application

  /// Apply props.
  ///
  /// if [updatedProps] is not null, it'll do a update
  ///
  void apply(HtmlElement element, [StyleProps? updatedProps]) {
    if (null == updatedProps) {
      return _applyProps(element, this);
    }

    if (_isChanged(updatedProps)) {
      _clearProps(element, this);
      _switchProps(updatedProps);
      _applyProps(element, this);
    }
  }

  bool _isChanged(StyleProps props) {
    return classes != props.classes;
  }

  void _switchProps(StyleProps updatedProps) {
    classes = updatedProps.classes;
  }

  // statics

  static void _applyProps(HtmlElement element, StyleProps props) {
    if (null != props.classes) {
      var classes = props.classes?.split(" ") ?? [];

      if (classes.isNotEmpty) {
        element.classes.addAll(classes);
      }
    }
  }

  static void _clearProps(HtmlElement element, StyleProps props) {
    if (null != props.classes) {
      var classes = props.classes?.split(" ") ?? [];

      if (classes.isNotEmpty) {
        element.classes.removeAll(classes);
      }
    }
  }
}
