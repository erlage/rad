import 'dart:html';

import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/types.dart';
import 'package:rad/src/widgets/abstract/input_tag.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

class InputText extends InputTag {
  final bool? readOnly;

  final int? minLength;
  final int? maxLength;

  final String? pattern;
  final String? placeholder;

  const InputText({
    this.readOnly,
    this.minLength,
    this.maxLength,
    this.pattern,
    this.placeholder,
    bool isPassword = false,
    String? key,
    String? name,
    String? value,
    EventCallback? onChange,
    bool? required,
    bool? disabled,
    String? title,
    String? style,
    String? classAttribute,
    int? tabIndex,
    bool? draggable,
    bool? contenteditable,
    Map<String, String>? dataAttributes,
    bool? hidden,
    List<Widget>? children,
  }) : super(
          key: key,
          type: isPassword ? InputType.password : InputType.text,
          name: name,
          value: value,
          eventListenerCallback: onChange,
          disabled: disabled,
          required: required,
          title: title,
          style: style,
          classAttribute: classAttribute,
          tabIndex: tabIndex,
          draggable: draggable,
          contenteditable: contenteditable,
          dataAttributes: dataAttributes,
          hidden: hidden,
          children: children,
        );

  @override
  get concreteType => "$InputText";

  @override
  createConfiguration() {
    return _InputTextConfiguration(
      readOnly: readOnly,
      minLength: minLength,
      maxLength: maxLength,
      pattern: pattern,
      placeholder: placeholder,
      inputConfiguration: super.createConfiguration() as InputConfiguration,
    );
  }

  @override
  isConfigurationChanged(oldConfiguration) {
    oldConfiguration as _InputTextConfiguration;

    return readOnly != oldConfiguration.readOnly ||
        minLength != oldConfiguration.minLength ||
        maxLength != oldConfiguration.maxLength ||
        pattern != oldConfiguration.pattern ||
        placeholder != oldConfiguration.placeholder ||
        super.isConfigurationChanged(oldConfiguration.inputConfiguration);
  }

  @override
  createRenderObject(context) => _InputTextRenderObject(context);
}

/*
|--------------------------------------------------------------------------
| configuration
|--------------------------------------------------------------------------
*/

class _InputTextConfiguration extends WidgetConfiguration {
  final InputConfiguration inputConfiguration;

  final bool? readOnly;

  final int? minLength;
  final int? maxLength;

  final String? pattern;
  final String? placeholder;

  const _InputTextConfiguration({
    this.readOnly,
    this.minLength,
    this.maxLength,
    this.pattern,
    this.placeholder,
    required this.inputConfiguration,
  });
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class _InputTextRenderObject extends RenderObject {
  const _InputTextRenderObject(BuildContext context) : super(context);

  @override
  render(
    element,
    covariant _InputTextConfiguration configuration,
  ) {
    _InputTextProps.apply(element, configuration);
  }

  @override
  update({
    required element,
    required updateType,
    required covariant _InputTextConfiguration oldConfiguration,
    required covariant _InputTextConfiguration newConfiguration,
  }) {
    _InputTextProps.clear(element, oldConfiguration);
    _InputTextProps.apply(element, newConfiguration);
  }
}

/*
|--------------------------------------------------------------------------
| props
|--------------------------------------------------------------------------
*/

class _InputTextProps {
  static void apply(HtmlElement element, _InputTextConfiguration props) {
    element as InputElement;

    InputProps.apply(element, props.inputConfiguration);

    if (null != props.readOnly) {
      element.readOnly = props.readOnly;
    }

    if (null != props.minLength) {
      element.minLength = props.minLength;
    }

    if (null != props.maxLength) {
      element.maxLength = props.maxLength;
    }

    if (null != props.pattern) {
      element.pattern = props.pattern!;
    }

    if (null != props.placeholder) {
      element.placeholder = props.placeholder!;
    }
  }

  static void clear(HtmlElement element, _InputTextConfiguration props) {
    element as InputElement;

    InputProps.clear(element, props.inputConfiguration);

    if (null != props.readOnly) {
      element.removeAttribute(_Attributes.readOnly);
    }

    if (null != props.minLength) {
      element.removeAttribute(_Attributes.minLength);
    }

    if (null != props.maxLength) {
      element.removeAttribute(_Attributes.maxLength);
    }

    if (null != props.pattern) {
      element.removeAttribute(_Attributes.pattern);
    }

    if (null != props.placeholder) {
      element.removeAttribute(_Attributes.placeholder);
    }
  }
}

class _Attributes {
  static const readOnly = "readonly";
  static const minLength = "minlength";
  static const maxLength = "maxlength";
  static const pattern = "pattern";
  static const placeholder = "placeholder";
}
