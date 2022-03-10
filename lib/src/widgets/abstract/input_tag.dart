import 'dart:html';

import 'package:meta/meta.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/widgets/abstract/markup_tag_with_global_props.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

@immutable
abstract class InputTag extends MarkUpTagWithGlobalProps {
  /// Type of input tag.
  final String? type;

  /// Name of the input. It's very common to use same name as [id]
  /// for inputs.
  ///
  final String? name;

  /// Initial value of control.
  ///
  final String? value;

  /// Whether control is required.
  ///
  final bool? required;

  /// Whether control is disabled.
  ///
  final bool? disabled;

  const InputTag({
    this.type,
    this.name,
    this.value,
    this.required,
    this.disabled,
    String? id,
    String? title,
    String? classAttribute,
    int? tabIndex,
    bool? draggable,
    bool? contenteditable,
    Map<String, String>? dataAttributes,
    bool? hidden,
    List<Widget>? children,
  }) : super(
          id: id,
          title: title,
          classAttribute: classAttribute,
          tabIndex: tabIndex,
          draggable: draggable,
          contenteditable: contenteditable,
          dataAttributes: dataAttributes,
          hidden: hidden,
          children: children,
        );

  @nonVirtual
  @override
  DomTag get correspondingTag => DomTag.input;

  @override
  createConfiguration() {
    return InputConfiguration(
      type: type,
      name: name,
      value: value,
      required: required,
      disabled: disabled,
      globalConfiguration:
          super.createConfiguration() as MarkUpGlobalConfiguration,
    );
  }

  @override
  isConfigurationChanged(oldConfiguration) {
    oldConfiguration as InputConfiguration;

    return type != oldConfiguration.type ||
        name != oldConfiguration.name ||
        value != oldConfiguration.value ||
        required != oldConfiguration.required ||
        disabled != oldConfiguration.disabled ||
        super.isConfigurationChanged(oldConfiguration.globalConfiguration);
  }
}

/*
|--------------------------------------------------------------------------
| configuration
|--------------------------------------------------------------------------
*/

class InputConfiguration extends WidgetConfiguration {
  final MarkUpGlobalConfiguration globalConfiguration;

  final String? type;

  final String? name;
  final String? value;
  final bool? required;
  final bool? disabled;

  const InputConfiguration({
    this.type,
    this.name,
    this.value,
    this.disabled,
    this.required,
    required this.globalConfiguration,
  });
}

/*
|--------------------------------------------------------------------------
| props
|--------------------------------------------------------------------------
*/

class InputProps {
  static void apply(HtmlElement element, InputConfiguration props) {
    element as InputElement;

    MarkUpGlobalProps.apply(element, props.globalConfiguration);

    if (null != props.type) {
      element.type = props.type;
    }

    if (null != props.name) {
      element.name = props.name;
    }

    if (null != props.value) {
      element.value = props.value;
    }

    if (null != props.disabled) {
      element.disabled = props.disabled;
    }

    if (null != props.required) {
      element.required = props.required!;
    }
  }

  static void clear(HtmlElement element, InputConfiguration props) {
    element as InputElement;

    MarkUpGlobalProps.clear(element, props.globalConfiguration);

    if (null != props.type) {
      element.removeAttribute(_Attributes.type);
    }

    if (null != props.name) {
      element.removeAttribute(_Attributes.name);
    }

    if (null != props.value) {
      element.removeAttribute(_Attributes.value);
    }

    if (null != props.disabled) {
      element.removeAttribute(_Attributes.disabled);
    }

    if (null != props.required) {
      element.removeAttribute(_Attributes.required);
    }
  }
}

class _Attributes {
  static const type = "type";
  static const name = "name";
  static const value = "value";
  static const disabled = "disabled";
  static const required = "required";
}
