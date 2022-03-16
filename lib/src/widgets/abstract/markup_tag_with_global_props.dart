import 'dart:html';

import 'package:rad/src/core/classes/utils.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/types.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/utils/common_props.dart';

abstract class MarkUpTagWithGlobalProps extends Widget {
  /// The title attribute specifies extra information about an element.
  ///
  final String? title;

  /// The classes attribute specifies one or more class names for an element.
  ///
  final String? classAttribute;

  /// The style attribute for inline CSS.
  ///
  final String? style;

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

  /// onClick raw attribute. for inlined JS callback: onclick="<someJS>"
  ///
  final String? onClick;

  /// Tag's onClick event listener. For adding Dart callback on click event.
  ///
  final EventCallback? onClickEventListener;

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
    this.style,
    this.classAttribute,
    this.dataAttributes,
    this.hidden,
    this.draggable,
    this.contenteditable,
    this.onClick,
    this.onClickEventListener,
    this.innerText,
    this.children,
  })  : assert(null == children || null == innerText),
        super(key: key);

  @override
  get widgetChildren => children ?? [];

  @override
  createConfiguration() {
    return MarkUpGlobalConfiguration(
      title: title,
      tabIndex: tabIndex,
      style: style,
      classAttribute: classAttribute,
      dataAttributes: dataAttributes,
      hidden: hidden,
      draggable: draggable,
      contenteditable: contenteditable,
      onClick: onClick,
      onClickEventListener: onClickEventListener,
      innerText: innerText,
    );
  }

  @override
  isConfigurationChanged(oldConfiguration) {
    oldConfiguration as MarkUpGlobalConfiguration;

    return title != oldConfiguration.title ||
        tabIndex != oldConfiguration.tabIndex ||
        style != oldConfiguration.style ||
        classAttribute != oldConfiguration.classAttribute ||
        dataAttributes != oldConfiguration.dataAttributes ||
        hidden != oldConfiguration.hidden ||
        draggable != oldConfiguration.draggable ||
        contenteditable != oldConfiguration.contenteditable ||
        onClick != oldConfiguration.onClick ||
        onClickEventListener.runtimeType !=
            oldConfiguration.onClickEventListener.runtimeType ||
        innerText != oldConfiguration.innerText;
  }

  @override
  createRenderObject(context) => MarkUpGlobalRenderObject(context);
}

/*
|--------------------------------------------------------------------------
| configuration
|--------------------------------------------------------------------------
*/

class MarkUpGlobalConfiguration extends WidgetConfiguration {
  final String? title;

  final String? style;

  final String? classAttribute;

  final int? tabIndex;

  final bool? draggable;

  final bool? contenteditable;

  final Map<String, String>? dataAttributes;

  final bool? hidden;

  final String? onClick;

  final EventCallback? onClickEventListener;

  final String? innerText;

  const MarkUpGlobalConfiguration({
    this.title,
    this.tabIndex,
    this.style,
    this.classAttribute,
    this.dataAttributes,
    this.hidden,
    this.draggable,
    this.contenteditable,
    this.onClick,
    this.onClickEventListener,
    this.innerText,
  });
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class MarkUpGlobalRenderObject extends RenderObject {
  const MarkUpGlobalRenderObject(BuildContext context) : super(context);

  @override
  render(
    element,
    covariant MarkUpGlobalConfiguration configuration,
  ) {
    MarkUpGlobalProps.apply(element, configuration);
  }

  @override
  update({
    required element,
    required updateType,
    required covariant MarkUpGlobalConfiguration oldConfiguration,
    required covariant MarkUpGlobalConfiguration newConfiguration,
  }) {
    MarkUpGlobalProps.clear(element, oldConfiguration);
    MarkUpGlobalProps.apply(element, newConfiguration);
  }
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

    if (null != props.style) {
      element.setAttribute(_Attributes.style, props.style!);
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

    if (null != props.onClick) {
      element.setAttribute(_Attributes.onClick, props.onClick!);
    }

    if (null != props.onClickEventListener) {
      element.addEventListener(
        Utils.mapDomEventType(DomEventType.click),
        props.onClickEventListener,
      );
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

    if (null != props.style) {
      element.removeAttribute(_Attributes.style);
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

    if (null != props.onClick) {
      element.removeAttribute(_Attributes.onClick);
    }

    if (null != props.onClickEventListener) {
      element.removeEventListener(
        Utils.mapDomEventType(DomEventType.click),
        props.onClickEventListener,
      );
    }

    if (null != props.innerText) {
      element.innerText = "";
    }
  }
}

class _Attributes {
  static const title = "title";
  static const style = "style";
  static const hidden = "hidden";
  static const tabindex = "tabindex";
  static const draggable = "draggable";
  static const contenteditable = "contenteditable";
  static const onClick = "onclick";
}
