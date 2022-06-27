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

/// The Label widget (HTML's `label` tag).
///
class Label extends HTMLWidgetBase {
  /// The value of the [forAttribute] attribute must be a single key for a
  /// labelable form-related dom node in the same document as the <label> dom
  /// node
  ///
  final String? forAttribute;

  const Label({
    Key? key,
    String? id,
    this.forAttribute,
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
  String get widgetType => 'Label';

  @override
  DomTagType get correspondingTag => DomTagType.label;

  @override
  bool shouldUpdateWidget(covariant Label oldWidget) {
    return forAttribute != oldWidget.forAttribute ||
        super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderElement(parent) => LabelRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// Label render element.
///
class LabelRenderElement extends HTMLBaseElement {
  LabelRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant Label widget,
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
    required covariant Label oldWidget,
    required covariant Label newWidget,
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
  required Label widget,
  required Label? oldWidget,
}) {
  var attributes = <String, String?>{};

  if (widget.forAttribute != oldWidget?.forAttribute) {
    attributes[Attributes.forAttribute] = widget.forAttribute;
  }

  return attributes;
}
