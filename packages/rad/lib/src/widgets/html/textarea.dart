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

/// The TextArea widget (HTML's `textarea` tag).
///
/// This HTML dom node represents a multi-line plain-text editing control,
/// useful when you want to allow users to enter a sizeable amount of free-form
/// text, for example a comment on a review or feedback form.
///
class TextArea extends HTMLWidgetBase {
  final String? name;

  final String? value;
  final String? placeholder;

  final int? rows;
  final int? cols;
  final int? minLength;
  final int? maxLength;

  final bool? required;
  final bool? readOnly;
  final bool? disabled;

  /// On input event listener.
  ///
  final EventCallback? onInput;

  /// On change event listener.
  ///
  final EventCallback? onChange;

  /// On key up event listener.
  ///
  final EventCallback? onKeyUp;

  /// On key down event listener.
  ///
  final EventCallback? onKeyDown;

  /// On key press event listener.
  ///
  final EventCallback? onKeyPress;

  const TextArea({
    this.name,
    this.value,
    this.placeholder,
    this.rows,
    this.cols,
    this.minLength,
    this.maxLength,
    this.required,
    this.readOnly,
    this.disabled,
    this.onChange,
    this.onInput,
    this.onKeyUp,
    this.onKeyDown,
    this.onKeyPress,
    Key? key,
    String? id,
    bool? hidden,
    bool? draggable,
    bool? contentEditable,
    int? tabIndex,
    String? title,
    String? style,
    String? className,
    String? innerText,
    Widget? child,
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
          className: className,
          innerText: innerText,
          child: child,
          children: children,
          onClick: onClick,
          additionalAttributes: additionalAttributes,
        );

  @nonVirtual
  @override
  String get widgetType => 'TextArea';

  @override
  DomTagType get correspondingTag => DomTagType.textArea;

  @override
  Map<DomEventType, EventCallback?> get widgetEventListeners => {
        DomEventType.click: onClick,
        DomEventType.input: onInput,
        DomEventType.change: onChange,
        DomEventType.keyUp: onKeyUp,
        DomEventType.keyDown: onKeyDown,
        DomEventType.keyPress: onKeyPress,
      };

  @override
  bool shouldUpdateWidget(covariant TextArea oldWidget) {
    return name != oldWidget.name ||
        value != oldWidget.value ||
        placeholder != oldWidget.placeholder ||
        rows != oldWidget.rows ||
        cols != oldWidget.cols ||
        minLength != oldWidget.minLength ||
        maxLength != oldWidget.maxLength ||
        required != oldWidget.required ||
        readOnly != oldWidget.readOnly ||
        disabled != oldWidget.disabled ||
        super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderElement(parent) => TextAreaRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// Text area render element.
///
class TextAreaRenderElement extends HTMLRenderElementBase {
  TextAreaRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant TextArea widget,
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

    domNodeDescription?.properties?.addAll(
      _prepareProperties(
        widget: widget,
        oldWidget: null,
      ),
    );

    return domNodeDescription;
  }

  @override
  update({
    required updateType,
    required covariant TextArea oldWidget,
    required covariant TextArea newWidget,
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

    domNodeDescription?.properties?.addAll(
      _prepareProperties(
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
  required TextArea widget,
  required TextArea? oldWidget,
}) {
  var attributes = <String, String?>{};

  if (widget.name != oldWidget?.name) {
    attributes[Attributes.name] = widget.name;
  }

  if (widget.placeholder != oldWidget?.placeholder) {
    attributes[Attributes.placeholder] = widget.placeholder;
  }

  if (widget.rows != oldWidget?.rows) {
    if (null == widget.rows) {
      attributes[Attributes.rows] = null;
    } else {
      attributes[Attributes.rows] = '${widget.rows}';
    }
  }

  if (widget.cols != oldWidget?.cols) {
    if (null == widget.cols) {
      attributes[Attributes.cols] = null;
    } else {
      attributes[Attributes.cols] = '${widget.cols}';
    }
  }

  if (widget.minLength != oldWidget?.minLength) {
    if (null == widget.minLength) {
      attributes[Attributes.minLength] = null;
    } else {
      attributes[Attributes.minLength] = '${widget.minLength}';
    }
  }

  if (widget.maxLength != oldWidget?.maxLength) {
    if (null == widget.maxLength) {
      attributes[Attributes.maxLength] = null;
    } else {
      attributes[Attributes.maxLength] = '${widget.maxLength}';
    }
  }

  if (widget.required != oldWidget?.required) {
    if (null == widget.required || false == widget.required) {
      attributes[Attributes.required] = null;
    } else {
      attributes[Attributes.required] = 'true';
    }
  }

  if (widget.readOnly != oldWidget?.readOnly) {
    if (null == widget.readOnly || false == widget.readOnly) {
      attributes[Attributes.readOnly] = null;
    } else {
      attributes[Attributes.readOnly] = 'true';
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

Map<String, String?> _prepareProperties({
  required TextArea widget,
  required TextArea? oldWidget,
}) {
  var properties = <String, String?>{};

  if (widget.value != oldWidget?.value) {
    properties[Properties.value] = widget.value;
  }

  return properties;
}
