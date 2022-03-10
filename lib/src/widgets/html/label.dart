import 'dart:html';

import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/widgets/abstract/markup_tag_with_global_props.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The Label tag.
///
class Label extends MarkUpTagWithGlobalProps {
  /// The value of the [forAttribute] attribute must be a single id for a labelable
  /// form-related element in the same document as the <label> element.
  ///
  final String? forAttribute;

  const Label({
    String? id,
    this.forAttribute,
    bool? hidden,
    bool? draggable,
    bool? contenteditable,
    int? tabIndex,
    String? title,
    String? classAttribute,
    Map<String, String>? dataAttributes,
    List<Widget>? children,
  }) : super(
          id: id,
          title: title,
          tabIndex: tabIndex,
          draggable: draggable,
          contenteditable: contenteditable,
          hidden: hidden,
          classAttribute: classAttribute,
          dataAttributes: dataAttributes,
          children: children,
        );

  @override
  String get concreteType => "$Label";

  @override
  DomTag get correspondingTag => DomTag.label;

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
      element.htmlFor = "";
    }
  }
}
