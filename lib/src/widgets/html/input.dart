import 'package:meta/meta.dart';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/markup_tag_with_global_props.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The Input widget (HTML's `input` tag).
///
class Input extends MarkUpTagWithGlobalProps {
  /// Type of input tag.
  ///
  final InputType? type;

  /// Name of the input. It's very common to use same name as key
  /// for inputs.
  ///
  final String? name;

  /// Initial value of control.
  ///
  final String? value;

  /// Defines the file types the file input should accept.
  ///
  final String? accept;

  /// Min length of input.
  ///
  final int? minLength;

  /// Max length of input.
  ///
  final int? maxLength;

  /// Match pattern for input.
  ///
  final String? pattern;

  /// Custom placeholder.
  ///
  final String? placeholder;

  /// Allows the user to select more than one file.
  ///
  final bool? multiple;

  /// Whether control is required.
  ///
  final bool? required;

  /// Whether control is disabled.
  ///
  final bool? disabled;

  /// Whether control is read only.
  ///
  final bool? readOnly;

  /// Whether control is checked.
  ///
  final bool? checked;

  const Input({
    this.type,
    this.name,
    this.value,
    this.accept,
    this.maxLength,
    this.minLength,
    this.pattern,
    this.placeholder,
    this.multiple,
    this.required,
    this.checked,
    this.readOnly,
    this.disabled,
    Key? key,
    String? id,
    String? title,
    String? style,
    String? classAttribute,
    int? tabIndex,
    bool? draggable,
    bool? contenteditable,
    Map<String, String>? dataAttributes,
    bool? hidden,
    String? onClickAttribute,
    String? innerText,
    Widget? child,
    List<Widget>? children,
    EventCallback? onInput,
    EventCallback? onChange,
    EventCallback? onClick,
    EventCallback? onKeyUp,
    EventCallback? onKeyDown,
    EventCallback? onKeyPress,
  }) : super(
          key: key,
          id: id,
          title: title,
          style: style,
          classAttribute: classAttribute,
          tabIndex: tabIndex,
          draggable: draggable,
          contenteditable: contenteditable,
          dataAttributes: dataAttributes,
          hidden: hidden,
          onClickAttribute: onClickAttribute,
          innerText: innerText,
          child: child,
          children: children,
          onInput: onInput,
          onChange: onChange,
          onClick: onClick,
          onKeyUp: onKeyUp,
          onKeyDown: onKeyDown,
          onKeyPress: onKeyPress,
        );

  @nonVirtual
  @override
  DomTag get correspondingTag => DomTag.input;

  @nonVirtual
  @override
  String get widgetType => 'Input';

  @override
  createConfiguration() {
    return InputConfiguration(
      type: type,
      name: name,
      value: value,
      accept: accept,
      maxLength: maxLength,
      minLength: minLength,
      pattern: pattern,
      placeholder: placeholder,
      checked: checked,
      multiple: multiple,
      required: required,
      readOnly: readOnly,
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
        accept != oldConfiguration.accept ||
        minLength != oldConfiguration.minLength ||
        maxLength != oldConfiguration.maxLength ||
        pattern != oldConfiguration.pattern ||
        placeholder != oldConfiguration.placeholder ||
        multiple != oldConfiguration.multiple ||
        checked != oldConfiguration.checked ||
        required != oldConfiguration.required ||
        readOnly != oldConfiguration.readOnly ||
        disabled != oldConfiguration.disabled ||
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

  final int? minLength;
  final int? maxLength;

  final String? pattern;
  final String? placeholder;

  final bool? multiple;
  final bool? checked;
  final bool? required;
  final bool? readOnly;
  final bool? disabled;

  const InputConfiguration({
    this.type,
    this.name,
    this.value,
    this.accept,
    this.minLength,
    this.maxLength,
    this.pattern,
    this.placeholder,
    this.multiple,
    this.checked,
    this.readOnly,
    this.disabled,
    this.required,
    required this.globalConfiguration,
  });
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class InputRenderObject extends MarkUpGlobalRenderObject {
  const InputRenderObject(BuildContext context) : super(context);

  @override
  render({
    required configuration,
  }) {
    configuration as InputConfiguration;

    var elementDescription = super.render(
      configuration: configuration.globalConfiguration,
    );

    elementDescription?.attributes.addAll(
      _prepareAttributes(
        props: configuration,
        oldProps: null,
      ),
    );

    return elementDescription;
  }

  @override
  update({
    required updateType,
    required oldConfiguration,
    required newConfiguration,
  }) {
    oldConfiguration as InputConfiguration;
    newConfiguration as InputConfiguration;

    var elementDescription = super.update(
      updateType: updateType,
      oldConfiguration: oldConfiguration.globalConfiguration,
      newConfiguration: newConfiguration.globalConfiguration,
    );

    elementDescription?.attributes.addAll(
      _prepareAttributes(
        props: newConfiguration,
        oldProps: oldConfiguration,
      ),
    );

    return elementDescription;
  }
}

/*
|--------------------------------------------------------------------------
| props
|--------------------------------------------------------------------------
*/

Map<String, String?> _prepareAttributes({
  required InputConfiguration props,
  required InputConfiguration? oldProps,
}) {
  var attributes = <String, String?>{};

  if (null != props.type) {
    attributes[Attributes.type] = props.type!.nativeName;
  } else {
    if (null != oldProps?.type) {
      attributes[Attributes.type] = null;
    }
  }

  if (null != props.name) {
    attributes[Attributes.name] = props.name;
  } else {
    if (null != oldProps?.name) {
      attributes[Attributes.name] = null;
    }
  }

  if (null != props.value) {
    attributes[Attributes.value] = props.value;
  } else {
    if (null != oldProps?.value) {
      attributes[Attributes.value] = null;
    }
  }

  if (null != props.accept) {
    attributes[Attributes.accept] = props.accept;
  } else {
    if (null != oldProps?.accept) {
      attributes[Attributes.accept] = null;
    }
  }

  if (null != props.placeholder) {
    attributes[Attributes.placeholder] = props.placeholder;
  } else {
    if (null != oldProps?.placeholder) {
      attributes[Attributes.placeholder] = null;
    }
  }

  if (null != props.pattern) {
    attributes[Attributes.pattern] = props.pattern;
  } else {
    if (null != oldProps?.pattern) {
      attributes[Attributes.pattern] = null;
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

  if (null != props.multiple && props.multiple!) {
    attributes[Attributes.multiple] = '${props.multiple}';
  } else {
    if (null != oldProps?.multiple) {
      attributes[Attributes.multiple] = null;
    }
  }

  if (null != props.checked && props.checked!) {
    attributes[Attributes.checked] = '${props.checked}';
  } else {
    if (null != oldProps?.checked) {
      attributes[Attributes.checked] = null;
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
