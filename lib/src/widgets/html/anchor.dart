import 'package:meta/meta.dart';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/key.dart';
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
    String? id,
    String? title,
    String? style,
    String? classAttribute,
    Map<String, String>? dataAttributes,
    String? onClick,
    String? innerText,
    Widget? child,
    List<Widget>? children,
    EventCallback? onClickEventListener,
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
          onClick: onClick,
          innerText: innerText,
          child: child,
          children: children,
          onClickEventListener: onClickEventListener,
        );

  @nonVirtual
  @override
  get widgetType => '$Anchor';

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

class _AnchorRenderObject extends MarkUpGlobalRenderObject {
  _AnchorRenderObject(BuildContext context) : super(context);

  @override
  render({
    required covariant _AnchorConfiguration configuration,
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
    required covariant _AnchorConfiguration oldConfiguration,
    required covariant _AnchorConfiguration newConfiguration,
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
  required _AnchorConfiguration props,
  required _AnchorConfiguration? oldProps,
}) {
  var attributes = <String, String?>{};

  if (null != props.href) {
    attributes[Attributes.href] = props.href;
  } else {
    if (null != oldProps?.href) {
      attributes[Attributes.href] = null;
    }
  }

  if (null != props.download) {
    attributes[Attributes.download] = props.download;
  } else {
    if (null != oldProps?.download) {
      attributes[Attributes.download] = null;
    }
  }

  if (null != props.rel) {
    attributes[Attributes.rel] = props.rel;
  } else {
    if (null != oldProps?.rel) {
      attributes[Attributes.rel] = null;
    }
  }

  if (null != props.target) {
    attributes[Attributes.target] = props.target;
  } else {
    if (null != oldProps?.target) {
      attributes[Attributes.target] = null;
    }
  }

  return attributes;
}
