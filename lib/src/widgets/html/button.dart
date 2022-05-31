import 'package:meta/meta.dart';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/markup_tag_with_global_props.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The Button widget (HTML's `button` tag).
///
class Button extends MarkUpTagWithGlobalProps {
  /// Associated Name.
  /// Used if Button is part of a form.
  ///
  final String? name;

  /// Value of Button.
  ///
  final String? value;

  /// Type of Button.
  ///
  final ButtonType? type;

  /// Whether Button is disabled.
  ///
  final bool? disabled;

  const Button({
    this.name,
    this.value,
    this.type,
    this.disabled,
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
  String get widgetType => 'Button';

  @override
  DomTag get correspondingTag => DomTag.button;

  @override
  createConfiguration() {
    return _ButtonConfiguration(
      name: name,
      value: value,
      type: type,
      disabled: disabled,
      globalConfiguration:
          super.createConfiguration() as MarkUpGlobalConfiguration,
    );
  }

  @override
  isConfigurationChanged(covariant _ButtonConfiguration oldConfiguration) {
    return name != oldConfiguration.name ||
        value != oldConfiguration.value ||
        type != oldConfiguration.type ||
        disabled != oldConfiguration.disabled ||
        super.isConfigurationChanged(oldConfiguration.globalConfiguration);
  }

  @override
  createRenderObject(context) => _ButtonRenderObject(context);
}

/*
|--------------------------------------------------------------------------
| configuration
|--------------------------------------------------------------------------
*/

class _ButtonConfiguration extends WidgetConfiguration {
  final MarkUpGlobalConfiguration globalConfiguration;

  final String? name;
  final String? value;

  final ButtonType? type;

  final bool? disabled;

  const _ButtonConfiguration({
    this.name,
    this.type,
    this.value,
    this.disabled,
    required this.globalConfiguration,
  });
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class _ButtonRenderObject extends MarkUpGlobalRenderObject {
  const _ButtonRenderObject(BuildContext context) : super(context);

  @override
  render({
    required covariant _ButtonConfiguration configuration,
  }) {
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
    required covariant _ButtonConfiguration oldConfiguration,
    required covariant _ButtonConfiguration newConfiguration,
  }) {
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
  required _ButtonConfiguration props,
  required _ButtonConfiguration? oldProps,
}) {
  var attributes = <String, String?>{};

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

  if (null != props.type) {
    attributes[Attributes.type] = props.type!.nativeName;
  } else {
    if (null != oldProps?.type) {
      attributes[Attributes.type] = null;
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
