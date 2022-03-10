import 'dart:html';

import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/utils/common_props.dart';

abstract class MarkUpTagWithGlobalProps extends Widget {
  /// The title attribute specifies extra information about an element.
  ///
  final String? title;

  /// The classes attribute specifies one or more class names for an element.
  ///
  final String? classAttribute;

  /// The tabindex attribute specifies the tab order of an
  /// element (when the "tab" button is used for navigating).
  ///
  final int? tabIndex;

  /// The draggable attribute specifies whether an element
  /// is draggable or not.
  ///
  final bool? draggable;

  /// The contenteditable attribute specifies whether the content of an
  /// element is editable or not.
  ///
  final bool? contenteditable;

  /// The data-* attributes is used to store custom data
  /// private to the page or application.
  ///
  final Map<String, String>? dataAttributes;

  /// The hidden attribute is a boolean attribute.
  /// When present, it specifies that an element is not yet, or
  /// is no longer, relevant.
  ///
  final bool? hidden;

  /// Children tags.
  ///
  final List<Widget>? children;

  const MarkUpTagWithGlobalProps({
    String? id,
    this.title,
    this.tabIndex,
    this.classAttribute,
    this.dataAttributes,
    this.hidden,
    this.draggable,
    this.contenteditable,
    this.children,
  }) : super(id);

  @override
  get widgetChildren => children ?? [];

  @override
  createConfiguration() {
    return MarkUpGlobalConfiguration(
      title: title,
      tabIndex: tabIndex,
      classAttribute: classAttribute,
      dataAttributes: dataAttributes,
      hidden: hidden,
      draggable: draggable,
      contenteditable: contenteditable,
    );
  }

  @override
  isConfigurationChanged(WidgetConfiguration oldConfiguration) {
    oldConfiguration as MarkUpGlobalConfiguration;

    return title != oldConfiguration.title ||
        tabIndex != oldConfiguration.tabIndex ||
        classAttribute != oldConfiguration.classAttribute ||
        dataAttributes != oldConfiguration.dataAttributes ||
        hidden != oldConfiguration.hidden ||
        draggable != oldConfiguration.draggable ||
        contenteditable != oldConfiguration.contenteditable;
  }
}

/*
|--------------------------------------------------------------------------
| configuration
|--------------------------------------------------------------------------
*/

class MarkUpGlobalConfiguration extends WidgetConfiguration {
  final String? title;

  final String? classAttribute;

  final int? tabIndex;

  final bool? draggable;

  final bool? contenteditable;

  final Map<String, String>? dataAttributes;

  final bool? hidden;

  const MarkUpGlobalConfiguration({
    this.title,
    this.tabIndex,
    this.classAttribute,
    this.dataAttributes,
    this.hidden,
    this.draggable,
    this.contenteditable,
  });
}

/*
|--------------------------------------------------------------------------
| props
|--------------------------------------------------------------------------
*/

class MarkUpGlobalProps {
  static void apply(HtmlElement element, MarkUpGlobalConfiguration props) {
    CommonProps.applyClassAttribute(element, props.classAttribute);

    CommonProps.applyDataAttributes(element, props.dataAttributes);

    element.title = props.title;

    element.tabIndex = props.tabIndex;

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
  }

  static void clear(HtmlElement element, MarkUpGlobalConfiguration props) {
    CommonProps.clearClassAttribute(element, props.classAttribute);

    CommonProps.clearDataAttributes(element, props.dataAttributes);

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
  }
}
