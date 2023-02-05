// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/cache.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/html_widget_base.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The Select widget (HTML's `select` tag).
///
/// This HTML dom node represents a control that provides a menu of options.
///
class Select extends HTMLWidgetBase {
  /// A string providing a hint for a user agent's autocomplete feature.
  ///
  final String? autoComplete;

  /// Associated Name.
  /// Used if Select is part of a form.
  ///
  final String? name;

  /// The form element to associate the select with (its form owner).
  ///
  final String? form;

  /// If the control is presented as a scrolling list box (e.g. when multiple
  /// is specified), this attribute represents the number of rows in the list
  /// that should be visible at one time.
  ///
  final String? size;

  /// This Boolean attribute indicates that multiple options
  /// can be selected in the list.
  ///
  final bool? multiple;

  /// A Boolean attribute indicating that an option with a non-empty string
  /// value must be selected.
  ///
  final bool? required;

  /// Whether Select is disabled.
  ///
  final bool? disabled;

  /// On change event listener.
  ///
  final EventCallback? onChange;

  const Select({
    this.autoComplete,
    this.name,
    this.form,
    this.size,
    this.multiple,
    this.required,
    this.disabled,
    this.onChange,
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
  DomTagType get correspondingTag => DomTagType.select;

  @override
  Map<DomEventType, EventCallback?> get widgetEventListeners {
    if (null == onClick && null == onChange) {
      return ccImmutableEmptyMapOfEventListeners;
    }

    return {
      DomEventType.click: onClick,
      DomEventType.change: onChange,
    };
  }

  @override
  bool shouldUpdateWidget(covariant Select oldWidget) {
    return autoComplete != oldWidget.autoComplete ||
        name != oldWidget.name ||
        form != oldWidget.form ||
        size != oldWidget.size ||
        required != oldWidget.required ||
        multiple != oldWidget.multiple ||
        disabled != oldWidget.disabled ||
        super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderElement(parent) => SelectRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// Select render element.
///
class SelectRenderElement extends HTMLRenderElementBase {
  SelectRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant Select widget,
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
    required covariant Select oldWidget,
    required covariant Select newWidget,
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
  required Select widget,
  required Select? oldWidget,
  required Map<String, String?> attributes,
}) {
  if (widget.autoComplete != oldWidget?.autoComplete) {
    attributes[Attributes.autoComplete] = widget.autoComplete;
  }

  if (widget.name != oldWidget?.name) {
    attributes[Attributes.name] = widget.name;
  }

  if (widget.form != oldWidget?.form) {
    attributes[Attributes.form] = widget.form;
  }

  if (widget.size != oldWidget?.size) {
    attributes[Attributes.size] = widget.size;
  }

  if (widget.required != oldWidget?.required) {
    if (null == widget.required || false == widget.required) {
      attributes[Attributes.required] = null;
    } else {
      attributes[Attributes.required] = 'true';
    }
  }

  if (widget.multiple != oldWidget?.multiple) {
    if (null == widget.multiple || false == widget.multiple) {
      attributes[Attributes.multiple] = null;
    } else {
      attributes[Attributes.multiple] = 'true';
    }
  }

  if (widget.disabled != oldWidget?.disabled) {
    if (null == widget.disabled || false == widget.disabled) {
      attributes[Attributes.disabled] = null;
    } else {
      attributes[Attributes.disabled] = 'true';
    }
  }
}
