// Copyright 2022-2023 H. Singh<hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:html';

import 'package:meta/meta.dart';
import 'package:rad/rad.dart';

import 'package:rad_html_vscode/src/abstract/html_widget_base.dart';
import 'package:rad_html_vscode/src/patch.dart';

/// The Dialog widget (HTML's `dialog` tag).
///
@internal
class Dialog extends HTMLWidgetBase {
  /// Indicates that the dialog is active and can be interacted with. When the
  /// open attribute is not set, the dialog shouldn't be shown to the user.
  ///
  final bool? open;

  const Dialog(
    List<Widget> children, {
    this.open,
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
  DomTagType get correspondingTag => DomTagType.dialog;

  @override
  bool shouldUpdateWidget(covariant Dialog oldWidget) {
    return open != oldWidget.open || super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderElement(parent) => DialogRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// Dialog render element.
///
class DialogRenderElement extends HTMLRenderElementBase {
  DialogRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant Dialog widget,
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
    required covariant Dialog oldWidget,
    required covariant Dialog newWidget,
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
  required Dialog widget,
  required Dialog? oldWidget,
  required Map<String, String?> attributes,
}) {
  if (widget.open != oldWidget?.open) {
    if (null == widget.open || false == widget.open) {
      attributes[Attributes.open] = null;
    } else {
      attributes[Attributes.open] = 'true';
    }
  }
}
