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

/// The Option widget (HTML's `option` tag).
///
class Option extends HTMLWidgetBase {
  /// The content of this attribute represents the value
  /// to be submitted with the form
  ///
  final String? value;

  /// This attribute is text for the label indicating the meaning
  /// of the option. If the label attribute isn't defined, its value
  /// is that of the dom node text content.
  ///
  final String? label;

  /// If present, this Boolean attribute indicates that the
  /// option is initially selected.
  ///
  final bool? selected;

  /// Whether Option is disabled.
  ///
  final bool? disabled;

  const Option({
    this.value,
    this.selected,
    this.disabled,
    this.label,
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
  String get widgetType => 'Option';

  @override
  DomTagType get correspondingTag => DomTagType.option;

  @override
  bool shouldUpdateWidget(covariant Option oldWidget) {
    return value != oldWidget.value ||
        label != oldWidget.label ||
        selected != oldWidget.selected ||
        disabled != oldWidget.disabled ||
        super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderElement(parent) => OptionRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// Option render element.
///
class OptionRenderElement extends HTMLRenderElementBase {
  OptionRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant Option widget,
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
    required covariant Option oldWidget,
    required covariant Option newWidget,
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
  required Option widget,
  required Option? oldWidget,
}) {
  var attributes = <String, String?>{};

  if (widget.value != oldWidget?.value) {
    attributes[Attributes.value] = widget.value;
  }

  if (widget.label != oldWidget?.label) {
    attributes[Attributes.label] = widget.label;
  }

  if (widget.selected != oldWidget?.selected) {
    if (null == widget.selected || false == widget.selected) {
      attributes[Attributes.selected] = null;
    } else {
      attributes[Attributes.selected] = 'true';
    }
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
