import 'dart:html';

import 'package:rad/rad.dart';
import 'package:rad/src/widgets/abstract/input_tag.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

class InputCheckBox extends InputTag {
  /// Whether check box is checked.
  ///
  final bool? checked;

  /// when checkbox changes
  ///
  final OnInputChangeCallback? onChange;

  const InputCheckBox({
    this.checked,
    this.onChange,
    bool isPassword = false,
    String? id,
    String? name,
    String? value,
    bool? required,
    bool? disabled,
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
          type: "checkbox",
          name: name,
          value: value,
          disabled: disabled,
          required: required,
          title: title,
          classAttribute: classAttribute,
          tabIndex: tabIndex,
          draggable: draggable,
          contenteditable: contenteditable,
          dataAttributes: dataAttributes,
          hidden: hidden,
          children: children,
        );

  @override
  get concreteType => "$InputCheckBox";

  @override
  createConfiguration() {
    return _InputCheckBoxConfiguration(
      checked: checked,
      onChange: onChange,
      inputConfiguration: super.createConfiguration() as InputConfiguration,
    );
  }

  @override
  isConfigurationChanged(oldConfiguration) {
    oldConfiguration as _InputCheckBoxConfiguration;

    return checked != oldConfiguration.checked ||
        onChange.runtimeType != oldConfiguration.onChange.runtimeType ||
        super.isConfigurationChanged(oldConfiguration.inputConfiguration);
  }

  @override
  createRenderObject(context) => _InputCheckBoxRenderObject(context);
}

/*
|--------------------------------------------------------------------------
| configuration
|--------------------------------------------------------------------------
*/

class _InputCheckBoxConfiguration extends WidgetConfiguration {
  final InputConfiguration inputConfiguration;

  final bool? checked;

  final OnInputChangeCallback? onChange;

  const _InputCheckBoxConfiguration({
    this.checked,
    this.onChange,
    required this.inputConfiguration,
  });
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class _InputCheckBoxRenderObject extends RenderObject {
  const _InputCheckBoxRenderObject(BuildContext context) : super(context);

  @override
  render(
    element,
    covariant _InputCheckBoxConfiguration configuration,
  ) {
    _InputCheckBoxProps.apply(element, configuration);
  }

  @override
  update({
    required element,
    required updateType,
    required covariant _InputCheckBoxConfiguration oldConfiguration,
    required covariant _InputCheckBoxConfiguration newConfiguration,
  }) {
    _InputCheckBoxProps.clear(element, oldConfiguration);
    _InputCheckBoxProps.apply(element, newConfiguration);
  }
}

/*
|--------------------------------------------------------------------------
| props
|--------------------------------------------------------------------------
*/

class _InputCheckBoxProps {
  static void apply(HtmlElement element, _InputCheckBoxConfiguration props) {
    element as InputElement;

    InputProps.apply(element, props.inputConfiguration);

    if (null != props.checked) {
      element.checked = props.checked;
    }

    if (null != props.onChange) {
      element.addEventListener("change", props.onChange);
    }
  }

  static void clear(HtmlElement element, _InputCheckBoxConfiguration props) {
    element as InputElement;

    InputProps.clear(element, props.inputConfiguration);

    if (null != props.checked) {
      element.removeAttribute(_Attributes.checked);
    }

    if (null != props.onChange) {
      element.removeEventListener("change", props.onChange);
    }
  }
}

class _Attributes {
  static const checked = "checked";
}
