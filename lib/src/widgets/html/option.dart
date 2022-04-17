import 'dart:html';

import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/foundation/common/build_context.dart';
import 'package:rad/src/core/foundation/common/render_object.dart';
import 'package:rad/src/core/types.dart';
import 'package:rad/src/widgets/abstract/markup_tag_with_global_props.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The Option widget (HTML's `option` tag).
///
class Option extends MarkUpTagWithGlobalProps {
  /// he content of this attribute represents the value
  /// to be submitted with the form
  ///
  final String? value;

  /// This attribute is text for the label indicating the meaning
  /// of the option. If the label attribute isn't defined, its value
  /// is that of the element text content.
  ///
  final String? label;

  /// If present, this Boolean attribute indicates that the
  /// option is initially selected.
  ///
  final bool? selected;

  /// Whether Option is disabled.
  ///
  final bool? disabled;

  const Option({
    this.value,
    this.selected,
    this.disabled,
    this.label,
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
  get concreteType => "$Option";

  @override
  get correspondingTag => DomTag.option;

  @override
  createConfiguration() {
    return _OptionConfiguration(
      value: value,
      label: label,
      selected: selected,
      disabled: disabled,
      globalConfiguration:
          super.createConfiguration() as MarkUpGlobalConfiguration,
    );
  }

  @override
  isConfigurationChanged(covariant _OptionConfiguration oldConfiguration) {
    return value != oldConfiguration.value ||
        label != oldConfiguration.label ||
        selected != oldConfiguration.selected ||
        disabled != oldConfiguration.disabled ||
        super.isConfigurationChanged(oldConfiguration.globalConfiguration);
  }

  @override
  createRenderObject(context) => _OptionRenderObject(context);
}

/*
|--------------------------------------------------------------------------
| configuration
|--------------------------------------------------------------------------
*/

class _OptionConfiguration extends WidgetConfiguration {
  final MarkUpGlobalConfiguration globalConfiguration;

  final String? value;

  final String? label;

  final bool? selected;

  final bool? disabled;

  const _OptionConfiguration({
    this.value,
    this.selected,
    this.disabled,
    this.label,
    required this.globalConfiguration,
  });
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class _OptionRenderObject extends RenderObject {
  const _OptionRenderObject(BuildContext context) : super(context);

  @override
  render(
    element,
    covariant _OptionConfiguration configuration,
  ) {
    _OptionProps.apply(element, configuration);
  }

  @override
  update({
    required element,
    required updateType,
    required covariant _OptionConfiguration oldConfiguration,
    required covariant _OptionConfiguration newConfiguration,
  }) {
    _OptionProps.clear(element, oldConfiguration);
    _OptionProps.apply(element, newConfiguration);
  }
}

/*
|--------------------------------------------------------------------------
| props
|--------------------------------------------------------------------------
*/

class _OptionProps {
  static void apply(HtmlElement element, _OptionConfiguration props) {
    element as OptionElement;

    MarkUpGlobalProps.apply(element, props.globalConfiguration);

    if (null != props.value) {
      element.value = props.value!;
    }

    if (null != props.label) {
      element.label = props.label;
    }

    if (null != props.selected) {
      element.selected = props.selected!;
    }

    if (null != props.disabled) {
      element.disabled = props.disabled!;
    }
  }

  static void clear(HtmlElement element, _OptionConfiguration props) {
    element as OptionElement;

    MarkUpGlobalProps.clear(element, props.globalConfiguration);

    if (null != props.value) {
      element.removeAttribute(_Attributes.value);
    }

    if (null != props.label) {
      element.removeAttribute(_Attributes.label);
    }

    if (null != props.selected) {
      element.removeAttribute(_Attributes.selected);
    }

    if (null != props.disabled) {
      element.removeAttribute(_Attributes.disabled);
    }
  }
}

class _Attributes {
  static const value = "value";
  static const label = "label";
  static const selected = "selected";
  static const disabled = "disabled";
}
