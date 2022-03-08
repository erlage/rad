import 'dart:html';

import 'package:rad/src/widgets/props/common_props.dart';

class MarkUpTagProps {
  String? title;

  String? classes;

  int? tabIndex;

  bool? hidden;

  bool? draggable;

  bool? contenteditable;

  Map<String, String>? dataset;

  MarkUpTagProps({
    this.title,
    this.tabIndex,
    this.classes,
    this.hidden,
    this.draggable,
    this.contenteditable,
    this.dataset,
  });

  // application

  /// Apply props.
  ///
  /// if [updatedProps] is not null, it'll do a update
  ///
  void apply(HtmlElement element, [MarkUpTagProps? updatedProps]) {
    if (null == updatedProps) {
      return _applyProps(element, this);
    }

    if (_isChanged(updatedProps)) {
      _clearProps(element, this);
      _switchProps(updatedProps);
      _applyProps(element, this);
    }
  }

  bool _isChanged(MarkUpTagProps props) {
    return title != props.title ||
        tabIndex != props.tabIndex ||
        classes != props.classes ||
        hidden != props.hidden ||
        draggable != props.draggable ||
        contenteditable != props.contenteditable ||
        dataset != props.dataset;
  }

  void _switchProps(MarkUpTagProps updatedProps) {
    this
      ..title = updatedProps.title
      ..tabIndex = updatedProps.tabIndex
      ..classes = updatedProps.classes
      ..hidden = updatedProps.hidden
      ..draggable = updatedProps.draggable
      ..contenteditable = updatedProps.contenteditable
      ..dataset = updatedProps.dataset;
  }

  // statics

  static void _applyProps(HtmlElement element, MarkUpTagProps props) {
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

    CommonProps.applyClasses(element, props.classes);
    CommonProps.applyDataset(element, props.dataset);
  }

  static void _clearProps(HtmlElement element, MarkUpTagProps props) {
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

    CommonProps.clearClasses(element, props.classes);
    CommonProps.clearDataset(element, props.dataset);
  }
}
