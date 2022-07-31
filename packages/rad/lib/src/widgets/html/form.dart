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

/// The Form widget (HTML's `form` tag).
///
class Form extends HTMLWidgetBase {
  /// Name of the form.
  ///
  final String? name;

  /// Space-separated character encodings the server accepts. The browser uses
  /// them in the order in which they are listed. The default value means the
  /// same encoding as the page.
  ///
  final String? acceptCharset;

  /// Indicates whether input elements can by default have their values
  /// automatically completed by the browser.
  ///
  final String? autoComplete;

  /// Creates a hyperlink or annotation depending on the value.
  ///
  final String? rel;

  /// The URL that processes the form submission.
  ///
  final String? action;

  /// MIME type of the form submission.
  ///
  final FormEncType? enctype;

  /// The HTTP method to submit the form with.
  ///
  final FormMethodType? method;

  /// This Boolean attribute indicates that the form shouldn't be validated
  /// when submitted.
  ///
  final bool? noValidate;

  /// Indicates where to display the response after submitting the form.
  ///
  final String? target;

  /// On submit event listener.
  ///
  final EventCallback? onSubmit;

  const Form({
    this.name,
    this.acceptCharset,
    this.autoComplete,
    this.rel,
    this.action,
    this.method,
    this.enctype,
    this.noValidate,
    this.target,
    this.onSubmit,
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

  @nonVirtual
  @override
  DomTagType get correspondingTag => DomTagType.form;

  @override
  Map<DomEventType, EventCallback?> get widgetEventListeners {
    if (null == onClick && null == onSubmit) {
      return ccImmutableEmptyMapOfEventListeners;
    }

    return {
      DomEventType.click: onClick,
      DomEventType.submit: onSubmit,
    };
  }

  @override
  bool shouldUpdateWidget(covariant Form oldWidget) {
    return name != oldWidget.name ||
        acceptCharset != oldWidget.acceptCharset ||
        autoComplete != oldWidget.autoComplete ||
        rel != oldWidget.rel ||
        action != oldWidget.action ||
        enctype != oldWidget.enctype ||
        method != oldWidget.method ||
        noValidate != oldWidget.noValidate ||
        target != oldWidget.target ||
        super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderElement(parent) => FormRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// Form render element.
///
class FormRenderElement extends HTMLRenderElementBase {
  FormRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant Form widget,
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
    required covariant Form oldWidget,
    required covariant Form newWidget,
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
  required Form widget,
  required Form? oldWidget,
  required Map<String, String?> attributes,
}) {
  if (widget.name != oldWidget?.name) {
    attributes[Attributes.name] = widget.name;
  }

  if (widget.acceptCharset != oldWidget?.acceptCharset) {
    attributes[Attributes.acceptCharset] = widget.acceptCharset;
  }

  if (widget.autoComplete != oldWidget?.autoComplete) {
    attributes[Attributes.autoComplete] = widget.autoComplete;
  }

  if (widget.rel != oldWidget?.rel) {
    attributes[Attributes.rel] = widget.rel;
  }

  if (widget.action != oldWidget?.action) {
    attributes[Attributes.action] = widget.action;
  }

  if (widget.enctype != oldWidget?.enctype) {
    attributes[Attributes.enctype] = widget.enctype?.nativeValue;
  }

  if (widget.method != oldWidget?.method) {
    attributes[Attributes.method] = widget.method?.nativeValue;
  }

  if (widget.noValidate != oldWidget?.noValidate) {
    if (null == widget.noValidate || false == widget.noValidate) {
      attributes[Attributes.noValidate] = null;
    } else {
      attributes[Attributes.noValidate] = 'true';
    }
  }

  if (widget.target != oldWidget?.target) {
    attributes[Attributes.target] = widget.target;
  }
}
