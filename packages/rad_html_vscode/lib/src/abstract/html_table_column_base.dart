// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';
import 'dart:html';
import 'package:rad/rad.dart';

import 'package:rad_html_vscode/src/abstract/html_widget_base.dart';
import 'package:rad_html_vscode/src/patch.dart';

/// Abstract class for TableColumn and TableColumnGroup.
///
@internal
abstract class HTMLTableColumnBase extends HTMLWidgetBase {
  /// This attribute contains a positive integer indicating the number of
  /// consecutive columns the TableColumn spans. If not present, its default
  /// value is 1.
  ///
  final int? span;

  const HTMLTableColumnBase(
    List<Widget> children, {
    this.span,
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
  @override
  bool shouldUpdateWidget(
    covariant HTMLTableColumnBase oldWidget,
  ) {
    return span != oldWidget.span || super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderElement(parent) => HTMLTableColumnBaseRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// Table column base render element.
///
@internal
class HTMLTableColumnBaseRenderElement extends HTMLRenderElementBase {
  HTMLTableColumnBaseRenderElement(super.widget, super.parent);

  @mustCallSuper
  @override
  DomNodePatchFillable render({
    required covariant HTMLTableColumnBase widget,
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

  @mustCallSuper
  @override
  DomNodePatchFillable update({
    required updateType,
    required covariant HTMLTableColumnBase oldWidget,
    required covariant HTMLTableColumnBase newWidget,
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
  required HTMLTableColumnBase widget,
  required HTMLTableColumnBase? oldWidget,
  required Map<String, String?> attributes,
}) {
  if (widget.span != oldWidget?.span) {
    if (null == widget.span) {
      attributes[Attributes.span] = null;
    } else {
      attributes[Attributes.span] = '${widget.span}';
    }
  }
}
