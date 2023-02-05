// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/objects/dom_node_patch.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/html_widget_base.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// Abstract class for Inserted/Deleted text widgets.
///
@internal
abstract class HTMLAlteredTextBase extends HTMLWidgetBase {
  /// This attribute defines the URI of a resource that explains the change,
  /// such as a link to meeting minutes or a ticket in a troubleshooting system.
  ///
  final String? cite;

  /// This attribute indicates the time and date of the change and must be a
  /// valid date with an optional time string. If the value cannot be parsed as
  /// a date with an optional time string, the element does not have an
  /// associated time stamp.
  ///
  final String? dateTime;

  const HTMLAlteredTextBase({
    this.cite,
    this.dateTime,
    Key? key,
    NullableElementCallback? ref,
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
          ref: ref,
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
  bool shouldUpdateWidget(
    covariant oldWidget,
  ) {
    oldWidget as HTMLAlteredTextBase;

    return cite != oldWidget.cite ||
        dateTime != oldWidget.dateTime ||
        super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderElement(parent) => HTMLAlteredTextBaseRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// Table's cell base render element.
///
@internal
class HTMLAlteredTextBaseRenderElement extends HTMLRenderElementBase {
  HTMLAlteredTextBaseRenderElement(super.widget, super.parent);

  @mustCallSuper
  @override
  DomNodePatchFillable render({
    required covariant HTMLAlteredTextBase widget,
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
    required covariant HTMLAlteredTextBase oldWidget,
    required covariant HTMLAlteredTextBase newWidget,
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
  required HTMLAlteredTextBase widget,
  required HTMLAlteredTextBase? oldWidget,
  required Map<String, String?> attributes,
}) {
  if (widget.cite != oldWidget?.cite) {
    attributes[Attributes.cite] = widget.cite;
  }

  if (widget.dateTime != oldWidget?.dateTime) {
    attributes[Attributes.dateTime] = widget.dateTime;
  }
}
