import 'dart:html';

import 'package:meta/meta.dart';
import 'package:rad/src/core/classes/utils.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/types.dart';
import 'package:rad/src/widgets/abstract/markup_tag_with_global_props.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

abstract class InputTag extends MarkUpTagWithGlobalProps {
  /// Type of input tag.
  final InputType? type;

  /// Name of the input. It's very common to use same name as [key]
  /// for inputs.
  ///
  final String? name;

  /// Initial value of control.
  ///
  final String? value;

  /// Defines the file types the file input should accept.
  ///
  final String? accept;

  /// Allows the user to select more than one file.
  ///
  final bool? multiple;

  /// Whether control is required.
  ///
  final bool? required;

  /// Whether control is disabled.
  ///
  final bool? disabled;

  /// Whether control is checked.
  ///
  final bool? checked;

  /// Overloaded.
  ///
  /// 1. if [type] is "submit", this is "onClick" event
  /// 2. if [type] is "text", this is "onInput" event
  /// 3. if [type] is "checkbox" or "radio", this is "onChange" event
  ///
  final EventCallback? eventCallback;

  const InputTag({
    this.type,
    this.name,
    this.value,
    this.accept,
    this.multiple,
    this.required,
    this.checked,
    this.disabled,
    this.eventCallback,
    String? key,
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
      multiple: multiple,
      required: required,
      disabled: disabled,
      eventCallback: eventCallback,
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
        multiple != oldConfiguration.multiple ||
        checked != oldConfiguration.checked ||
        required != oldConfiguration.required ||
        disabled != oldConfiguration.disabled ||
        eventCallback.runtimeType !=
            oldConfiguration.eventCallback.runtimeType ||
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

  final InputType? type;

  final String? name;
  final String? value;
  final String? accept;
  final bool? multiple;
  final bool? checked;
  final bool? required;
  final bool? disabled;
  final EventCallback? eventCallback;

  const InputConfiguration({
    this.type,
    this.name,
    this.value,
    this.accept,
    this.multiple,
    this.checked,
    this.disabled,
    this.required,
    this.eventCallback,
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
  static DomEventType getRequiredEventType(InputType inputType) {
    switch (inputType) {
      case InputType.submit:
        return DomEventType.click;

      case InputType.radio:
      case InputType.checkbox:
        return DomEventType.change;

      case InputType.text:
      case InputType.password:
      default:
        return DomEventType.input;
    }
  }

  static void apply(HtmlElement element, InputConfiguration props) {
    element as InputElement;

    MarkUpGlobalProps.apply(element, props.globalConfiguration);

    if (null != props.type) {
      element.type = Utils.mapInputType(props.type!);
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

    if (null != props.multiple) {
      element.multiple = props.multiple;
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

    if (null != props.eventCallback) {
      var eventType = getRequiredEventType(props.type!);

      element.addEventListener(
        Utils.mapDomEventType(eventType),
        props.eventCallback,
      );
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

    if (null != props.multiple) {
      element.removeAttribute(_Attributes.multiple);
    }

    if (null != props.disabled) {
      element.removeAttribute(_Attributes.disabled);
    }

    if (null != props.required) {
      element.removeAttribute(_Attributes.required);
    }

    if (null != props.eventCallback) {
      var eventType = getRequiredEventType(props.type!);

      element.removeEventListener(
        Utils.mapDomEventType(eventType),
        props.eventCallback,
      );
    }
  }
}

class _Attributes {
  static const type = "type";
  static const name = "name";
  static const value = "value";
  static const accept = "accept";
  static const multiple = "multiple";
  static const disabled = "disabled";
  static const required = "required";
  static const checked = "checked";
}
