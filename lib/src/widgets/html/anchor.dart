import 'dart:html';

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/objects/render_object.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/markup_tag_with_global_props.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The Anchor widget (HTML's `a` tag).
///
class Anchor extends MarkUpTagWithGlobalProps {
  /// The URL that the hyperlink points to.
  ///
  final String? href;

  /// The relationship of the linked URL as space-separated link types.
  ///
  final String? rel;

  /// Where to display the linked URL.
  ///
  final String? target;

  /// Prompts the user to save the linked URL instead of navigating to it.
  /// Can be used with or without a value.
  ///
  final String? download;

  const Anchor({
    Key? key,
    this.href,
    this.rel,
    this.target,
    this.download,
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

  @nonVirtual
  @override
  get widgetType => "$Anchor";

  @override
  get correspondingTag => DomTag.anchor;

  @override
  createConfiguration() {
    return _AnchorConfiguration(
      href: href,
      rel: rel,
      target: target,
      download: download,
      globalConfiguration:
          super.createConfiguration() as MarkUpGlobalConfiguration,
    );
  }

  @override
  isConfigurationChanged(covariant _AnchorConfiguration oldConfiguration) {
    return href != oldConfiguration.href ||
        rel != oldConfiguration.rel ||
        target != oldConfiguration.target ||
        download != oldConfiguration.download ||
        super.isConfigurationChanged(oldConfiguration.globalConfiguration);
  }

  @override
  createRenderObject(context) => _AnchorRenderObject(context);
}

/*
|--------------------------------------------------------------------------
| configuration
|--------------------------------------------------------------------------
*/

class _AnchorConfiguration extends WidgetConfiguration {
  final MarkUpGlobalConfiguration globalConfiguration;

  final String? href;

  final String? rel;

  final String? target;

  final String? download;

  const _AnchorConfiguration({
    this.href,
    this.rel,
    this.target,
    this.download,
    required this.globalConfiguration,
  });
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class _AnchorRenderObject extends RenderObject {
  const _AnchorRenderObject(BuildContext context) : super(context);

  @override
  render(
    element,
    covariant _AnchorConfiguration configuration,
  ) {
    _AnchorProps.apply(element, configuration);
  }

  @override
  update({
    required element,
    required updateType,
    required covariant _AnchorConfiguration oldConfiguration,
    required covariant _AnchorConfiguration newConfiguration,
  }) {
    _AnchorProps.clear(element, oldConfiguration);
    _AnchorProps.apply(element, newConfiguration);
  }
}

/*
|--------------------------------------------------------------------------
| props
|--------------------------------------------------------------------------
*/

class _AnchorProps {
  static void apply(HtmlElement element, _AnchorConfiguration props) {
    element as AnchorElement;

    MarkUpGlobalProps.apply(element, props.globalConfiguration);

    if (null != props.href) {
      element.href = props.href;
    }

    if (null != props.download) {
      element.download = props.download;
    }

    if (null != props.rel) {
      element.rel = props.rel!;
    }

    if (null != props.target) {
      element.target = props.target!;
    }
  }

  static void clear(HtmlElement element, _AnchorConfiguration props) {
    element as AnchorElement;

    MarkUpGlobalProps.clear(element, props.globalConfiguration);

    if (null != props.rel) {
      element.removeAttribute(_Attributes.rel);
    }

    if (null != props.target) {
      element.removeAttribute(_Attributes.target);
    }

    if (null != props.href) {
      element.removeAttribute(_Attributes.href);
    }

    if (null != props.download) {
      element.removeAttribute(_Attributes.download);
    }
  }
}

class _Attributes {
  static const rel = "rel";
  static const target = "target";
  static const href = "href";
  static const download = "download";
}
