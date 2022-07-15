// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
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
    bool? contentEditable,
    int? tabIndex,
    String? id,
    String? title,
    String? style,
    String? className,
    String? innerText,
    List<Widget>? children,
    EventCallback? onClick,
    Map<String, String>? additionalAttributes,
  }) : super(
          key: key,
          id: id,
          title: title,
          tabIndex: tabIndex,
          draggable: draggable,
          contentEditable: contentEditable,
          hidden: hidden,
          style: style,
          className: className,
          innerText: innerText,
          children: children,
          onClick: onClick,
          additionalAttributes: additionalAttributes,
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
  createRenderElement(parent) => IFrameRenderObject(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// IFrame render element.
///
class IFrameRenderObject extends HTMLRenderElementBase {
  IFrameRenderObject(super.widget, super.parent);

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

  if (widget.src != oldWidget?.src) {
    attributes[Attributes.src] = widget.src;
  }

  if (widget.name != oldWidget?.name) {
    attributes[Attributes.name] = widget.name;
  }

  if (widget.width != oldWidget?.width) {
    attributes[Attributes.width] = widget.width;
  }

  if (widget.height != oldWidget?.height) {
    attributes[Attributes.height] = widget.height;
  }

  if (widget.allow != oldWidget?.allow) {
    attributes[Attributes.allow] = widget.allow;
  }

  if (widget.allowFullscreen != oldWidget?.allowFullscreen) {
    if (null == widget.allowFullscreen || false == widget.allowFullscreen) {
      attributes[Attributes.allowFullscreen] = null;
    } else {
      attributes[Attributes.allowFullscreen] = 'true';
    }
  }

  if (widget.allowPaymentRequest != oldWidget?.allowPaymentRequest) {
    var allowPaymentRequest = widget.allowPaymentRequest;

    if (null == allowPaymentRequest || false == allowPaymentRequest) {
      attributes[Attributes.allowPaymentRequest] = null;
    } else {
      attributes[Attributes.allowPaymentRequest] = 'true';
    }
  }

  return attributes;
}
