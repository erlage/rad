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

/// The Blockquote widget (HTML's `blockquote` tag).
///
class BlockQuote extends HTMLWidgetBase {
  /// A URL for the source of the quotation may be given using the cite
  /// attribute.
  ///
  final String? cite;

  const BlockQuote({
    Key? key,
    this.cite,
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
  String get widgetType => 'BlockQuote';

  @override
  DomTagType get correspondingTag => DomTagType.blockQuote;

  @override
  bool shouldUpdateWidget(covariant BlockQuote oldWidget) {
    return cite != oldWidget.cite || super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderElement(parent) => BlockquoteRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// Blockquote render element.
///
class BlockquoteRenderElement extends HTMLRenderElementBase {
  BlockquoteRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant BlockQuote widget,
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
    required covariant BlockQuote oldWidget,
    required covariant BlockQuote newWidget,
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
  required BlockQuote widget,
  required BlockQuote? oldWidget,
  required Map<String, String?> attributes,
}) {
  if (widget.cite != oldWidget?.cite) {
    attributes[Attributes.cite] = widget.cite;
  }
}
