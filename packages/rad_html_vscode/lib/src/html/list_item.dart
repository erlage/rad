// Copyright 2022-2023 H. Singh<hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';
import 'dart:html';
import 'package:rad/rad.dart';

import 'package:rad_html_vscode/src/abstract/html_widget_base.dart';
import 'package:rad_html_vscode/src/patch.dart';

/// The ListItem widget (HTML's `li` tag).
///
@internal
class ListItem extends HTMLWidgetBase {
  /// Value of list item.
  ///
  final int? value;

  const ListItem(
    List<Widget> children, {
    this.value,
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
  DomTagType get correspondingTag => DomTagType.listItem;

  @override
  bool shouldUpdateWidget(covariant ListItem oldWidget) {
    return value != oldWidget.value || super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderElement(parent) => ListItemRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

class ListItemRenderElement extends HTMLRenderElementBase {
  ListItemRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant ListItem widget,
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
    required covariant ListItem oldWidget,
    required covariant ListItem newWidget,
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
  required ListItem widget,
  required ListItem? oldWidget,
  required Map<String, String?> attributes,
}) {
  if (widget.value != oldWidget?.value) {
    if (null == widget.value) {
      attributes[Attributes.value] = null;
    } else {
      attributes[Attributes.value] = '${widget.value}';
    }
  }
}
