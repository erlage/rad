import 'package:meta/meta.dart';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/html_widget_base.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The IFrame widget (HTML's `iframe` tag).
///
class IFrame extends HTMLWidgetBase {
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
  String get widgetType => 'IFrame';

  @override
  DomTagType get correspondingTag => DomTagType.iFrame;

  @override
  bool shouldUpdateWidget(covariant IFrame oldWidget) {
    return src != oldWidget.src ||
        name != oldWidget.name ||
        allow != oldWidget.allow ||
        allowFullscreen != oldWidget.allowFullscreen ||
        allowPaymentRequest != oldWidget.allowPaymentRequest ||
        width != oldWidget.width ||
        height != oldWidget.height ||
        super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderObject(context) => _IFrameRenderObject(context);
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
    required covariant IFrame widget,
  }) {
    var domNodeDescription = super.render(
      widget: widget,
    );

    domNodeDescription?.attributes?.addAll(
      _prepareAttributes(
        widget: widget,
        oldWidget: null,
      ),
    );

    return domNodeDescription;
  }

  @override
  update({
    required updateType,
    required covariant IFrame oldWidget,
    required covariant IFrame newWidget,
  }) {
    var domNodeDescription = super.update(
      updateType: updateType,
      oldWidget: oldWidget,
      newWidget: newWidget,
    );

    domNodeDescription?.attributes?.addAll(
      _prepareAttributes(
        widget: newWidget,
        oldWidget: oldWidget,
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
  required IFrame widget,
  required IFrame? oldWidget,
}) {
  var attributes = <String, String?>{};

  if (null != widget.src) {
    attributes[Attributes.src] = widget.src;
  } else {
    if (null != oldWidget?.src) {
      attributes[Attributes.src] = null;
    }
  }

  if (null != widget.name) {
    attributes[Attributes.name] = widget.name;
  } else {
    if (null != oldWidget?.name) {
      attributes[Attributes.name] = null;
    }
  }

  if (null != widget.width) {
    attributes[Attributes.width] = widget.width;
  } else {
    if (null != oldWidget?.width) {
      attributes[Attributes.width] = null;
    }
  }

  if (null != widget.height) {
    attributes[Attributes.height] = widget.height;
  } else {
    if (null != oldWidget?.height) {
      attributes[Attributes.height] = null;
    }
  }

  if (null != widget.allow) {
    attributes[Attributes.allow] = widget.allow;
  } else {
    if (null != oldWidget?.allow) {
      attributes[Attributes.allow] = null;
    }
  }

  if (null != widget.allowFullscreen && widget.allowFullscreen!) {
    attributes[Attributes.allowFullscreen] = '${widget.allowFullscreen}';
  } else {
    if (null != oldWidget?.allowFullscreen) {
      attributes[Attributes.allowFullscreen] = null;
    }
  }

  if (null != widget.allowPaymentRequest && widget.allowPaymentRequest!) {
    var value = '${widget.allowPaymentRequest}';

    attributes[Attributes.allowPaymentRequest] = value;
  } else {
    if (null != oldWidget?.allowPaymentRequest) {
      attributes[Attributes.allowPaymentRequest] = null;
    }
  }

  return attributes;
}
