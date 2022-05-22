import 'package:meta/meta.dart';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/markup_tag_with_global_props.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The IFrame widget (HTML's `iframe` tag).
///
class IFrame extends MarkUpTagWithGlobalProps {
  /// src of Iframe.
  ///
  final String? src;

  /// A targetable name for the embedded browsing context.
  ///
  final String? name;

  /// Specifies a feature policy for the <iframe>.
  ///
  final String? allow;

  /// This attribute is considered a legacy attribute.
  ///
  final bool? allowFullscreen;

  /// Set to true if a cross-origin <iframe> should be
  /// allowed to invoke the Payment Request API.
  ///
  final bool? allowPaymentRequest;

  /// Width of [IFrame] container.
  ///
  final String? width;

  /// Height of [IFrame] container.
  ///
  final String? height;

  const IFrame({
    this.src,
    this.name,
    this.allow,
    this.allowFullscreen,
    this.allowPaymentRequest,
    this.width,
    this.height,
    Key? key,
    bool? hidden,
    bool? draggable,
    bool? contenteditable,
    int? tabIndex,
    String? id,
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
  get widgetType => '$IFrame';

  @override
  get correspondingTag => DomTag.iFrame;

  @override
  createConfiguration() {
    return _IFrameConfiguration(
      src: src,
      name: name,
      allow: allow,
      allowFullscreen: allowFullscreen,
      allowPaymentRequest: allowPaymentRequest,
      width: width,
      height: height,
      globalConfiguration:
          super.createConfiguration() as MarkUpGlobalConfiguration,
    );
  }

  @override
  isConfigurationChanged(covariant _IFrameConfiguration oldConfiguration) {
    return src != oldConfiguration.src ||
        name != oldConfiguration.name ||
        allow != oldConfiguration.allow ||
        allowFullscreen != oldConfiguration.allowFullscreen ||
        allowPaymentRequest != oldConfiguration.allowPaymentRequest ||
        width != oldConfiguration.width ||
        height != oldConfiguration.height ||
        super.isConfigurationChanged(oldConfiguration.globalConfiguration);
  }

  @override
  createRenderObject(context) => _IFrameRenderObject(context);
}

/*
|--------------------------------------------------------------------------
| configuration
|--------------------------------------------------------------------------
*/

class _IFrameConfiguration extends WidgetConfiguration {
  final MarkUpGlobalConfiguration globalConfiguration;

  final String? src;
  final String? name;

  final String? allow;
  final bool? allowFullscreen;
  final bool? allowPaymentRequest;

  final String? width;
  final String? height;

  const _IFrameConfiguration({
    this.src,
    this.name,
    this.allow,
    this.allowFullscreen,
    this.allowPaymentRequest,
    this.width,
    this.height,
    required this.globalConfiguration,
  });
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class _IFrameRenderObject extends MarkUpGlobalRenderObject {
  const _IFrameRenderObject(BuildContext context) : super(context);

  @override
  render({
    required covariant _IFrameConfiguration configuration,
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
    required covariant _IFrameConfiguration oldConfiguration,
    required covariant _IFrameConfiguration newConfiguration,
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
  required _IFrameConfiguration props,
  required _IFrameConfiguration? oldProps,
}) {
  var attributes = <String, String?>{};

  if (null != props.src) {
    attributes[Attributes.src] = props.src;
  } else {
    if (null != oldProps?.src) {
      attributes[Attributes.src] = null;
    }
  }

  if (null != props.name) {
    attributes[Attributes.name] = props.name;
  } else {
    if (null != oldProps?.name) {
      attributes[Attributes.name] = null;
    }
  }

  if (null != props.width) {
    attributes[Attributes.width] = props.width;
  } else {
    if (null != oldProps?.width) {
      attributes[Attributes.width] = null;
    }
  }

  if (null != props.height) {
    attributes[Attributes.height] = props.height;
  } else {
    if (null != oldProps?.height) {
      attributes[Attributes.height] = null;
    }
  }

  if (null != props.allow) {
    attributes[Attributes.allow] = props.allow;
  } else {
    if (null != oldProps?.allow) {
      attributes[Attributes.allow] = null;
    }
  }

  if (null != props.allowFullscreen && props.allowFullscreen!) {
    attributes[Attributes.allowFullscreen] = '${props.allowFullscreen}';
  } else {
    if (null != oldProps?.allowFullscreen) {
      attributes[Attributes.allowFullscreen] = null;
    }
  }

  if (null != props.allowPaymentRequest && props.allowPaymentRequest!) {
    var value = '${props.allowPaymentRequest}';

    attributes[Attributes.allowPaymentRequest] = value;
  } else {
    if (null != oldProps?.allowPaymentRequest) {
      attributes[Attributes.allowPaymentRequest] = null;
    }
  }

  return attributes;
}
