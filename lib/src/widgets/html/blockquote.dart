import 'dart:html';

import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/types.dart';
import 'package:rad/src/widgets/abstract/markup_tag_with_global_props.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The Blockquote widget (HTML's `blockquote` tag).
///
class Blockquote extends MarkUpTagWithGlobalProps {
  /// A URL for the source of the quotation may be given using the cite attribute.
  ///
  final String? cite;

  const Blockquote({
    String? key,
    this.cite,
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
          hidden: hidden,
          style: style,
          classAttribute: classAttribute,
          contenteditable: contenteditable,
          dataAttributes: dataAttributes,
          onClick: onClick,
          onClickEventListener: onClickEventListener,
          innerText: innerText,
          child: child,
          children: children,
        );

  @override
  get concreteType => "$Blockquote";

  @override
  get correspondingTag => DomTag.blockquote;

  @override
  createConfiguration() {
    return _BlockquoteConfiguration(
      cite: cite,
      globalConfiguration:
          super.createConfiguration() as MarkUpGlobalConfiguration,
    );
  }

  @override
  isConfigurationChanged(covariant _BlockquoteConfiguration oldConfiguration) {
    return cite != oldConfiguration.cite ||
        super.isConfigurationChanged(oldConfiguration.globalConfiguration);
  }

  @override
  createRenderObject(context) => _BlockquoteRenderObject(context);
}

/*
|--------------------------------------------------------------------------
| configuration
|--------------------------------------------------------------------------
*/

class _BlockquoteConfiguration extends WidgetConfiguration {
  final MarkUpGlobalConfiguration globalConfiguration;

  final String? cite;

  const _BlockquoteConfiguration({
    this.cite,
    required this.globalConfiguration,
  });
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class _BlockquoteRenderObject extends RenderObject {
  const _BlockquoteRenderObject(BuildContext context) : super(context);

  @override
  render(
    element,
    covariant _BlockquoteConfiguration configuration,
  ) {
    _BlockquoteProps.apply(element, configuration);
  }

  @override
  update({
    required element,
    required updateType,
    required covariant _BlockquoteConfiguration oldConfiguration,
    required covariant _BlockquoteConfiguration newConfiguration,
  }) {
    _BlockquoteProps.clear(element, oldConfiguration);
    _BlockquoteProps.apply(element, newConfiguration);
  }
}

/*
|--------------------------------------------------------------------------
| props
|--------------------------------------------------------------------------
*/

class _BlockquoteProps {
  static void apply(HtmlElement element, _BlockquoteConfiguration props) {
    element as QuoteElement;

    MarkUpGlobalProps.apply(element, props.globalConfiguration);

    if (null != props.cite) {
      element.cite = props.cite!;
    }
  }

  static void clear(HtmlElement element, _BlockquoteConfiguration props) {
    element as QuoteElement;

    MarkUpGlobalProps.clear(element, props.globalConfiguration);

    if (null != props.cite) {
      element.removeAttribute(_Attributes.cite);
    }
  }
}

class _Attributes {
  static const cite = "cite";
}
