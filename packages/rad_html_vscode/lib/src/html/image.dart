// Copyright 2022-2023 H. Singh<hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';
import 'dart:html';
import 'package:rad/rad.dart';

import 'package:rad_html_vscode/src/abstract/html_widget_base.dart';
import 'package:rad_html_vscode/src/patch.dart';

/// The Image widget (HTML's `img` tag).
///
@internal
class Image extends HTMLWidgetBase {
  /// Alt text for image.
  ///
  final String? alt;

  /// Indicates if the fetching of the image must be done using a CORS request.
  ///
  final CrossOriginType? crossOrigin;

  /// Provides an image decoding hint to the browser.
  ///
  final DecodingType? decoding;

  /// Provides a hint of the relative priority to use when fetching the image.
  ///
  final FetchPriorityType? fetchPriority;

  /// Indicates how the image should be loaded.
  ///
  final LoadingType? loading;

  /// A [ReferrerPolicyType] which referrer to use when fetching the resource.
  ///
  final ReferrerPolicyType? referrerPolicy;

  /// The image URL.
  ///
  final String? src;

  /// One or more strings separated by commas.
  ///
  final String? srcSet;

  // size props

  final String? width;
  final String? height;

  const Image(
    List<Widget> children, {
    this.alt,
    this.crossOrigin,
    this.decoding,
    this.fetchPriority,
    this.loading,
    this.referrerPolicy,
    this.src,
    this.srcSet,
    this.width,
    this.height,
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
  DomTagType get correspondingTag => DomTagType.image;

  @override
  bool shouldUpdateWidget(covariant Image oldWidget) {
    return alt != oldWidget.alt ||
        crossOrigin != oldWidget.crossOrigin ||
        decoding != oldWidget.decoding ||
        fetchPriority != oldWidget.fetchPriority ||
        loading != oldWidget.loading ||
        referrerPolicy != oldWidget.referrerPolicy ||
        src != oldWidget.src ||
        srcSet != oldWidget.srcSet ||
        width != oldWidget.width ||
        height != oldWidget.height ||
        super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderElement(parent) => ImageRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// Image render element.
///
class ImageRenderElement extends HTMLRenderElementBase {
  ImageRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant Image widget,
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
    required covariant Image oldWidget,
    required covariant Image newWidget,
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
  required Image widget,
  required Image? oldWidget,
  required Map<String, String?> attributes,
}) {
  if (widget.alt != oldWidget?.alt) {
    attributes[Attributes.alt] = widget.alt;
  }

  if (widget.crossOrigin != oldWidget?.crossOrigin) {
    attributes[Attributes.crossOrigin] = widget.crossOrigin?.nativeValue;
  }

  if (widget.decoding != oldWidget?.decoding) {
    attributes[Attributes.decoding] = widget.decoding?.nativeValue;
  }

  if (widget.fetchPriority != oldWidget?.fetchPriority) {
    attributes[Attributes.fetchPriority] = widget.fetchPriority?.nativeValue;
  }

  if (widget.loading != oldWidget?.loading) {
    attributes[Attributes.loading] = widget.loading?.nativeValue;
  }

  if (widget.referrerPolicy != oldWidget?.referrerPolicy) {
    attributes[Attributes.referrerPolicy] = widget.referrerPolicy?.nativeValue;
  }

  if (widget.src != oldWidget?.src) {
    attributes[Attributes.src] = widget.src;
  }

  if (widget.srcSet != oldWidget?.srcSet) {
    attributes[Attributes.srcSet] = widget.srcSet;
  }

  if (widget.width != oldWidget?.width) {
    attributes[Attributes.width] = widget.width;
  }

  if (widget.height != oldWidget?.height) {
    attributes[Attributes.height] = widget.height;
  }
}
