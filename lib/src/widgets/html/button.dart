import 'dart:html';

import 'package:rad/src/core/classes/utils.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/types.dart';
import 'package:rad/src/widgets/abstract/markup_tag_with_global_props.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The Button tag.
///
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
  get concreteType => "$Button";

  @override
  get correspondingTag => DomTag.button;

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

class _ButtonRenderObject extends RenderObject {
  const _ButtonRenderObject(BuildContext context) : super(context);

  @override
  render(
    element,
    covariant _ButtonConfiguration configuration,
  ) {
    _ButtonProps.apply(element, configuration);
  }

  @override
  update({
    required element,
    required updateType,
    required covariant _ButtonConfiguration oldConfiguration,
    required covariant _ButtonConfiguration newConfiguration,
  }) {
    _ButtonProps.clear(element, oldConfiguration);
    _ButtonProps.apply(element, newConfiguration);
  }
}

/*
|--------------------------------------------------------------------------
| props
|--------------------------------------------------------------------------
*/

class _ButtonProps {
  static void apply(HtmlElement element, _ButtonConfiguration props) {
    element as ButtonElement;

    MarkUpGlobalProps.apply(element, props.globalConfiguration);

    if (null != props.name) {
      element.name = props.name!;
    }

    if (null != props.value) {
      element.value = props.value!;
    }

    if (null != props.type) {
      element.type = Utils.mapButtonType(props.type!);
    }

    if (null != props.disabled) {
      element.disabled = props.disabled!;
    }
  }

  static void clear(HtmlElement element, _ButtonConfiguration props) {
    element as ButtonElement;

    MarkUpGlobalProps.clear(element, props.globalConfiguration);

    if (null != props.name) {
      element.removeAttribute(_Attributes.name);
    }

    if (null != props.value) {
      element.removeAttribute(_Attributes.value);
    }

    if (null != props.type) {
      element.removeAttribute(_Attributes.type);
    }

    if (null != props.disabled) {
      element.removeAttribute(_Attributes.disabled);
    }
  }
}

class _Attributes {
  static const name = "name";
  static const value = "value";
  static const type = "type";
  static const disabled = "disabled";
}
