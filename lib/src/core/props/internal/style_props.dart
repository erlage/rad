import 'dart:html';

class StyleProps {
  List<String> stylesList = [];

  StyleProps(String? styles) {
    stylesList.addAll(null != styles ? styles.split(" ") : []);
  }

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
    return stylesList.join() != props.stylesList.join();
  }

  void _switchProps(StyleProps updatedProps) {
    stylesList = updatedProps.stylesList;
  }

  // statics

  static void _applyProps(HtmlElement element, StyleProps props) {
    if (props.stylesList.isNotEmpty) {
      element.classes.addAll(props.stylesList);
    }
  }

  static void _clearProps(HtmlElement element, StyleProps props) {
    if (props.stylesList.isNotEmpty) {
      element.classes.removeAll(props.stylesList);
    }
  }
}
