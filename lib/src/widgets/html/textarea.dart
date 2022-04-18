import 'dart:html';

import 'package:rad/src/core/functions.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/foundation/common/build_context.dart';
import 'package:rad/src/core/foundation/common/render_object.dart';
import 'package:rad/src/core/types.dart';
import 'package:rad/src/widgets/abstract/markup_tag_with_global_props.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The TextArea widget (HTML's `textarea` tag).
///
/// This HTML element represents a multi-line plain-text editing control, useful
/// when you want to allow users to enter a sizeable amount of free-form
/// text, for example a comment on a review or feedback form.
///
class TextArea extends MarkUpTagWithGlobalProps {
  final String? name;

  final String? placeholder;

  final int? rows;
  final int? cols;
  final int? minLength;
  final int? maxLength;

  final bool? required;
  final bool? readOnly;
  final bool? disabled;

  final EventCallback? onChangeEventListener;

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
    this.onChangeEventListener,
    String? key,
    bool? hidden,
    bool? draggable,
    bool? contenteditable,
    int? tabIndex,
    String? title,
    String? style,
    String? classAttribute,
    Map<String, String>? dataAttributes,
    String? onClick,
    EventCallback? onClickEventListener,
    String? innerText,
    Widget? child,
    List<Widget>? children,
  }) : super(
          key: key,
          title: title,
          tabIndex: tabIndex,
          draggable: draggable,
          contenteditable: contenteditable,
          hidden: hidden,
          style: style,
          classAttribute: classAttribute,
          dataAttributes: dataAttributes,
          onClick: onClick,
          onClickEventListener: onClickEventListener,
          innerText: innerText,
          child: child,
          children: children,
        );

  @override
  get concreteType => "$TextArea";

  @override
  get correspondingTag => DomTag.textArea;

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
      onChange: onChangeEventListener,
      globalConfiguration:
          super.createConfiguration() as MarkUpGlobalConfiguration,
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
        onChangeEventListener != oldConfiguration.onChange ||
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
  final MarkUpGlobalConfiguration globalConfiguration;

  final String? name;

  final String? placeholder;

  final int? rows;
  final int? cols;
  final int? minLength;
  final int? maxLength;

  final bool? required;

  final bool? readOnly;

  final bool? disabled;

  final EventCallback? onChange;

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
    this.onChange,
    required this.globalConfiguration,
  });
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class _TextAreaRenderObject extends RenderObject {
  const _TextAreaRenderObject(BuildContext context) : super(context);

  @override
  render(
    element,
    covariant _TextAreaConfiguration configuration,
  ) {
    _TextAreaProps.apply(element, configuration);
  }

  @override
  update({
    required element,
    required updateType,
    required covariant _TextAreaConfiguration oldConfiguration,
    required covariant _TextAreaConfiguration newConfiguration,
  }) {
    _TextAreaProps.clear(element, oldConfiguration);
    _TextAreaProps.apply(element, newConfiguration);
  }
}

/*
|--------------------------------------------------------------------------
| props
|--------------------------------------------------------------------------
*/

class _TextAreaProps {
  static void apply(HtmlElement element, _TextAreaConfiguration props) {
    element as TextAreaElement;

    MarkUpGlobalProps.apply(element, props.globalConfiguration);

    if (null != props.name) {
      element.name = props.name!;
    }

    if (null != props.placeholder) {
      element.placeholder = props.placeholder!;
    }

    if (null != props.rows) {
      element.rows = props.rows!;
    }

    if (null != props.cols) {
      element.cols = props.cols!;
    }

    if (null != props.minLength) {
      element.minLength = props.minLength!;
    }

    if (null != props.maxLength) {
      element.maxLength = props.maxLength!;
    }

    if (null != props.required) {
      element.required = props.required!;
    }

    if (null != props.readOnly) {
      element.readOnly = props.readOnly!;
    }

    if (null != props.disabled) {
      element.disabled = props.disabled!;
    }

    if (null != props.onChange) {
      element.addEventListener(
        fnMapDomEventType(DomEventType.input),
        props.onChange,
      );
    }
  }

  static void clear(HtmlElement element, _TextAreaConfiguration props) {
    element as TextAreaElement;

    MarkUpGlobalProps.clear(element, props.globalConfiguration);

    if (null != props.name) {
      element.removeAttribute(_Attributes.name);
    }

    if (null != props.placeholder) {
      element.removeAttribute(_Attributes.placeholder);
    }

    if (null != props.rows) {
      element.removeAttribute(_Attributes.rows);
    }

    if (null != props.cols) {
      element.removeAttribute(_Attributes.cols);
    }

    if (null != props.minLength) {
      element.removeAttribute(_Attributes.minLength);
    }

    if (null != props.maxLength) {
      element.removeAttribute(_Attributes.maxLength);
    }

    if (null != props.required) {
      element.removeAttribute(_Attributes.required);
    }

    if (null != props.readOnly) {
      element.removeAttribute(_Attributes.readOnly);
    }

    if (null != props.disabled) {
      element.removeAttribute(_Attributes.disabled);
    }

    if (null != props.onChange) {
      element.removeEventListener(
        fnMapDomEventType(DomEventType.input),
        props.onChange,
      );
    }
  }
}

class _Attributes {
  static const name = "name";
  static const placeholder = "placeholder";
  static const required = "required";
  static const readOnly = "selected";
  static const disabled = "disabled";

  static const rows = "rows";
  static const cols = "cols";
  static const minLength = "minlenth";
  static const maxLength = "maxlength";
}
