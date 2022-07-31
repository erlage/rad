// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/html_widget_base.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The Time widget (HTML's `time` tag).
///
class Time extends HTMLWidgetBase {
  /// This attribute indicates the time and/or date of the element and must be
  /// in one of the formats described below.
  ///
  final String? dateTime;

  const Time({
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
  DomTagType get correspondingTag => DomTagType.time;

  @override
  bool shouldUpdateWidget(covariant Time oldWidget) {
    return dateTime != oldWidget.dateTime ||
        super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderElement(parent) => TimeRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// Time render element.
///
class TimeRenderElement extends HTMLRenderElementBase {
  TimeRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant Time widget,
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
    required covariant Time oldWidget,
    required covariant Time newWidget,
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
  required Time widget,
  required Time? oldWidget,
  required Map<String, String?> attributes,
}) {
  if (widget.dateTime != oldWidget?.dateTime) {
    attributes[Attributes.dateTime] = widget.dateTime;
  }
}
