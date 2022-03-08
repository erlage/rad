import 'dart:html';

import 'package:rad/src/widgets/props/common_tag_props.dart';

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
      return CommonTagProps.applyClasses(element, classes);
    }

    if (_isChanged(updatedProps)) {
      CommonTagProps.clearClasses(element, classes);

      _switchProps(updatedProps);

      CommonTagProps.applyClasses(element, classes);
    }
  }

  bool _isChanged(StyleProps props) {
    return classes != props.classes;
  }

  void _switchProps(StyleProps updatedProps) {
    classes = updatedProps.classes;
  }
}
