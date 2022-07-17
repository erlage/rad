// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/html_widget_base.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The OrderedList widget (HTML's `ol` tag).
///
/// This HTML dom node represents an ordered list of items.
///
class OrderedList extends HTMLWidgetBase {
  /// An integer to start counting from for the list items.
  ///
  final int? start;

  /// This Boolean attribute specifies that the list's items are in reverse
  /// order. Items will be numbered from high to low.
  ///
  final bool? reversed;

  /// Type of ordered list.
  ///
  final OrderedListType? type;

  const OrderedList({
    this.start,
    this.reversed,
    this.type,
    Key? key,
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

  @override
  DomTagType get correspondingTag => DomTagType.orderedList;

  @override
  bool shouldUpdateWidget(covariant OrderedList oldWidget) {
    return start != oldWidget.start ||
        reversed != oldWidget.reversed ||
        type != oldWidget.type ||
        super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderElement(parent) => OrderedListRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// OrderedList render element.
///
class OrderedListRenderElement extends HTMLRenderElementBase {
  OrderedListRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant OrderedList widget,
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
    required covariant OrderedList oldWidget,
    required covariant OrderedList newWidget,
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
  required OrderedList widget,
  required OrderedList? oldWidget,
  required Map<String, String?> attributes,
}) {
  if (widget.type != oldWidget?.type) {
    attributes[Attributes.type] = widget.type?.nativeName;
  }

  if (widget.start != oldWidget?.start) {
    if (null == widget.start) {
      attributes[Attributes.start] = null;
    } else {
      attributes[Attributes.start] = '${widget.start}';
    }
  }

  if (widget.reversed != oldWidget?.reversed) {
    if (null == widget.reversed || false == widget.reversed) {
      attributes[Attributes.reversed] = null;
    } else {
      attributes[Attributes.reversed] = 'true';
    }
  }
}
