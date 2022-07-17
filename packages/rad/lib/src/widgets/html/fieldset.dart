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

/// The FieldSet widget (HTML's `fieldset` tag).
///
/// Group several controls as well as labels (<label>) within a web form.
///
class FieldSet extends HTMLWidgetBase {
  /// Whether field set is disabled.
  ///
  final bool? disabled;

  const FieldSet({
    this.disabled,
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
  String get widgetType => 'FieldSet';

  @override
  DomTagType get correspondingTag => DomTagType.fieldSet;

  @override
  bool shouldUpdateWidget(covariant FieldSet oldWidget) {
    return disabled != oldWidget.disabled ||
        super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderElement(parent) => FieldSetRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// Field set render element.
///
class FieldSetRenderElement extends HTMLRenderElementBase {
  FieldSetRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant FieldSet widget,
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
    required covariant FieldSet oldWidget,
    required covariant FieldSet newWidget,
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
  required FieldSet widget,
  required FieldSet? oldWidget,
}) {
  var attributes = <String, String?>{};

  if (widget.disabled != oldWidget?.disabled) {
    if (null == widget.disabled || false == widget.disabled) {
      attributes[Attributes.disabled] = null;
    } else {
      attributes[Attributes.disabled] = 'true';
    }
  }

  return attributes;
}
