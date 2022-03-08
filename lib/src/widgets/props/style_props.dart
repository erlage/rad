import 'dart:html';

import 'package:rad/src/widgets/props/common_props.dart';

class StyleProps {
  String? classAttribute;

  StyleProps(this.classAttribute);

  // application

  /// Apply props.
  ///
  /// if [updatedProps] is not null, it'll do a update
  ///
  void apply(HtmlElement element, [StyleProps? updatedProps]) {
    if (null == updatedProps) {
      return CommonProps.applyClassAttribute(element, classAttribute);
    }

    if (_isChanged(updatedProps)) {
      CommonProps.clearClassAttribute(element, classAttribute);

      _switchProps(updatedProps);

      CommonProps.applyClassAttribute(element, classAttribute);
    }
  }

  bool _isChanged(StyleProps props) {
    return classAttribute != props.classAttribute;
  }

  void _switchProps(StyleProps updatedProps) {
    classAttribute = updatedProps.classAttribute;
  }
}
