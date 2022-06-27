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

/// The Progress widget (HTML's `progress` tag).
///
class Progress extends HTMLWidgetBase {
  /// This attribute specifies how much of the task that has
  /// been completed.
  ///
  final num? value;

  /// This attribute describes how much work the task indicated
  /// by the progress dom node requires.
  ///
  final num? max;

  const Progress({
    this.value,
    this.max,
    Key? key,
    String? id,
    bool? hidden,
    bool? draggable,
    bool? contentEditable,
    int? tabIndex,
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
          contentEditable: contentEditable,
          hidden: hidden,
          style: style,
          classAttribute: classAttribute,
          dataAttributes: dataAttributes,
          onClickAttribute: onClickAttribute,
          innerText: innerText,
          child: child,
          children: children,
          onClick: onClick,
        );

  @nonVirtual
  @override
  String get widgetType => 'Progress';

  @override
  DomTagType get correspondingTag => DomTagType.progress;

  @override
  bool shouldUpdateWidget(covariant Progress oldWidget) {
    return value != oldWidget.value ||
        max != oldWidget.max ||
        super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderElement(parent) => ProgressRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// Progress render element.
///
class ProgressRenderElement extends HTMLBaseElement {
  ProgressRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant Progress widget,
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
    required covariant Progress oldWidget,
    required covariant Progress newWidget,
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
  required Progress widget,
  required Progress? oldWidget,
}) {
  var attributes = <String, String?>{};

  if (null != widget.max) {
    attributes[Attributes.max] = '${widget.max}';
  } else {
    if (null != oldWidget?.max) {
      attributes[Attributes.max] = null;
    }
  }

  if (null != widget.value) {
    attributes[Attributes.value] = '${widget.value}';
  } else {
    if (null != oldWidget?.value) {
      attributes[Attributes.value] = null;
    }
  }

  return attributes;
}
