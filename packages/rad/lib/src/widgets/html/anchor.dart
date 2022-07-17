// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/html_widget_base.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The Anchor widget (HTML's `a` tag).
///
class Anchor extends HTMLWidgetBase {
  /// The URL that the hyperlink points to.
  ///
  final String? href;

  /// The relationship of the linked URL as space-separated link types.
  ///
  final String? rel;

  /// Where to display the linked URL.
  ///
  final String? target;

  /// Prompts the user to save the linked URL instead of navigating to it.
  /// Can be used with or without a value.
  ///
  final String? download;

  const Anchor({
    Key? key,
    this.href,
    this.rel,
    this.target,
    this.download,
    String? id,
    String? title,
    String? style,
    String? className,
    bool? hidden,
    String? innerText,
    Widget? child,
    List<Widget>? children,
    EventCallback? onClick,
    Map<String, String>? additionalAttributes,
  }) : super(
          key: key,
          id: id,
          title: title,
          style: style,
          className: className,
          hidden: hidden,
          innerText: innerText,
          child: child,
          children: children,
          onClick: onClick,
          additionalAttributes: additionalAttributes,
        );

  @nonVirtual
  @override
  String get widgetType => 'Anchor';

  @override
  DomTagType get correspondingTag => DomTagType.anchor;

  @override
  bool shouldUpdateWidget(covariant Anchor oldWidget) {
    return href != oldWidget.href ||
        rel != oldWidget.rel ||
        target != oldWidget.target ||
        download != oldWidget.download ||
        super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderElement(parent) => AnchorRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// Anchor render element.
///
class AnchorRenderElement extends HTMLRenderElementBase {
  AnchorRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant Anchor widget,
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
    required covariant Anchor oldWidget,
    required covariant Anchor newWidget,
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
  required Anchor widget,
  required Anchor? oldWidget,
  required Map<String, String?> attributes,
}) {
  if (widget.href != oldWidget?.href) {
    attributes[Attributes.href] = widget.href;
  }

  if (widget.download != oldWidget?.download) {
    attributes[Attributes.download] = widget.download;
  }

  if (widget.rel != oldWidget?.rel) {
    attributes[Attributes.rel] = widget.rel;
  }

  if (widget.target != oldWidget?.target) {
    attributes[Attributes.target] = widget.target;
  }
}
