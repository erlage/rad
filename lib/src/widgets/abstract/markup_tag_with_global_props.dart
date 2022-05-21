import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/element_description.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/objects/render_object.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/utils/common_props.dart';

/// Base class for HTML widgets that support global attributes.
///
abstract class MarkUpTagWithGlobalProps extends Widget {
  /// ID of element.
  ///
  final String? id;

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

  /// Element's inner text.
  ///
  /// Only one thing can be set at a time between [innerText]
  /// , [children] and [child]
  ///
  final String? innerText;

  /// Single child tag.
  ///
  /// If you want to add multiple child widgets, then use [children]
  ///
  /// Only one thing can be set at a time between [innerText]
  /// , [children] and [child]
  ///
  final Widget? child;

  /// Children tags.
  ///
  /// Only one thing can be set at a time between [innerText]
  /// , [children] and [child]
  ///
  final List<Widget>? children;

  /// On input event listener.
  ///
  final EventCallback? onInputEventListener;

  /// On change event listener.
  ///
  final EventCallback? onChangeEventListener;

  /// On submit event listener.
  ///
  final EventCallback? onSubmitEventListener;

  /// On click event listener.
  ///
  final EventCallback? onClickEventListener;

  const MarkUpTagWithGlobalProps({
    Key? key,
    this.id,
    this.title,
    this.tabIndex,
    this.style,
    this.classAttribute,
    this.dataAttributes,
    this.hidden,
    this.draggable,
    this.contenteditable,
    this.onClick,
    this.innerText,
    this.child,
    this.children,
    this.onInputEventListener,
    this.onChangeEventListener,
    this.onSubmitEventListener,
    this.onClickEventListener,
  })  : assert(
          (null == children && null == child) ||
              (null == child && null == innerText) ||
              (null == children && null == innerText),
          'At least two thing from child, children & innerText has to be null.',
        ),
        super(key: key);

  @override
  get widgetChildren => children ?? (null != child ? [child!] : []);

  @override
  get widgetEventListeners {
    if (null == onClickEventListener &&
        null == onInputEventListener &&
        null == onChangeEventListener &&
        null == onSubmitEventListener) {
      return const {};
    }

    return {
      DomEventType.click: onClickEventListener,
      DomEventType.input: onInputEventListener,
      DomEventType.change: onChangeEventListener,
      DomEventType.submit: onSubmitEventListener,
    };
  }

  @override
  createConfiguration() {
    return MarkUpGlobalConfiguration(
      id: id,
      title: title,
      tabIndex: tabIndex,
      style: style,
      classAttribute: classAttribute,
      dataAttributes: dataAttributes,
      hidden: hidden,
      draggable: draggable,
      contentEditable: contenteditable,
      onClick: onClick,
      innerText: innerText,
    );
  }

  @override
  isConfigurationChanged(oldConfiguration) {
    oldConfiguration as MarkUpGlobalConfiguration;

    return id != oldConfiguration.id ||
        title != oldConfiguration.title ||
        tabIndex != oldConfiguration.tabIndex ||
        style != oldConfiguration.style ||
        classAttribute != oldConfiguration.classAttribute ||
        dataAttributes != oldConfiguration.dataAttributes ||
        hidden != oldConfiguration.hidden ||
        draggable != oldConfiguration.draggable ||
        contenteditable != oldConfiguration.contentEditable ||
        onClick != oldConfiguration.onClick ||
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
  final String? id;
  final String? title;
  final String? style;
  final int? tabIndex;
  final bool? draggable;
  final bool? contentEditable;
  final bool? hidden;
  final String? onClick;
  final String? innerText;

  final String? classAttribute;
  final Map<String, String>? dataAttributes;

  const MarkUpGlobalConfiguration({
    this.id,
    this.title,
    this.tabIndex,
    this.style,
    this.classAttribute,
    this.dataAttributes,
    this.hidden,
    this.draggable,
    this.contentEditable,
    this.onClick,
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

  /*
  |--------------------------------------------------------------------------
  | lifecycle hooks
  |--------------------------------------------------------------------------
  */

  @override
  render({
    required configuration,
  }) {
    configuration as MarkUpGlobalConfiguration;

    var attributes = _prepareAttributes(
      props: configuration,
      oldProps: null,
    );

    var classes = fnCommonPrepareClasses(
      classAttribute: configuration.classAttribute,
      oldClassAttribute: null,
    );

    var dataset = fnCommonPrepareDataset(
      dataAttributes: configuration.dataAttributes,
      oldDataAttributes: null,
    );

    return ElementDescription(
      classes: classes,
      dataset: dataset,
      attributes: attributes,
      textContents: configuration.innerText,
    );
  }

  @override
  update({
    required updateType,
    required oldConfiguration,
    required newConfiguration,
  }) {
    oldConfiguration as MarkUpGlobalConfiguration;
    newConfiguration as MarkUpGlobalConfiguration;

    var classes = fnCommonPrepareClasses(
      classAttribute: newConfiguration.classAttribute,
      oldClassAttribute: oldConfiguration.classAttribute,
    );

    var dataset = fnCommonPrepareDataset(
      dataAttributes: newConfiguration.dataAttributes,
      oldDataAttributes: oldConfiguration.dataAttributes,
    );

    var attributes = _prepareAttributes(
      props: newConfiguration,
      oldProps: oldConfiguration,
    );

    return ElementDescription(
      classes: classes,
      dataset: dataset,
      attributes: attributes,
      textContents: newConfiguration.innerText,
    );
  }
}

/*
|--------------------------------------------------------------------------
| props
|--------------------------------------------------------------------------
*/

Map<String, String?> _prepareAttributes({
  required MarkUpGlobalConfiguration props,
  required MarkUpGlobalConfiguration? oldProps,
}) {
  var attributes = <String, String?>{};

  if (null != props.id) {
    attributes[Attributes.id] = props.id;
  } else {
    if (null != oldProps?.id) {
      attributes[Attributes.id] = null;
    }
  }

  if (null != props.title) {
    attributes[Attributes.title] = props.title;
  } else {
    if (null != oldProps?.title) {
      attributes[Attributes.title] = null;
    }
  }

  if (null != props.style) {
    attributes[Attributes.style] = props.style;
  } else {
    if (null != oldProps?.style) {
      attributes[Attributes.style] = null;
    }
  }

  if (null != props.tabIndex) {
    attributes[Attributes.tabIndex] = '${props.tabIndex}';
  } else {
    if (null != oldProps?.tabIndex) {
      attributes[Attributes.tabIndex] = null;
    }
  }

  if (null != props.hidden && props.hidden!) {
    attributes[Attributes.hidden] = '${props.hidden}';
  } else {
    if (null != oldProps?.hidden) {
      attributes[Attributes.hidden] = null;
    }
  }

  if (null != props.draggable) {
    attributes[Attributes.draggable] = '${props.draggable}';
  } else {
    if (null != oldProps?.draggable) {
      attributes[Attributes.draggable] = null;
    }
  }

  if (null != props.contentEditable) {
    attributes[Attributes.contentEditable] = '${props.contentEditable}';
  } else {
    if (null != oldProps?.contentEditable) {
      attributes[Attributes.contentEditable] = null;
    }
  }

  if (null != props.onClick) {
    attributes[Attributes.onClick] = props.onClick;
  } else {
    if (null != oldProps?.onClick) {
      attributes[Attributes.onClick] = null;
    }
  }

  return attributes;
}
