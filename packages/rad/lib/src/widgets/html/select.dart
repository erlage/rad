// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

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
  /// Associated Name.
  /// Used if Select is part of a form.
  ///
  final String? name;

  /// This Boolean attribute indicates that multiple options
  /// can be selected in the list.
  ///
  final bool? multiple;

  /// Whether Select is disabled.
  ///
  final bool? disabled;

  /// On change event listener.
  ///
  final EventCallback? onChange;

  const Select({
    this.name,
    this.multiple,
    this.disabled,
    this.onChange,
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
  String get widgetType => 'Select';

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
    return name != oldWidget.name ||
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
  if (widget.name != oldWidget?.name) {
    attributes[Attributes.name] = widget.name;
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
