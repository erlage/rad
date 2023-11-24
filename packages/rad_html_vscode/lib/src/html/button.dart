// Copyright 2022 H. Singh<hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:html';

import 'package:meta/meta.dart';
import 'package:rad/rad.dart';

import 'package:rad_html_vscode/src/abstract/html_widget_base.dart';
import 'package:rad_html_vscode/src/patch.dart';

/// The Button widget (HTML's `button` tag).
///
@internal
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

  const Button(
    List<Widget> children, {
    this.name,
    this.value,
    this.type,
    this.disabled,
    this.form,
    this.formAction,
    this.formEncType,
    this.formMethod,
    this.formTarget,
    this.formNoValidate,
    Key? key,
    void Function(Element? element)? ref,
    String? id,
    String? title,
    String? style,
    String? className,
    bool? hidden,
    EventCallback? onClick,
    Map<String, String>? additionalAttributes,
  }) : super(
          children,
          key: key,
          ref: ref,
          id: id,
          title: title,
          style: style,
          className: className,
          hidden: hidden,
          onClick: onClick,
          additionalAttributes: additionalAttributes,
        );

  @override
  DomTagType get correspondingTag => DomTagType.button;

  @override
  bool shouldUpdateWidget(covariant Button oldWidget) {
    return name != oldWidget.name ||
        value != oldWidget.value ||
        type != oldWidget.type ||
        disabled != oldWidget.disabled ||
        form != oldWidget.form ||
        formAction != oldWidget.formAction ||
        formEncType != oldWidget.formEncType ||
        formMethod != oldWidget.formMethod ||
        formTarget != oldWidget.formTarget ||
        formNoValidate != oldWidget.formNoValidate ||
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
    attributes[Attributes.type] = widget.type?.nativeValue;
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
}
