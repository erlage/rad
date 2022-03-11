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

  /// Element's inner text.
  ///
  /// Only one thing can be set at a time between [innerText]
  /// and [children]
  ///
  final String? innerText;

  /// Children tags.
  ///
  final List<Widget>? children;

  const MarkUpTagWithGlobalProps({
    String? key,
    this.title,
    this.tabIndex,
    this.classAttribute,
    this.dataAttributes,
    this.hidden,
    this.draggable,
    this.contenteditable,
    this.innerText,
    this.children,
  })  : assert(null == children || null == innerText),
        super(key);

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
      innerText: innerText,
    );
  }

  @override
  isConfigurationChanged(oldConfiguration) {
    oldConfiguration as MarkUpGlobalConfiguration;

    return title != oldConfiguration.title ||
        tabIndex != oldConfiguration.tabIndex ||
        classAttribute != oldConfiguration.classAttribute ||
        dataAttributes != oldConfiguration.dataAttributes ||
        hidden != oldConfiguration.hidden ||
        draggable != oldConfiguration.draggable ||
        contenteditable != oldConfiguration.contenteditable ||
        innerText != oldConfiguration.innerText;
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

  final String? innerText;

  const MarkUpGlobalConfiguration({
    this.title,
    this.tabIndex,
    this.classAttribute,
    this.dataAttributes,
    this.hidden,
    this.draggable,
    this.contenteditable,
    this.innerText,
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

    if (null != props.innerText) {
      element.innerText = props.innerText!;
    }
  }

  static void clear(HtmlElement element, MarkUpGlobalConfiguration props) {
    CommonProps.clearClassAttribute(element, props.classAttribute);

    CommonProps.clearDataAttributes(element, props.dataAttributes);

    if (null != props.title) {
      element.removeAttribute(_Attributes.title);
    }

    if (null != props.hidden) {
      element.removeAttribute(_Attributes.hidden);
    }

    if (null != props.tabIndex) {
      element.removeAttribute(_Attributes.tabindex);
    }

    if (null != props.draggable) {
      element.removeAttribute(_Attributes.draggable);
    }

    if (null != props.contenteditable) {
      element.removeAttribute(_Attributes.contenteditable);
    }

    if (null != props.innerText) {
      element.innerText = "";
    }
  }
}

class _Attributes {
  static const title = "title";
  static const hidden = "hidden";
  static const tabindex = "tabindex";
  static const draggable = "draggable";
  static const contenteditable = "contenteditable";
}
