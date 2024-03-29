// Copyright 2022 H. Singh<hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:html';

import 'package:meta/meta.dart';
import 'package:rad/rad.dart';

import 'package:rad_html_vscode/src/abstract/html_widget_base.dart';
import 'package:rad_html_vscode/src/patch.dart';

/// The Label widget (HTML's `label` tag).
///
@internal
class Label extends HTMLWidgetBase {
  /// The value of the [forAttribute] attribute must be a single key for a
  /// label-able form-related dom node in the same document as the <label> dom
  /// node
  ///
  final String? forAttribute;

  const Label(
    List<Widget> children, {
    this.forAttribute,
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
  DomTagType get correspondingTag => DomTagType.label;

  @override
  bool shouldUpdateWidget(covariant Label oldWidget) {
    return forAttribute != oldWidget.forAttribute ||
        super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderElement(parent) => LabelRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// Label render element.
///
class LabelRenderElement extends HTMLRenderElementBase {
  LabelRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant Label widget,
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
    required covariant Label oldWidget,
    required covariant Label newWidget,
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
  required Label widget,
  required Label? oldWidget,
  required Map<String, String?> attributes,
}) {
  if (widget.forAttribute != oldWidget?.forAttribute) {
    attributes[Attributes.forAttribute] = widget.forAttribute;
  }
}
