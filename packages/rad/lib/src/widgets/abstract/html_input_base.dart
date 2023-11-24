// Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/dom_node_patch.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/html_widget_base.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/html/data_list.dart';

/// Base class for Input* widgets.
///
@internal
abstract class HTMLInputBase extends HTMLWidgetBase {
  /// The accept attribute defines which file types are selectable in a file
  /// upload control.
  ///
  final String? accept;

  /// The alt attribute provides alternative text for the image.
  ///
  final String? alt;

  /// The autocomplete attribute takes as its value a space-separated string
  /// that describes what, if any, type of autocomplete functionality the input
  /// should provide.
  ///
  final String? autoComplete;

  /// The capture attribute defines which media—microphone, video, or camera
  /// — should be used to capture a new file for upload with file upload
  /// control in supporting scenarios.
  ///
  final String? capture;

  /// If present on a radio type, it indicates that the radio button is the
  /// currently selected one in the group of same-named radio buttons. If
  /// present on a checkbox type, it indicates that the checkbox is checked by
  /// default (when the page loads).
  ///
  final bool? checked;

  /// The dirname attribute enables the submission of the directionality of the
  /// element.
  ///
  final String? dirName;

  /// Disabled inputs are typically rendered with a dimmer color or using some
  /// other form of indication that the field is not available for use.
  ///
  final bool? disabled;

  /// The form element to associate the button with (its form owner).
  /// The value of this attribute must be the id of a form in the same
  /// document. (If this attribute is not set, the button is associated with
  /// its ancestor form element, if any.).
  ///
  final String? form;

  /// The URL that processes the information submitted by the button. Overrides
  /// the action attribute of the button's form owner. Does nothing if there is
  /// no form owner.
  ///
  final String? formAction;

  /// If the button is a submit button (it's inside/associated with a form
  /// and doesn't have type="button").
  ///
  final FormEncType? formEncType;

  /// If the button is a submit button (it's inside/associated with a form and
  /// doesn't have type="button"), this attribute specifies the HTTP method
  /// used to submit the form.
  ///
  final FormMethodType? formMethod;

  /// f the button is a submit button, this attribute is an author-defined
  /// name or standardized, underscore-prefixed keyword indicating where to
  /// display the response from submitting the form.
  ///
  final String? formTarget;

  /// If the button is a submit button, this Boolean attribute specifies that
  /// the form is not to be validated when it is submitted. If this attribute
  /// is specified, it overrides the novalidate attribute of the button's form
  /// owner.
  ///
  final bool? formNoValidate;

  /// Valid for the image input button only, the height is the height of the
  /// image file to display to represent the graphical submit button.
  ///
  final String? height;

  /// Global value valid for all elements, it provides a hint to browsers as to
  /// the type of virtual keyboard configuration to use when editing this
  /// element or its contents. Values include none, text, tel, url, email,
  /// numeric, decimal, and search.
  ///
  final String? inputMode;

  /// The value given to the list attribute should be the id of a [DataList]
  /// element located in the same document. The [DataList] provides a list of
  /// predefined values to suggest to the user for this input.
  ///
  final String? list;

  /// Max number of characters.
  ///
  final String? max;

  /// Max length of input.
  ///
  final int? maxLength;

  /// Min number of characters.
  ///
  final String? min;

  /// Min length of input.
  ///
  final int? minLength;

  /// The Boolean multiple attribute, if set, means the user can enter comma
  /// separated email addresses in the email widget or can choose more than one
  /// file with the file input.
  ///
  final bool? multiple;

  /// A string specifying a name for the input control. This name is submitted
  /// along with the control's value when the form data is submitted.
  ///
  final String? name;

  /// Valid for text, search, url, tel, email, and password, the pattern
  /// attribute defines a regular expression that the input's value must match
  /// in order for the value to pass constraint validation.
  ///
  final String? pattern;

  /// Valid for text, search, url, tel, email, password, and number, the
  /// placeholder attribute provides a brief hint to the user as to what kind
  /// of information is expected in the field.
  ///
  final String? placeholder;

  /// A Boolean attribute which, if present, indicates that the user should not
  /// be able to edit the value of the input.
  ///
  final bool? readOnly;

  /// Boolean attribute which, if present, indicates that the user must specify
  /// a value for the input before the owning form can be submitted.
  ///
  final bool? required;

  /// Valid for email, password, tel, url, and text, the size attribute
  /// specifies how much of the input is shown.
  ///
  final String? size;

  /// Valid for the image input button only, the src is string specifying the
  /// URL of the image file to display to represent the graphical submit button.
  ///
  final String? src;

  /// Valid for date, month, week, time, datetime-local, number, and range, the
  /// step attribute is a number that specifies the granularity that the value
  /// must adhere to.
  ///
  final String? step;

  /// An integer attribute indicating if the element can take input focus
  /// (is focus-able), if it should participate to sequential keyboard
  /// navigation.
  ///
  final int? tabIndex;

  /// Type of Input.
  ///
  final InputType? type;

  /// The input control's value.
  ///
  final String? value;

  /// Valid for the image input button only, the width is the width of the
  /// image file to display to represent the graphical submit button.
  ///
  final String? width;

  /// The input control's value property.
  ///
  final String? valueProperty;

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

  const HTMLInputBase({
    this.accept,
    this.alt,
    this.autoComplete,
    this.capture,
    this.checked,
    this.dirName,
    this.disabled,
    this.form,
    this.formAction,
    this.formEncType,
    this.formMethod,
    this.formTarget,
    this.formNoValidate,
    this.height,
    this.inputMode,
    this.list,
    this.max,
    this.maxLength,
    this.min,
    this.minLength,
    this.multiple,
    this.name,
    this.pattern,
    this.placeholder,
    this.readOnly,
    this.required,
    this.size,
    this.src,
    this.step,
    this.tabIndex,
    this.type,
    this.value,
    this.width,
    this.valueProperty,
    this.onInput,
    this.onChange,
    this.onKeyUp,
    this.onKeyDown,
    this.onKeyPress,
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
  Map<DomEventType, EventCallback?> get widgetEventListeners => {
        DomEventType.click: onClick,
        DomEventType.input: onInput,
        DomEventType.change: onChange,
        DomEventType.keyUp: onKeyUp,
        DomEventType.keyDown: onKeyDown,
        DomEventType.keyPress: onKeyPress,
      };

  @nonVirtual
  @override
  DomTagType? get correspondingTag => DomTagType.input;

  @override
  bool shouldUpdateWidget(
    covariant HTMLInputBase oldWidget,
  ) {
    return accept != oldWidget.accept ||
        alt != oldWidget.alt ||
        autoComplete != oldWidget.autoComplete ||
        capture != oldWidget.capture ||
        checked != oldWidget.checked ||
        dirName != oldWidget.dirName ||
        disabled != oldWidget.disabled ||
        form != oldWidget.form ||
        formAction != oldWidget.formAction ||
        formEncType != oldWidget.formEncType ||
        formMethod != oldWidget.formMethod ||
        formTarget != oldWidget.formTarget ||
        formNoValidate != oldWidget.formNoValidate ||
        height != oldWidget.height ||
        inputMode != oldWidget.inputMode ||
        list != oldWidget.list ||
        max != oldWidget.max ||
        maxLength != oldWidget.maxLength ||
        min != oldWidget.min ||
        minLength != oldWidget.minLength ||
        multiple != oldWidget.multiple ||
        name != oldWidget.name ||
        pattern != oldWidget.pattern ||
        placeholder != oldWidget.placeholder ||
        readOnly != oldWidget.readOnly ||
        required != oldWidget.required ||
        size != oldWidget.size ||
        src != oldWidget.src ||
        step != oldWidget.step ||
        tabIndex != oldWidget.tabIndex ||
        type != oldWidget.type ||
        value != oldWidget.value ||
        width != oldWidget.width ||
        valueProperty != oldWidget.valueProperty ||
        super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderElement(parent) => HTMLInputBaseRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// Table column base render element.
///
@internal
class HTMLInputBaseRenderElement extends HTMLRenderElementBase {
  HTMLInputBaseRenderElement(super.widget, super.parent);

  @mustCallSuper
  @override
  DomNodePatchFillable render({
    required covariant HTMLInputBase widget,
  }) {
    var domNodePatch = super.render(
      widget: widget,
    );

    _extendAttributes(
      widget: widget,
      oldWidget: null,
      attributes: domNodePatch.attributes,
    );

    _extendProperties(
      widget: widget,
      oldWidget: null,
      properties: domNodePatch.properties,
    );

    return domNodePatch;
  }

  @mustCallSuper
  @override
  DomNodePatchFillable update({
    required updateType,
    required covariant HTMLInputBase oldWidget,
    required covariant HTMLInputBase newWidget,
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

    _extendProperties(
      widget: newWidget,
      oldWidget: oldWidget,
      properties: domNodePatch.properties,
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
  required HTMLInputBase widget,
  required HTMLInputBase? oldWidget,
  required Map<String, String?> attributes,
}) {
  if (widget.accept != oldWidget?.accept) {
    attributes[Attributes.accept] = widget.accept;
  }

  if (widget.alt != oldWidget?.alt) {
    attributes[Attributes.alt] = widget.alt;
  }

  if (widget.autoComplete != oldWidget?.autoComplete) {
    attributes[Attributes.autoComplete] = widget.autoComplete;
  }

  if (widget.capture != oldWidget?.capture) {
    attributes[Attributes.capture] = widget.capture;
  }

  if (widget.checked != oldWidget?.checked) {
    if (null == widget.checked || false == widget.checked) {
      attributes[Attributes.checked] = null;
    } else {
      attributes[Attributes.checked] = 'true';
    }
  }

  if (widget.dirName != oldWidget?.dirName) {
    attributes[Attributes.dirName] = widget.dirName;
  }

  if (widget.disabled != oldWidget?.disabled) {
    if (null == widget.disabled || false == widget.disabled) {
      attributes[Attributes.disabled] = null;
    } else {
      attributes[Attributes.disabled] = 'true';
    }
  }

  if (widget.form != oldWidget?.form) {
    attributes[Attributes.form] = widget.form;
  }

  if (widget.formAction != oldWidget?.formAction) {
    attributes[Attributes.formAction] = widget.formAction;
  }

  if (widget.formEncType != oldWidget?.formEncType) {
    attributes[Attributes.formEncType] = widget.formEncType?.nativeValue;
  }

  if (widget.formMethod != oldWidget?.formMethod) {
    attributes[Attributes.formMethod] = widget.formMethod?.nativeValue;
  }

  if (widget.formTarget != oldWidget?.formTarget) {
    attributes[Attributes.formTarget] = widget.formTarget;
  }

  if (widget.formNoValidate != oldWidget?.formNoValidate) {
    if (null == widget.formNoValidate || false == widget.formNoValidate) {
      attributes[Attributes.formNoValidate] = null;
    } else {
      attributes[Attributes.formNoValidate] = 'true';
    }
  }

  if (widget.height != oldWidget?.height) {
    attributes[Attributes.height] = widget.height;
  }

  if (widget.inputMode != oldWidget?.inputMode) {
    attributes[Attributes.inputMode] = widget.inputMode;
  }

  if (widget.list != oldWidget?.list) {
    attributes[Attributes.list] = widget.list;
  }

  if (widget.max != oldWidget?.max) {
    attributes[Attributes.max] = widget.max;
  }

  if (widget.maxLength != oldWidget?.maxLength) {
    if (null == widget.maxLength) {
      attributes[Attributes.maxLength] = null;
    } else {
      attributes[Attributes.maxLength] = '${widget.maxLength}';
    }
  }

  if (widget.min != oldWidget?.min) {
    attributes[Attributes.min] = widget.min;
  }

  if (widget.minLength != oldWidget?.minLength) {
    if (null == widget.minLength) {
      attributes[Attributes.minLength] = null;
    } else {
      attributes[Attributes.minLength] = '${widget.minLength}';
    }
  }

  if (widget.multiple != oldWidget?.multiple) {
    if (null == widget.multiple || false == widget.multiple) {
      attributes[Attributes.multiple] = null;
    } else {
      attributes[Attributes.multiple] = 'true';
    }
  }

  if (widget.name != oldWidget?.name) {
    attributes[Attributes.name] = widget.name;
  }

  if (widget.pattern != oldWidget?.pattern) {
    attributes[Attributes.pattern] = widget.pattern;
  }

  if (widget.placeholder != oldWidget?.placeholder) {
    attributes[Attributes.placeholder] = widget.placeholder;
  }

  if (widget.readOnly != oldWidget?.readOnly) {
    if (null == widget.readOnly || false == widget.readOnly) {
      attributes[Attributes.readOnly] = null;
    } else {
      attributes[Attributes.readOnly] = 'true';
    }
  }

  if (widget.required != oldWidget?.required) {
    if (null == widget.required || false == widget.required) {
      attributes[Attributes.required] = null;
    } else {
      attributes[Attributes.required] = 'true';
    }
  }

  if (widget.size != oldWidget?.size) {
    attributes[Attributes.size] = widget.size;
  }

  if (widget.src != oldWidget?.src) {
    attributes[Attributes.src] = widget.src;
  }

  if (widget.step != oldWidget?.step) {
    attributes[Attributes.step] = widget.step;
  }

  if (widget.tabIndex != oldWidget?.tabIndex) {
    if (null == widget.tabIndex) {
      attributes[Attributes.tabIndex] = null;
    } else {
      attributes[Attributes.tabIndex] = '${widget.tabIndex}';
    }
  }

  if (widget.type != oldWidget?.type) {
    attributes[Attributes.type] = widget.type?.nativeValue;
  }

  if (widget.value != oldWidget?.value) {
    attributes[Attributes.value] = widget.value;
  }

  if (widget.width != oldWidget?.width) {
    attributes[Attributes.width] = widget.width;
  }
}

void _extendProperties({
  required HTMLInputBase widget,
  required HTMLInputBase? oldWidget,
  required Map<String, String?> properties,
}) {
  if (widget.valueProperty != oldWidget?.valueProperty) {
    properties[Properties.value] = widget.valueProperty;
  }
}
