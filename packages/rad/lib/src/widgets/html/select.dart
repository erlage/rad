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
class SelectRenderElement extends HTMLBaseElement {
  SelectRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant Select widget,
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
    required covariant Select oldWidget,
    required covariant Select newWidget,
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
  required Select widget,
  required Select? oldWidget,
}) {
  var attributes = <String, String?>{};

  if (null != widget.name) {
    attributes[Attributes.name] = widget.name;
  } else {
    if (null != oldWidget?.name) {
      attributes[Attributes.name] = null;
    }
  }

  if (null != widget.multiple && widget.multiple!) {
    attributes[Attributes.multiple] = '${widget.multiple}';
  } else {
    if (null != oldWidget?.multiple) {
      attributes[Attributes.multiple] = null;
    }
  }

  if (null != widget.disabled && widget.disabled!) {
    attributes[Attributes.disabled] = '${widget.disabled}';
  } else {
    if (null != oldWidget?.disabled) {
      attributes[Attributes.disabled] = null;
    }
  }

  return attributes;
}
