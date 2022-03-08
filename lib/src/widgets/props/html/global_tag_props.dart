import 'dart:html';

import 'package:rad/src/widgets/props/common_props.dart';

class GlobalTagProps {
  String? title;

  String? classAttribute;

  int? tabIndex;

  bool? hidden;

  bool? draggable;

  bool? contenteditable;

  Map<String, String>? dataAttributes;

  GlobalTagProps({
    this.title,
    this.tabIndex,
    this.classAttribute,
    this.hidden,
    this.draggable,
    this.contenteditable,
    this.dataAttributes,
  });

  // application

  /// Apply props.
  ///
  /// if [updatedProps] is not null, it'll do a update
  ///
  void apply(HtmlElement element, [GlobalTagProps? updatedProps]) {
    if (null == updatedProps) {
      return _applyProps(element, this);
    }

    if (_isChanged(updatedProps)) {
      _clearProps(element, this);
      _switchProps(updatedProps);
      _applyProps(element, this);
    }
  }

  bool _isChanged(GlobalTagProps props) {
    return title != props.title ||
        tabIndex != props.tabIndex ||
        classAttribute != props.classAttribute ||
        hidden != props.hidden ||
        draggable != props.draggable ||
        contenteditable != props.contenteditable ||
        dataAttributes != props.dataAttributes;
  }

  void _switchProps(GlobalTagProps updatedProps) {
    this
      ..title = updatedProps.title
      ..tabIndex = updatedProps.tabIndex
      ..classAttribute = updatedProps.classAttribute
      ..hidden = updatedProps.hidden
      ..draggable = updatedProps.draggable
      ..contenteditable = updatedProps.contenteditable
      ..dataAttributes = updatedProps.dataAttributes;
  }

  // statics

  static void _applyProps(HtmlElement element, GlobalTagProps props) {
    if (null != props.title) {
      element.title = props.title;
    }

    if (null != props.tabIndex) {
      element.tabIndex = props.tabIndex;
    }

    if (null != props.hidden) {
      element.hidden = props.hidden!;
    }

    if (null != props.draggable) {
      element.draggable = props.draggable!;
    }

    var editable = props.contenteditable;
    if (null != editable) {
      element.contentEditable = editable ? "true" : "false";
    }

    CommonProps.applyClassAttribute(element, props.classAttribute);
    CommonProps.applyDataAttributes(element, props.dataAttributes);
  }

  static void _clearProps(HtmlElement element, GlobalTagProps props) {
    if (null != props.title) {
      element.title = "";
    }

    if (null != props.hidden) {
      element.hidden = false;
    }

    if (null != props.draggable) {
      element.draggable = false;
    }

    var editable = props.contenteditable;
    if (null != editable) {
      element.contentEditable = "false";
    }

    CommonProps.clearClassAttribute(element, props.classAttribute);
    CommonProps.clearDataAttributes(element, props.dataAttributes);
  }
}
