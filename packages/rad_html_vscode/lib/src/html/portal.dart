// Copyright 2022-2023 H. Singh<hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:html';

import 'package:meta/meta.dart';
import 'package:rad/rad.dart';

import 'package:rad_html_vscode/src/abstract/html_widget_base.dart';
import 'package:rad_html_vscode/src/patch.dart';

/// The Portal widget (HTML's `portal` tag).
///
@internal
class Portal extends HTMLWidgetBase {
  /// Sets the referrer policy to use when requesting the page at the URL given
  /// as the value of the src attribute.
  ///
  final ReferrerPolicyType? referrerPolicy;

  /// The URL of the page to embed.
  ///
  final String? src;

  const Portal(
    List<Widget> children, {
    this.referrerPolicy,
    this.src,
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
  DomTagType get correspondingTag => DomTagType.portal;

  @override
  bool shouldUpdateWidget(covariant Portal oldWidget) {
    return referrerPolicy != oldWidget.referrerPolicy ||
        src != oldWidget.src ||
        super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderElement(parent) => PortalRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// Portal render element.
///
class PortalRenderElement extends HTMLRenderElementBase {
  PortalRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant Portal widget,
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
    required covariant Portal oldWidget,
    required covariant Portal newWidget,
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
  required Portal widget,
  required Portal? oldWidget,
  required Map<String, String?> attributes,
}) {
  if (widget.referrerPolicy != oldWidget?.referrerPolicy) {
    attributes[Attributes.referrerPolicy] = widget.referrerPolicy?.nativeValue;
  }

  if (widget.src != oldWidget?.src) {
    attributes[Attributes.src] = widget.src;
  }
}
