import 'dart:html';

import 'package:rad/src/widgets/props/common_props.dart';

/// Attribute class property.
///
class ClassAttributeProp {
  String? classAttribute;

  ClassAttributeProp(this.classAttribute);

  /// Apply.
  ///
  /// if [updatedProps] is not null, it'll do a update
  ///
  void apply(HtmlElement element, [ClassAttributeProp? updatedProps]) {
    if (null == updatedProps) {
      return CommonProps.applyClassAttribute(element, classAttribute);
    }

    if (_isChanged(updatedProps)) {
      CommonProps.clearClassAttribute(element, classAttribute);

      _switchProps(updatedProps);

      CommonProps.applyClassAttribute(element, classAttribute);
    }
  }

  bool _isChanged(ClassAttributeProp props) {
    return classAttribute != props.classAttribute;
  }

  void _switchProps(ClassAttributeProp updatedProps) {
    classAttribute = updatedProps.classAttribute;
  }
}
