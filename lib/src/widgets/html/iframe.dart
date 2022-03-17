import 'dart:html';

import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/types.dart';
import 'package:rad/src/widgets/abstract/markup_tag_with_global_props.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/utils/common_props.dart';

/// The IFrame tag.
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

  // size props

  final String? width;
  final String? height;
  final String? size;

  const IFrame({
    this.src,
    this.name,
    this.allow,
    this.allowFullscreen,
    this.allowPaymentRequest,
    this.width,
    this.height,
    this.size,
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
  get concreteType => "$IFrame";

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
      size: size,
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
        size != oldConfiguration.size ||
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
  final String? size;

  const _IFrameConfiguration({
    this.src,
    this.name,
    this.allow,
    this.allowFullscreen,
    this.allowPaymentRequest,
    this.width,
    this.height,
    this.size,
    required this.globalConfiguration,
  });
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class _IFrameRenderObject extends RenderObject {
  const _IFrameRenderObject(BuildContext context) : super(context);

  @override
  render(
    element,
    covariant _IFrameConfiguration configuration,
  ) {
    _IFrameProps.apply(element, configuration);
  }

  @override
  update({
    required element,
    required updateType,
    required covariant _IFrameConfiguration oldConfiguration,
    required covariant _IFrameConfiguration newConfiguration,
  }) {
    _IFrameProps.clear(element, oldConfiguration);
    _IFrameProps.apply(element, newConfiguration);
  }
}

/*
|--------------------------------------------------------------------------
| props
|--------------------------------------------------------------------------
*/

class _IFrameProps {
  static void apply(HtmlElement element, _IFrameConfiguration props) {
    element as IFrameElement;

    MarkUpGlobalProps.apply(element, props.globalConfiguration);

    CommonProps.applySizeProps(
      element,
      width: props.width,
      height: props.height,
      size: props.size,
    );

    if (null != props.src) {
      element.src = props.src;
    }

    if (null != props.name) {
      element.name = props.name;
    }

    if (null != props.allow) {
      element.allow = props.allow;
    }

    if (null != props.allowFullscreen) {
      element.allowFullscreen = props.allowFullscreen;
    }

    if (null != props.allowPaymentRequest) {
      element.allowPaymentRequest = props.allowPaymentRequest;
    }
  }

  static void clear(HtmlElement element, _IFrameConfiguration props) {
    element as IFrameElement;

    MarkUpGlobalProps.clear(element, props.globalConfiguration);

    CommonProps.clearSizeProps(
      element,
      width: props.width,
      height: props.height,
      size: props.size,
    );

    if (null != props.src) {
      element.removeAttribute(_Attributes.src);
    }

    if (null != props.name) {
      element.removeAttribute(_Attributes.name);
    }

    element.removeAttribute(_Attributes.allow);
  }
}

class _Attributes {
  static const src = "src";
  static const name = "name";
  static const allow = "allow";
}
