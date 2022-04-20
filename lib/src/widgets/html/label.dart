import 'dart:html';

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/render_object.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/markup_tag_with_global_props.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/core/common/objects/key.dart';

/// The Label widget (HTML's `label` tag).
///
class Label extends MarkUpTagWithGlobalProps {
  /// The value of the [forAttribute] attribute must be a single key for a labelable
  /// form-related element in the same document as the <label> element.
  ///
  final String? forAttribute;

  const Label({
    Key? key,
    this.forAttribute,
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
  get concreteType => "$Label";

  @override
  get correspondingTag => DomTag.label;

  @override
  createConfiguration() {
    return _LabelConfiguration(
      forAttribute: forAttribute,
      globalConfiguration:
          super.createConfiguration() as MarkUpGlobalConfiguration,
    );
  }

  @override
  isConfigurationChanged(covariant _LabelConfiguration oldConfiguration) {
    return forAttribute != oldConfiguration.forAttribute ||
        super.isConfigurationChanged(oldConfiguration.globalConfiguration);
  }

  @override
  createRenderObject(context) => _LabelRenderObject(context);
}

/*
|--------------------------------------------------------------------------
| configuration
|--------------------------------------------------------------------------
*/

class _LabelConfiguration extends WidgetConfiguration {
  final MarkUpGlobalConfiguration globalConfiguration;

  final String? forAttribute;

  const _LabelConfiguration({
    this.forAttribute,
    required this.globalConfiguration,
  });
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class _LabelRenderObject extends RenderObject {
  const _LabelRenderObject(BuildContext context) : super(context);

  @override
  render(
    element,
    covariant _LabelConfiguration configuration,
  ) {
    _LabelProps.apply(element, configuration);
  }

  @override
  update({
    required element,
    required updateType,
    required covariant _LabelConfiguration oldConfiguration,
    required covariant _LabelConfiguration newConfiguration,
  }) {
    _LabelProps.clear(element, oldConfiguration);
    _LabelProps.apply(element, newConfiguration);
  }
}

/*
|--------------------------------------------------------------------------
| props
|--------------------------------------------------------------------------
*/

class _LabelProps {
  static void apply(HtmlElement element, _LabelConfiguration props) {
    element as LabelElement;

    MarkUpGlobalProps.apply(element, props.globalConfiguration);

    if (null != props.forAttribute) {
      element.htmlFor = props.forAttribute!;
    }
  }

  static void clear(HtmlElement element, _LabelConfiguration props) {
    element as LabelElement;

    MarkUpGlobalProps.clear(element, props.globalConfiguration);

    if (null != props.forAttribute) {
      element.removeAttribute(_Attributes.forAttribute);
    }
  }
}

class _Attributes {
  static const forAttribute = "for";
}
