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
  String get widgetType => 'Time';

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
    required covariant Time oldWidget,
    required covariant Time newWidget,
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
  required Time widget,
  required Time? oldWidget,
}) {
  var attributes = <String, String?>{};

  if (widget.dateTime != oldWidget?.dateTime) {
    attributes[Attributes.dateTime] = widget.dateTime;
  }

  return attributes;
}
