// Copyright 2022 H. Singh<hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:html';

import 'package:meta/meta.dart';
import 'package:rad/rad.dart';

import 'package:rad_html_vscode/src/abstract/html_widget_base.dart';
import 'package:rad_html_vscode/src/patch.dart';

/// The ImageMapArea widget (HTML's `area` tag).
///
@internal
class ImageMapArea extends HTMLWidgetBase {
  /// A text string alternative to display on browsers that do not display
  /// images.
  ///
  final String? alt;

  /// The coords attribute details the coordinates of the shape attribute in
  /// size, shape, and placement of an [ImageMapArea].
  ///
  final String? coords;

  /// The hyperlink target for the area. Its value is a valid URL. This
  /// attribute may be omitted; if so, the [ImageMapArea] element does not
  /// represent a hyperlink.
  ///
  final String? href;

  /// Indicates the language of the linked resource.
  ///
  final String? hrefLang;

  /// Contains a space-separated list of URLs to which, when the hyperlink is
  /// followed, POST requests with the body PING will be sent by the browser
  /// (in the background). Typically used for tracking.
  ///
  final String? ping;

  /// A [ReferrerPolicyType] indicating which referrer to use when fetching the
  /// resource.
  ///
  final ReferrerPolicyType? referrerPolicy;

  /// For anchors containing the href attribute, this attribute specifies the
  /// relationship of the target object to the link object. The value is a
  /// space-separated list of link types values. The values and their semantics
  /// will be registered by some authority that might have meaning to the
  /// document author. The default relationship, if no other is given, is void.
  /// Use this attribute only if the href attribute is present.
  ///
  final String? rel;

  /// The shape of the associated hot spot. The specifications for HTML defines
  /// the values rect, which defines a rectangular region; circle, which
  /// defines a circular region; poly, which defines a polygon; and default,
  /// which indicates the entire region beyond any defined shapes.
  ///
  final String? shape;

  /// A keyword or author-defined name of the browsing context to display the
  /// linked resource.
  ///
  final String? target;

  /// This attribute, if present, indicates that the author intends the
  /// hyperlink to be used for downloading a resource.
  ///
  final String? download;

  const ImageMapArea(
    List<Widget> children, {
    this.alt,
    this.coords,
    this.href,
    this.hrefLang,
    this.ping,
    this.referrerPolicy,
    this.rel,
    this.shape,
    this.target,
    this.download,
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
  DomTagType get correspondingTag => DomTagType.imageMapArea;

  @override
  bool shouldUpdateWidget(covariant ImageMapArea oldWidget) {
    return alt != oldWidget.alt ||
        coords != oldWidget.coords ||
        href != oldWidget.href ||
        hrefLang != oldWidget.hrefLang ||
        ping != oldWidget.ping ||
        referrerPolicy != oldWidget.referrerPolicy ||
        rel != oldWidget.rel ||
        shape != oldWidget.shape ||
        target != oldWidget.target ||
        download != oldWidget.download ||
        super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderElement(parent) => ImageMapAreaRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// ImageMapArea render element.
///
class ImageMapAreaRenderElement extends HTMLRenderElementBase {
  ImageMapAreaRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant ImageMapArea widget,
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
    required covariant ImageMapArea oldWidget,
    required covariant ImageMapArea newWidget,
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
  required ImageMapArea widget,
  required ImageMapArea? oldWidget,
  required Map<String, String?> attributes,
}) {
  if (widget.alt != oldWidget?.alt) {
    attributes[Attributes.alt] = widget.alt;
  }

  if (widget.coords != oldWidget?.coords) {
    attributes[Attributes.coords] = widget.coords;
  }

  if (widget.href != oldWidget?.href) {
    attributes[Attributes.href] = widget.href;
  }

  if (widget.hrefLang != oldWidget?.hrefLang) {
    attributes[Attributes.hrefLang] = widget.hrefLang;
  }

  if (widget.ping != oldWidget?.ping) {
    attributes[Attributes.ping] = widget.ping;
  }

  if (widget.referrerPolicy != oldWidget?.referrerPolicy) {
    attributes[Attributes.referrerPolicy] = widget.referrerPolicy?.nativeValue;
  }

  if (widget.shape != oldWidget?.shape) {
    attributes[Attributes.shape] = widget.shape;
  }

  if (widget.rel != oldWidget?.rel) {
    attributes[Attributes.rel] = widget.rel;
  }

  if (widget.download != oldWidget?.download) {
    attributes[Attributes.download] = widget.download;
  }

  if (widget.target != oldWidget?.target) {
    attributes[Attributes.target] = widget.target;
  }
}
