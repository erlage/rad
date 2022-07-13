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
    bool? hidden,
    bool? draggable,
    bool? contentEditable,
    int? tabIndex,
    String? title,
    String? style,
    String? classAttribute,
    String? onClickAttribute,
    String? innerText,
    List<Widget>? children,
    EventCallback? onClick,
    Map<String, String>? additionalAttributes,
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
          onClickAttribute: onClickAttribute,
          innerText: innerText,
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
class ButtonRenderElement extends HTMLBaseElement {
  ButtonRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant Button widget,
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
    required covariant Button oldWidget,
    required covariant Button newWidget,
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
  required Button widget,
  required Button? oldWidget,
}) {
  var attributes = <String, String?>{};

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

  return attributes;
}
