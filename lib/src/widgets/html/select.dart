import 'dart:html';

import 'package:rad/src/core/classes/utils.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/types.dart';
import 'package:rad/src/widgets/abstract/markup_tag_with_global_props.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The Select tag.
///
///
class Select extends MarkUpTagWithGlobalProps {
  /// Associated Name.
  /// Used if Select is part of a form.
  ///
  final String? name;

  /// This Boolean attribute indicates that multiple options
  /// can be selected in the list.
  ///
  final bool? multiple;

  /// Whether Select is disabled.
  ///
  final bool? disabled;

  /// When Select's value changes.
  ///
  final EventCallback? onChangeEventListener;

  const Select({
    this.name,
    this.multiple,
    this.disabled,
    this.onChangeEventListener,
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
  get concreteType => "$Select";

  @override
  get correspondingTag => DomTag.select;

  @override
  createConfiguration() {
    return _SelectConfiguration(
      name: name,
      multiple: multiple,
      disabled: disabled,
      onChange: onChangeEventListener,
      globalConfiguration:
          super.createConfiguration() as MarkUpGlobalConfiguration,
    );
  }

  @override
  isConfigurationChanged(covariant _SelectConfiguration oldConfiguration) {
    return name != oldConfiguration.name ||
        multiple != oldConfiguration.multiple ||
        disabled != oldConfiguration.disabled ||
        onChangeEventListener.runtimeType !=
            oldConfiguration.onChange.runtimeType ||
        super.isConfigurationChanged(oldConfiguration.globalConfiguration);
  }

  @override
  createRenderObject(context) => _SelectRenderObject(context);
}

/*
|--------------------------------------------------------------------------
| configuration
|--------------------------------------------------------------------------
*/

class _SelectConfiguration extends WidgetConfiguration {
  final MarkUpGlobalConfiguration globalConfiguration;

  final String? name;

  final bool? multiple;

  final bool? disabled;

  final EventCallback? onChange;

  const _SelectConfiguration({
    this.name,
    this.multiple,
    this.disabled,
    this.onChange,
    required this.globalConfiguration,
  });
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class _SelectRenderObject extends RenderObject {
  const _SelectRenderObject(BuildContext context) : super(context);

  @override
  render(
    element,
    covariant _SelectConfiguration configuration,
  ) {
    _SelectProps.apply(element, configuration);
  }

  @override
  update({
    required element,
    required updateType,
    required covariant _SelectConfiguration oldConfiguration,
    required covariant _SelectConfiguration newConfiguration,
  }) {
    _SelectProps.clear(element, oldConfiguration);
    _SelectProps.apply(element, newConfiguration);
  }
}

/*
|--------------------------------------------------------------------------
| props
|--------------------------------------------------------------------------
*/

class _SelectProps {
  static void apply(HtmlElement element, _SelectConfiguration props) {
    element as SelectElement;

    MarkUpGlobalProps.apply(element, props.globalConfiguration);

    if (null != props.name) {
      element.name = props.name;
    }

    if (null != props.multiple) {
      element.multiple = props.multiple;
    }

    if (null != props.disabled) {
      element.disabled = props.disabled!;
    }

    if (null != props.onChange) {
      element.addEventListener(
        Utils.mapDomEventType(DomEventType.change),
        props.onChange,
      );
    }
  }

  static void clear(HtmlElement element, _SelectConfiguration props) {
    element as SelectElement;

    MarkUpGlobalProps.clear(element, props.globalConfiguration);

    if (null != props.name) {
      element.removeAttribute(_Attributes.name);
    }

    if (null != props.multiple) {
      element.removeAttribute(_Attributes.multiple);
    }

    if (null != props.disabled) {
      element.removeAttribute(_Attributes.disabled);
    }

    if (null != props.onChange) {
      element.removeEventListener(
        Utils.mapDomEventType(DomEventType.change),
        props.onChange,
      );
    }
  }
}

class _Attributes {
  static const name = "name";
  static const multiple = "multiple";
  static const disabled = "disabled";
}
