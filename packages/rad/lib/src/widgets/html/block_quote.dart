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
    bool? hidden,
    bool? draggable,
    bool? contentEditable,
    int? tabIndex,
    String? id,
    String? title,
    String? style,
    String? classAttribute,
    Map<String, String>? dataAttributes,
    String? onClickAttribute,
    String? innerText,
    Widget? child,
    List<Widget>? children,
    EventCallback? onClick,
  }) : super(
          key: key,
          id: id,
          title: title,
          tabIndex: tabIndex,
          draggable: draggable,
          hidden: hidden,
          style: style,
          classAttribute: classAttribute,
          contentEditable: contentEditable,
          dataAttributes: dataAttributes,
          onClickAttribute: onClickAttribute,
          innerText: innerText,
          child: child,
          children: children,
          onClick: onClick,
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
class BlockquoteRenderElement extends HTMLBaseElement {
  BlockquoteRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant BlockQuote widget,
  }) {
    var domNodeDescription = super.render(
      widget: widget,
    );

    domNodeDescription?.attributes?.addAll(
      _prepareAttributes(
        widget: widget,
        oldWidget: null,
      ),
    );

    return domNodeDescription;
  }

  @override
  update({
    required updateType,
    required covariant BlockQuote oldWidget,
    required covariant BlockQuote newWidget,
  }) {
    var domNodeDescription = super.update(
      updateType: updateType,
      oldWidget: oldWidget,
      newWidget: newWidget,
    );

    domNodeDescription?.attributes?.addAll(
      _prepareAttributes(
        widget: newWidget,
        oldWidget: oldWidget,
      ),
    );

    return domNodeDescription;
  }
}

/*
|--------------------------------------------------------------------------
| props
|--------------------------------------------------------------------------
*/

Map<String, String?> _prepareAttributes({
  required BlockQuote widget,
  required BlockQuote? oldWidget,
}) {
  var attributes = <String, String?>{};

  if (null != widget.cite) {
    attributes[Attributes.cite] = widget.cite;
  } else {
    if (null != oldWidget?.cite) {
      attributes[Attributes.cite] = null;
    }
  }

  return attributes;
}
