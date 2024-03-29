// Copyright 2022 H. Singh<hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:html';

import 'package:meta/meta.dart';
import 'package:rad/rad.dart';

import 'package:rad_html_vscode/src/abstract/html_widget_base.dart';
import 'package:rad_html_vscode/src/patch.dart';

/// The Option widget (HTML's `option` tag).
///
@internal
class Option extends HTMLWidgetBase {
  /// The content of this attribute represents the value
  /// to be submitted with the form
  ///
  final String? value;

  /// This attribute is text for the label indicating the meaning
  /// of the option. If the label attribute isn't defined, its value
  /// is that of the dom node text content.
  ///
  final String? label;

  /// If present, this Boolean attribute indicates that the
  /// option is initially selected.
  ///
  final bool? selected;

  /// Whether Option is disabled.
  ///
  final bool? disabled;

  const Option(
    List<Widget> children, {
    this.value,
    this.selected,
    this.disabled,
    this.label,
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
  DomTagType get correspondingTag => DomTagType.option;

  @override
  bool shouldUpdateWidget(covariant Option oldWidget) {
    return value != oldWidget.value ||
        label != oldWidget.label ||
        selected != oldWidget.selected ||
        disabled != oldWidget.disabled ||
        super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderElement(parent) => OptionRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// Option render element.
///
class OptionRenderElement extends HTMLRenderElementBase {
  OptionRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant Option widget,
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
    required covariant Option oldWidget,
    required covariant Option newWidget,
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
  required Option widget,
  required Option? oldWidget,
  required Map<String, String?> attributes,
}) {
  if (widget.value != oldWidget?.value) {
    attributes[Attributes.value] = widget.value;
  }

  if (widget.label != oldWidget?.label) {
    attributes[Attributes.label] = widget.label;
  }

  if (widget.selected != oldWidget?.selected) {
    if (null == widget.selected || false == widget.selected) {
      attributes[Attributes.selected] = null;
    } else {
      attributes[Attributes.selected] = 'true';
    }
  }

  if (widget.disabled != oldWidget?.disabled) {
    if (null == widget.disabled || false == widget.disabled) {
      attributes[Attributes.disabled] = null;
    } else {
      attributes[Attributes.disabled] = 'true';
    }
  }
}
