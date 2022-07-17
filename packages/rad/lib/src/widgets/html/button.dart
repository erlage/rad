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

/// The Button widget (HTML's `button` tag).
///
class Button extends HTMLWidgetBase {
  /// Associated Name.
  /// Used if Button is part of a form.
  ///
  final String? name;

  /// Value of Button.
  ///
  final String? value;

  /// Type of Button.
  ///
  final ButtonType? type;

  /// Whether Button is disabled.
  ///
  final bool? disabled;

  const Button({
    this.name,
    this.value,
    this.type,
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
  String get widgetType => 'Button';

  @override
  DomTagType get correspondingTag => DomTagType.button;

  @override
  bool shouldUpdateWidget(covariant Button oldWidget) {
    return name != oldWidget.name ||
        value != oldWidget.value ||
        type != oldWidget.type ||
        disabled != oldWidget.disabled ||
        super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderElement(parent) => ButtonRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// Button render element.
///
class ButtonRenderElement extends HTMLRenderElementBase {
  ButtonRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant Button widget,
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
    required covariant Button oldWidget,
    required covariant Button newWidget,
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
  required Button widget,
  required Button? oldWidget,
  required Map<String, String?> attributes,
}) {
  if (widget.name != oldWidget?.name) {
    attributes[Attributes.name] = widget.name;
  }

  if (widget.value != oldWidget?.value) {
    attributes[Attributes.value] = widget.value;
  }

  if (widget.type != oldWidget?.type) {
    attributes[Attributes.type] = widget.type?.nativeName;
  }

  if (widget.disabled != oldWidget?.disabled) {
    if (null == widget.disabled || false == widget.disabled) {
      attributes[Attributes.disabled] = null;
    } else {
      attributes[Attributes.disabled] = 'true';
    }
  }
}
