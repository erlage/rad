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

/// The Input widget (HTML's `input` tag).
///
class Input extends HTMLWidgetBase {
  /// Type of input tag.
  ///
  final InputType? type;

  /// Name of the input. It's very common to use same name as key
  /// for inputs.
  ///
  final String? name;

  /// Initial value of control.
  ///
  final String? value;

  /// Defines the file types the file input should accept.
  ///
  final String? accept;

  /// Min length of input.
  ///
  final int? minLength;

  /// Max length of input.
  ///
  final int? maxLength;

  /// Match pattern for input.
  ///
  final String? pattern;

  /// Custom placeholder.
  ///
  final String? placeholder;

  /// Allows the user to select more than one file.
  ///
  final bool? multiple;

  /// Whether control is required.
  ///
  final bool? required;

  /// Whether control is disabled.
  ///
  final bool? disabled;

  /// Whether control is read only.
  ///
  final bool? readOnly;

  /// Whether control is checked.
  ///
  final bool? checked;

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

  const Input({
    this.type,
    this.name,
    this.value,
    this.accept,
    this.maxLength,
    this.minLength,
    this.pattern,
    this.placeholder,
    this.multiple,
    this.required,
    this.checked,
    this.readOnly,
    this.disabled,
    this.onInput,
    this.onChange,
    this.onKeyUp,
    this.onKeyDown,
    this.onKeyPress,
    Key? key,
    String? id,
    String? title,
    String? style,
    String? className,
    int? tabIndex,
    bool? draggable,
    bool? contentEditable,
    bool? hidden,
    String? innerText,
    List<Widget>? children,
    EventCallback? onClick,
    Map<String, String>? additionalAttributes,
  }) : super(
          key: key,
          id: id,
          title: title,
          style: style,
          className: className,
          tabIndex: tabIndex,
          draggable: draggable,
          contentEditable: contentEditable,
          hidden: hidden,
          innerText: innerText,
          children: children,
          onClick: onClick,
          additionalAttributes: additionalAttributes,
        );

  @nonVirtual
  @override
  DomTagType get correspondingTag => DomTagType.input;

  @nonVirtual
  @override
  String get widgetType => 'Input';

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
  bool shouldUpdateWidget(covariant Input oldWidget) {
    return type != oldWidget.type ||
        name != oldWidget.name ||
        value != oldWidget.value ||
        accept != oldWidget.accept ||
        minLength != oldWidget.minLength ||
        maxLength != oldWidget.maxLength ||
        pattern != oldWidget.pattern ||
        placeholder != oldWidget.placeholder ||
        multiple != oldWidget.multiple ||
        checked != oldWidget.checked ||
        required != oldWidget.required ||
        readOnly != oldWidget.readOnly ||
        disabled != oldWidget.disabled ||
        super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderElement(parent) => InputRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// Input render element.
///
class InputRenderElement extends HTMLRenderElementBase {
  InputRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant Input widget,
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
    required covariant Input oldWidget,
    required covariant Input newWidget,
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
  required Input widget,
  required Input? oldWidget,
}) {
  var attributes = <String, String?>{};

  if (widget.type != oldWidget?.type) {
    attributes[Attributes.type] = widget.type?.nativeName;
  }

  if (widget.name != oldWidget?.name) {
    attributes[Attributes.name] = widget.name;
  }

  if (widget.value != oldWidget?.value) {
    attributes[Attributes.value] = widget.value;
  }

  if (widget.accept != oldWidget?.accept) {
    attributes[Attributes.accept] = widget.accept;
  }

  if (widget.placeholder != oldWidget?.placeholder) {
    attributes[Attributes.placeholder] = widget.placeholder;
  }

  if (widget.pattern != oldWidget?.pattern) {
    attributes[Attributes.pattern] = widget.pattern;
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

  if (widget.multiple != oldWidget?.multiple) {
    if (null == widget.multiple || false == widget.multiple) {
      attributes[Attributes.multiple] = null;
    } else {
      attributes[Attributes.multiple] = 'true';
    }
  }

  if (widget.checked != oldWidget?.checked) {
    if (null == widget.checked || false == widget.checked) {
      attributes[Attributes.checked] = null;
    } else {
      attributes[Attributes.checked] = 'true';
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
