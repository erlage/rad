// Copyright 2022-2023 H. Singh<hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:html';

import 'package:meta/meta.dart';
import 'package:rad/rad.dart';

import 'package:rad_html_vscode/src/abstract/html_widget_base.dart';
import 'package:rad_html_vscode/src/patch.dart';

/// The IFrame widget (HTML's `iframe` tag).
///
@internal
class IFrame extends HTMLWidgetBase {
  /// src of Iframe.
  ///
  final String? src;

  /// Inline HTML to embed, overriding the src attribute. If a browser does not
  /// support the srcdoc attribute, it will fall back to the URL in the src
  /// attribute.
  ///
  final String? srcDoc;

  /// A target-able name for the embedded browsing context.
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

  /// Provides a hint of the relative priority to use when fetching the iframe
  /// document.
  ///
  final FetchPriorityType? fetchPriority;

  /// Height of [IFrame] container. Default is 150.
  ///
  final String? height;

  /// Indicates which referrer to send when fetching the frame's resources
  ///
  final ReferrerPolicyType? referrerPolicy;

  /// Width of [IFrame] container. Default is 300.
  ///
  final String? width;

  const IFrame(
    List<Widget> children, {
    this.src,
    this.srcDoc,
    this.name,
    this.allow,
    this.allowFullscreen,
    this.allowPaymentRequest,
    this.fetchPriority,
    this.height,
    this.referrerPolicy,
    this.width,
    Key? key,
    void Function(Element? element)? ref,
    String? id,
    String? title,
    String? style,
    String? className,
    bool? hidden,
    EventCallback? onClick,
    Map<String, String>? additionalAttributes,
  }) : super(
          children,
          key: key,
          ref: ref,
          id: id,
          title: title,
          style: style,
          className: className,
          hidden: hidden,
          onClick: onClick,
          additionalAttributes: additionalAttributes,
        );

  @override
  DomTagType get correspondingTag => DomTagType.iFrame;

  @override
  bool shouldUpdateWidget(covariant IFrame oldWidget) {
    return src != oldWidget.src ||
        srcDoc != oldWidget.srcDoc ||
        name != oldWidget.name ||
        allow != oldWidget.allow ||
        allowFullscreen != oldWidget.allowFullscreen ||
        allowPaymentRequest != oldWidget.allowPaymentRequest ||
        fetchPriority != oldWidget.fetchPriority ||
        height != oldWidget.height ||
        referrerPolicy != oldWidget.referrerPolicy ||
        width != oldWidget.width ||
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
    var domNodePatch = super.render(
      widget: widget,
    );

    _extendAttributes(
      widget: widget,
      oldWidget: null,
      attributes: domNodePatch.attributes,
    );

    return domNodePatch;
  }

  @override
  update({
    required updateType,
    required covariant IFrame oldWidget,
    required covariant IFrame newWidget,
  }) {
    var domNodePatch = super.update(
      updateType: updateType,
      oldWidget: oldWidget,
      newWidget: newWidget,
    );

    _extendAttributes(
      widget: newWidget,
      oldWidget: oldWidget,
      attributes: domNodePatch.attributes,
    );

    return domNodePatch;
  }
}

/*
|--------------------------------------------------------------------------
| patch
|--------------------------------------------------------------------------
*/

void _extendAttributes({
  required IFrame widget,
  required IFrame? oldWidget,
  required Map<String, String?> attributes,
}) {
  if (widget.src != oldWidget?.src) {
    attributes[Attributes.src] = widget.src;
  }

  if (widget.srcDoc != oldWidget?.srcDoc) {
    attributes[Attributes.srcDoc] = widget.srcDoc;
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

  if (widget.fetchPriority != oldWidget?.fetchPriority) {
    attributes[Attributes.fetchPriority] = widget.fetchPriority?.nativeValue;
  }

  if (widget.referrerPolicy != oldWidget?.referrerPolicy) {
    attributes[Attributes.referrerPolicy] = widget.referrerPolicy?.nativeValue;
  }
}
