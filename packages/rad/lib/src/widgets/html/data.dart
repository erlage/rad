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
    var domNodeDescription = super.render(
      widget: widget,
    );

    domNodeDescription.attributes.addAll(
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
    required covariant Data oldWidget,
    required covariant Data newWidget,
  }) {
    var domNodeDescription = super.update(
      updateType: updateType,
      oldWidget: oldWidget,
      newWidget: newWidget,
    );

    domNodeDescription.attributes.addAll(
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
  required Data widget,
  required Data? oldWidget,
}) {
  var attributes = <String, String?>{};

  if (widget.value != oldWidget?.value) {
    attributes[Attributes.value] = widget.value;
  }

  return attributes;
}