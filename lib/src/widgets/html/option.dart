import 'package:meta/meta.dart';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/html_widget_base.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The Option widget (HTML's `option` tag).
///
class Option extends HTMLWidgetBase {
  /// The content of this attribute represents the value
  /// to be submitted with the form
  ///
  final String? value;

  /// This attribute is text for the label indicating the meaning
  /// of the option. If the label attribute isn't defined, its value
  /// is that of the dom node text content.
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
  String get widgetType => 'Option';

  @override
  DomTagType get correspondingTag => DomTagType.option;

  @override
  createConfiguration() {
    return _OptionConfiguration(
      value: value,
      label: label,
      selected: selected,
      disabled: disabled,
      globalConfiguration:
          super.createConfiguration() as HTMLWidgetBaseConfiguration,
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
  final HTMLWidgetBaseConfiguration globalConfiguration;

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

class _OptionRenderObject extends MarkUpGlobalRenderObject {
  const _OptionRenderObject(BuildContext context) : super(context);

  @override
  render({
    required covariant _OptionConfiguration configuration,
  }) {
    var domNodeDescription = super.render(
      configuration: configuration.globalConfiguration,
    );

    domNodeDescription?.attributes?.addAll(
      _prepareAttributes(
        props: configuration,
        oldProps: null,
      ),
    );

    return domNodeDescription;
  }

  @override
  update({
    required updateType,
    required covariant _OptionConfiguration oldConfiguration,
    required covariant _OptionConfiguration newConfiguration,
  }) {
    var domNodeDescription = super.update(
      updateType: updateType,
      oldConfiguration: oldConfiguration.globalConfiguration,
      newConfiguration: newConfiguration.globalConfiguration,
    );

    domNodeDescription?.attributes?.addAll(
      _prepareAttributes(
        props: newConfiguration,
        oldProps: oldConfiguration,
      ),
    );

    return domNodeDescription;
  }
}

/*
|--------------------------------------------------------------------------
| props
|--------------------------------------------------------------------------
*/

Map<String, String?> _prepareAttributes({
  required _OptionConfiguration props,
  required _OptionConfiguration? oldProps,
}) {
  var attributes = <String, String?>{};

  if (null != props.value) {
    attributes[Attributes.value] = props.value;
  } else {
    if (null != oldProps?.value) {
      attributes[Attributes.value] = null;
    }
  }

  if (null != props.label) {
    attributes[Attributes.label] = props.label;
  } else {
    if (null != oldProps?.label) {
      attributes[Attributes.label] = null;
    }
  }

  if (null != props.selected && props.selected!) {
    attributes[Attributes.selected] = '${props.selected}';
  } else {
    if (null != oldProps?.selected) {
      attributes[Attributes.selected] = null;
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
