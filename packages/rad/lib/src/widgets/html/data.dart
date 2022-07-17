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

/// The Data widget (HTML's `data` tag).
///
class Data extends HTMLWidgetBase {
  /// This attribute specifies the machine-readable translation of the content
  /// of the element.
  ///
  final String? value;

  const Data({
    this.value,
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
  String get widgetType => 'Data';

  @override
  DomTagType get correspondingTag => DomTagType.data;

  @override
  bool shouldUpdateWidget(covariant Data oldWidget) {
    return value != oldWidget.value || super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderElement(parent) => DataRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// Data render element.
///
class DataRenderElement extends HTMLRenderElementBase {
  DataRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant Data widget,
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
    required covariant Data oldWidget,
    required covariant Data newWidget,
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
  required Data widget,
  required Data? oldWidget,
  required Map<String, String?> attributes,
}) {
  if (widget.value != oldWidget?.value) {
    attributes[Attributes.value] = widget.value;
  }
}
