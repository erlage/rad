import 'dart:html';

import 'package:meta/meta.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/types.dart';
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

  /// Defines the file types the file input should accept.
  ///
  final String? accept;

  /// Whether control is required.
  ///
  final bool? required;

  /// Whether control is disabled.
  ///
  final bool? disabled;

  /// Whether control is checked.
  ///
  final bool? checked;

  /// when checkbox changes
  ///
  final OnInputChangeCallback? onChange;

  const InputTag({
    this.type,
    this.name,
    this.value,
    this.accept,
    this.required,
    this.checked,
    this.disabled,
    this.onChange,
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
      accept: accept,
      required: required,
      disabled: disabled,
      onChange: onChange,
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
        accept != oldConfiguration.accept ||
        checked != oldConfiguration.checked ||
        required != oldConfiguration.required ||
        disabled != oldConfiguration.disabled ||
        onChange.runtimeType != oldConfiguration.onChange.runtimeType ||
        super.isConfigurationChanged(oldConfiguration.globalConfiguration);
  }

  @override
  createRenderObject(context) => InputRenderObject(context);
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
  final String? accept;
  final bool? checked;
  final bool? required;
  final bool? disabled;
  final OnInputChangeCallback? onChange;

  const InputConfiguration({
    this.type,
    this.name,
    this.value,
    this.accept,
    this.checked,
    this.disabled,
    this.required,
    this.onChange,
    required this.globalConfiguration,
  });
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class InputRenderObject extends RenderObject {
  const InputRenderObject(BuildContext context) : super(context);

  @override
  render(
    element,
    covariant InputConfiguration configuration,
  ) {
    InputProps.apply(element, configuration);
  }

  @override
  update({
    required element,
    required updateType,
    required covariant InputConfiguration oldConfiguration,
    required covariant InputConfiguration newConfiguration,
  }) {
    InputProps.clear(element, oldConfiguration);
    InputProps.apply(element, newConfiguration);
  }
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

    if (null != props.accept) {
      element.accept = props.accept;
    }

    if (null != props.checked) {
      element.checked = props.checked;
    }

    if (null != props.disabled) {
      element.disabled = props.disabled;
    }

    if (null != props.required) {
      element.required = props.required!;
    }

    if (null != props.onChange) {
      element.addEventListener("input", props.onChange);
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

    if (null != props.checked) {
      element.removeAttribute(_Attributes.checked);
    }

    if (null != props.accept) {
      element.removeAttribute(_Attributes.accept);
    }

    if (null != props.disabled) {
      element.removeAttribute(_Attributes.disabled);
    }

    if (null != props.required) {
      element.removeAttribute(_Attributes.required);
    }

    if (null != props.onChange) {
      element.removeEventListener("input", props.onChange);
    }
  }
}

class _Attributes {
  static const type = "type";
  static const name = "name";
  static const value = "value";
  static const accept = "accept";
  static const disabled = "disabled";
  static const required = "required";
  static const checked = "checked";
}
