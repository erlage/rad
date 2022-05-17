import 'package:meta/meta.dart';

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/widgets/abstract/markup_tag_with_global_props.dart';

abstract class InputTag extends MarkUpTagWithGlobalProps {
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

  const InputTag({
    this.type,
    this.name,
    this.value,
    this.accept,
    this.multiple,
    this.required,
    this.checked,
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
    String? onClick,
    String? innerText,
    Widget? child,
    List<Widget>? children,
    EventCallback? onInputEventListener,
    EventCallback? onChangeEventListener,
    EventCallback? onSubmitEventListener,
    EventCallback? onClickEventListener,
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
          onClick: onClick,
          innerText: innerText,
          child: child,
          children: children,
          onInputEventListener: onInputEventListener,
          onChangeEventListener: onChangeEventListener,
          onSubmitEventListener: onSubmitEventListener,
          onClickEventListener: onClickEventListener,
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
      checked: checked,
      multiple: multiple,
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
        accept != oldConfiguration.accept ||
        multiple != oldConfiguration.multiple ||
        checked != oldConfiguration.checked ||
        required != oldConfiguration.required ||
        disabled != oldConfiguration.disabled ||
        super.isConfigurationChanged(oldConfiguration.globalConfiguration);
  }

  @override
  createRenderObject(context) => InputTagRenderObject(context);
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

  const InputConfiguration({
    this.type,
    this.name,
    this.value,
    this.accept,
    this.multiple,
    this.checked,
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

class InputTagRenderObject extends MarkUpGlobalRenderObject {
  InputTagRenderObject(BuildContext context) : super(context);

  @override
  render({
    required configuration,
  }) {
    configuration as InputConfiguration;

    var elementDescription = super.render(
      configuration: configuration.globalConfiguration,
    );

    elementDescription?.attributes.addAll(
      InputProps.prepareAttributes(
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
      InputProps.prepareAttributes(
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

class InputProps {
  static Map<String, String?> prepareAttributes({
    required InputConfiguration props,
    required InputConfiguration? oldProps,
  }) {
    var attributes = <String, String?>{};

    if (null != props.name) {
      attributes[Attributes.name] = props.name!;
    } else {
      if (null != oldProps?.name) {
        attributes[Attributes.name] = null;
      }
    }

    if (null != props.value) {
      attributes[Attributes.value] = props.value!;
    } else {
      if (null != oldProps?.value) {
        attributes[Attributes.value] = null;
      }
    }

    if (null != props.accept) {
      attributes[Attributes.accept] = props.accept!;
    } else {
      if (null != oldProps?.accept) {
        attributes[Attributes.accept] = null;
      }
    }

    if (null != props.multiple) {
      attributes[Attributes.multiple] = "${props.multiple}";
    } else {
      if (null != oldProps?.multiple) {
        attributes[Attributes.multiple] = null;
      }
    }

    if (null != props.checked) {
      attributes[Attributes.checked] = "${props.checked}";
    } else {
      if (null != oldProps?.checked) {
        attributes[Attributes.checked] = null;
      }
    }

    if (null != props.disabled && props.disabled!) {
      attributes[Attributes.disabled] = "${props.disabled}";
    } else {
      if (null != oldProps?.disabled) {
        attributes[Attributes.disabled] = null;
      }
    }

    if (null != props.required) {
      attributes[Attributes.required] = "${props.required}";
    } else {
      if (null != oldProps?.required) {
        attributes[Attributes.required] = null;
      }
    }

    return attributes;
  }
}
