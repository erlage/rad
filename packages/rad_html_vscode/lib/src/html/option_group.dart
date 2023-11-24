// Copyright 2022 H. Singh<hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:html';

import 'package:meta/meta.dart';
import 'package:rad/rad.dart';

import 'package:rad_html_vscode/src/abstract/html_widget_base.dart';
import 'package:rad_html_vscode/src/patch.dart';

/// The OptionGroup widget (HTML's `optgroup` tag).
///
@internal
class OptionGroup extends HTMLWidgetBase {
  /// The name of the group of options, which the browser can use when labeling
  /// the options in the user interface.
  ///
  final String? label;

  /// If this Boolean attribute is set, none of the items in this option group
  /// is selectable. Often browsers grey out such control and it won't receive
  /// any browsing events, like mouse clicks or focus-related ones.
  ///
  final bool? disabled;

  const OptionGroup(
    List<Widget> children, {
    this.label,
    this.disabled,
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
  DomTagType get correspondingTag => DomTagType.optionGroup;

  @override
  bool shouldUpdateWidget(covariant OptionGroup oldWidget) {
    return label != oldWidget.label ||
        disabled != oldWidget.disabled ||
        super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderElement(parent) => OptionGroupRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// OptionGroup render element.
///
class OptionGroupRenderElement extends HTMLRenderElementBase {
  OptionGroupRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant OptionGroup widget,
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
    required covariant OptionGroup oldWidget,
    required covariant OptionGroup newWidget,
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
  required OptionGroup widget,
  required OptionGroup? oldWidget,
  required Map<String, String?> attributes,
}) {
  if (widget.label != oldWidget?.label) {
    attributes[Attributes.label] = widget.label;
  }

  if (widget.disabled != oldWidget?.disabled) {
    if (null == widget.disabled || false == widget.disabled) {
      attributes[Attributes.disabled] = null;
    } else {
      attributes[Attributes.disabled] = 'true';
    }
  }
}
