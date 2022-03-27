import 'dart:html';

import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/types.dart';
import 'package:rad/src/widgets/abstract/markup_tag_with_global_props.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The FieldSet widget (HTML's `fieldset` tag).
///
/// Group several controls as well as labels (<label>) within a web form.
///
class FieldSet extends MarkUpTagWithGlobalProps {
  /// Whether field set is disabled.
  ///
  final bool? disabled;

  const FieldSet({
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
  get concreteType => "$FieldSet";

  @override
  get correspondingTag => DomTag.fieldSet;

  @override
  createConfiguration() {
    return _FieldSetConfiguration(
      disabled: disabled,
      globalConfiguration:
          super.createConfiguration() as MarkUpGlobalConfiguration,
    );
  }

  @override
  isConfigurationChanged(covariant _FieldSetConfiguration oldConfiguration) {
    return disabled != oldConfiguration.disabled ||
        super.isConfigurationChanged(oldConfiguration.globalConfiguration);
  }

  @override
  createRenderObject(context) => _FieldSetRenderObject(context);
}

/*
|--------------------------------------------------------------------------
| configuration
|--------------------------------------------------------------------------
*/

class _FieldSetConfiguration extends WidgetConfiguration {
  final MarkUpGlobalConfiguration globalConfiguration;

  final bool? disabled;

  const _FieldSetConfiguration({
    this.disabled,
    required this.globalConfiguration,
  });
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class _FieldSetRenderObject extends RenderObject {
  const _FieldSetRenderObject(BuildContext context) : super(context);

  @override
  render(
    element,
    covariant _FieldSetConfiguration configuration,
  ) {
    _FieldSetProps.apply(element, configuration);
  }

  @override
  update({
    required element,
    required updateType,
    required covariant _FieldSetConfiguration oldConfiguration,
    required covariant _FieldSetConfiguration newConfiguration,
  }) {
    _FieldSetProps.clear(element, oldConfiguration);
    _FieldSetProps.apply(element, newConfiguration);
  }
}

/*
|--------------------------------------------------------------------------
| props
|--------------------------------------------------------------------------
*/

class _FieldSetProps {
  static void apply(HtmlElement element, _FieldSetConfiguration props) {
    element as FieldSetElement;

    MarkUpGlobalProps.apply(element, props.globalConfiguration);

    if (null != props.disabled) {
      element.disabled = props.disabled;
    }
  }

  static void clear(HtmlElement element, _FieldSetConfiguration props) {
    element as FieldSetElement;

    MarkUpGlobalProps.clear(element, props.globalConfiguration);

    if (null != props.disabled) {
      element.removeAttribute(_Attributes.disabled);
    }
  }
}

class _Attributes {
  static const disabled = "disabled";
}
