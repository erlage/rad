import 'package:meta/meta.dart';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/html_widget_base.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The TextArea widget (HTML's `textarea` tag).
///
/// This HTML dom node represents a multi-line plain-text editing control,
/// useful when you want to allow users to enter a sizeable amount of free-form
/// text, for example a comment on a review or feedback form.
///
class TextArea extends HTMLWidgetBase {
  final String? name;

  final String? placeholder;

  final int? rows;
  final int? cols;
  final int? minLength;
  final int? maxLength;

  final bool? required;
  final bool? readOnly;
  final bool? disabled;

  /// On input event listener.
  ///
  final EventCallback? onInput;

  /// On change event listener.
  ///
  final EventCallback? onChange;

  /// On key up event listener.
  ///
  final EventCallback? onKeyUp;

  /// On key down event listener.
  ///
  final EventCallback? onKeyDown;

  /// On key press event listener.
  ///
  final EventCallback? onKeyPress;

  const TextArea({
    this.name,
    this.placeholder,
    this.rows,
    this.cols,
    this.minLength,
    this.maxLength,
    this.required,
    this.readOnly,
    this.disabled,
    this.onChange,
    this.onInput,
    this.onKeyUp,
    this.onKeyDown,
    this.onKeyPress,
    Key? key,
    String? id,
    bool? hidden,
    bool? draggable,
    bool? contenteditable,
    int? tabIndex,
    String? title,
    String? style,
    String? classAttribute,
    Map<String, String>? dataAttributes,
    String? onClickAttribute,
    String? innerText,
    Widget? child,
    List<Widget>? children,
    EventCallback? onClick,
  }) : super(
          key: key,
          id: id,
          title: title,
          tabIndex: tabIndex,
          draggable: draggable,
          contenteditable: contenteditable,
          hidden: hidden,
          style: style,
          classAttribute: classAttribute,
          dataAttributes: dataAttributes,
          onClickAttribute: onClickAttribute,
          innerText: innerText,
          child: child,
          children: children,
          onClick: onClick,
        );

  @nonVirtual
  @override
  String get widgetType => 'TextArea';

  @override
  DomTagType get correspondingTag => DomTagType.textArea;

  @override
  Map<DomEventType, EventCallback?> get widgetEventListeners => {
        DomEventType.click: onClick,
        DomEventType.input: onInput,
        DomEventType.change: onChange,
        DomEventType.keyUp: onKeyUp,
        DomEventType.keyDown: onKeyDown,
        DomEventType.keyPress: onKeyPress,
      };

  @override
  createConfiguration() {
    return _TextAreaConfiguration(
      name: name,
      placeholder: placeholder,
      rows: rows,
      cols: cols,
      minLength: minLength,
      maxLength: maxLength,
      required: required,
      readOnly: readOnly,
      disabled: disabled,
      globalConfiguration:
          super.createConfiguration() as HTMLWidgetBaseConfiguration,
    );
  }

  @override
  isConfigurationChanged(covariant _TextAreaConfiguration oldConfiguration) {
    return name != oldConfiguration.name ||
        placeholder != oldConfiguration.placeholder ||
        rows != oldConfiguration.rows ||
        cols != oldConfiguration.cols ||
        minLength != oldConfiguration.minLength ||
        maxLength != oldConfiguration.maxLength ||
        required != oldConfiguration.required ||
        readOnly != oldConfiguration.readOnly ||
        disabled != oldConfiguration.disabled ||
        super.isConfigurationChanged(oldConfiguration.globalConfiguration);
  }

  @override
  createRenderObject(context) => _TextAreaRenderObject(context);
}

/*
|--------------------------------------------------------------------------
| configuration
|--------------------------------------------------------------------------
*/

class _TextAreaConfiguration extends WidgetConfiguration {
  final HTMLWidgetBaseConfiguration globalConfiguration;

  final String? name;
  final String? placeholder;

  final int? rows;
  final int? cols;
  final int? minLength;
  final int? maxLength;

  final bool? required;
  final bool? readOnly;
  final bool? disabled;

  const _TextAreaConfiguration({
    this.name,
    this.placeholder,
    this.rows,
    this.cols,
    this.minLength,
    this.maxLength,
    this.required,
    this.readOnly,
    this.disabled,
    required this.globalConfiguration,
  });
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class _TextAreaRenderObject extends MarkUpGlobalRenderObject {
  const _TextAreaRenderObject(BuildContext context) : super(context);

  @override
  render({
    required covariant _TextAreaConfiguration configuration,
  }) {
    var domNodeDescription = super.render(
      configuration: configuration.globalConfiguration,
    );

    domNodeDescription?.attributes?.addAll(
      _prepareAttributes(
        props: configuration,
        oldProps: null,
      ),
    );

    return domNodeDescription;
  }

  @override
  update({
    required updateType,
    required covariant _TextAreaConfiguration oldConfiguration,
    required covariant _TextAreaConfiguration newConfiguration,
  }) {
    var domNodeDescription = super.update(
      updateType: updateType,
      oldConfiguration: oldConfiguration.globalConfiguration,
      newConfiguration: newConfiguration.globalConfiguration,
    );

    domNodeDescription?.attributes?.addAll(
      _prepareAttributes(
        props: newConfiguration,
        oldProps: oldConfiguration,
      ),
    );

    return domNodeDescription;
  }
}

/*
|--------------------------------------------------------------------------
| props
|--------------------------------------------------------------------------
*/

Map<String, String?> _prepareAttributes({
  required _TextAreaConfiguration props,
  required _TextAreaConfiguration? oldProps,
}) {
  var attributes = <String, String?>{};

  if (null != props.name) {
    attributes[Attributes.name] = props.name;
  } else {
    if (null != oldProps?.name) {
      attributes[Attributes.name] = null;
    }
  }

  if (null != props.placeholder) {
    attributes[Attributes.placeholder] = props.placeholder;
  } else {
    if (null != oldProps?.placeholder) {
      attributes[Attributes.placeholder] = null;
    }
  }

  if (null != props.rows) {
    attributes[Attributes.rows] = '${props.rows}';
  } else {
    if (null != oldProps?.rows) {
      attributes[Attributes.rows] = null;
    }
  }

  if (null != props.cols) {
    attributes[Attributes.cols] = '${props.cols}';
  } else {
    if (null != oldProps?.cols) {
      attributes[Attributes.cols] = null;
    }
  }

  if (null != props.minLength) {
    attributes[Attributes.minLength] = '${props.minLength}';
  } else {
    if (null != oldProps?.minLength) {
      attributes[Attributes.minLength] = null;
    }
  }

  if (null != props.maxLength) {
    attributes[Attributes.maxLength] = '${props.maxLength}';
  } else {
    if (null != oldProps?.maxLength) {
      attributes[Attributes.maxLength] = null;
    }
  }

  if (null != props.required && props.required!) {
    attributes[Attributes.required] = '${props.required}';
  } else {
    if (null != oldProps?.required) {
      attributes[Attributes.required] = null;
    }
  }

  if (null != props.readOnly && props.readOnly!) {
    attributes[Attributes.readOnly] = '${props.readOnly}';
  } else {
    if (null != oldProps?.readOnly) {
      attributes[Attributes.readOnly] = null;
    }
  }

  if (null != props.disabled && props.disabled!) {
    attributes[Attributes.disabled] = '${props.disabled}';
  } else {
    if (null != oldProps?.disabled) {
      attributes[Attributes.disabled] = null;
    }
  }

  return attributes;
}
