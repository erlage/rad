import 'package:meta/meta.dart';

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/widgets/abstract/input_tag.dart';
import 'package:rad/src/core/common/objects/build_context.dart';

/// The InputText widget (HTML's `input` tag with `type = 'text'`).
///
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
    Key? key,
    String? id,
    String? name,
    String? value,
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
    String? onClick,
    String? innerText,
    Widget? child,
    List<Widget>? children,
    EventCallback? onChangeEventListener,
    EventCallback? onClickEventListener,
  }) : super(
          key: key,
          id: id,
          type: isPassword ? InputType.password : InputType.text,
          name: name,
          value: value,
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
          onClick: onClick,
          onClickEventListener: onClickEventListener,
          innerText: innerText,
          child: child,
          children: children,
          onChangeEventListener: onChangeEventListener,
        );

  @nonVirtual
  @override
  get widgetType => '$InputText';

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

class _InputTextRenderObject extends InputTagRenderObject {
  _InputTextRenderObject(BuildContext context) : super(context);

  @override
  render({
    required covariant _InputTextConfiguration configuration,
  }) {
    var elementDescription = super.render(
      configuration: configuration.inputConfiguration,
    );

    elementDescription?.attributes.addAll(
      _InputTextProps.prepareAttributes(
        props: configuration,
        oldProps: null,
      ),
    );

    return elementDescription;
  }

  @override
  update({
    required updateType,
    required covariant _InputTextConfiguration oldConfiguration,
    required covariant _InputTextConfiguration newConfiguration,
  }) {
    var elementDescription = super.update(
      updateType: updateType,
      oldConfiguration: oldConfiguration.inputConfiguration,
      newConfiguration: newConfiguration.inputConfiguration,
    );

    elementDescription?.attributes.addAll(
      _InputTextProps.prepareAttributes(
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

class _InputTextProps {
  static Map<String, String?> prepareAttributes({
    required _InputTextConfiguration props,
    required _InputTextConfiguration? oldProps,
  }) {
    var attributes = <String, String?>{};

    if (null != props.placeholder) {
      attributes[Attributes.placeholder] = props.placeholder!;
    } else {
      if (null != oldProps?.placeholder) {
        attributes[Attributes.placeholder] = null;
      }
    }

    if (null != props.pattern) {
      attributes[Attributes.pattern] = props.pattern!;
    } else {
      if (null != oldProps?.pattern) {
        attributes[Attributes.pattern] = null;
      }
    }

    if (null != props.readOnly) {
      attributes[Attributes.readOnly] = '${props.readOnly}';
    } else {
      if (null != oldProps?.readOnly) {
        attributes[Attributes.readOnly] = null;
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

    return attributes;
  }
}
