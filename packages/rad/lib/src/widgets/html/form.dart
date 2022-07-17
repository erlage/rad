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

  /// The URL that processes the form submission.
  ///
  final String? action;

  /// Comma-separated content types the server accepts.
  ///
  final String? accept;

  /// MIME type of the form submission.
  ///
  final FormEncType? enctype;

  /// The HTTP method to submit the form with.
  ///
  final FormMethodType? method;

  /// Indicates where to display the response after submitting the form.
  ///
  final String? target;

  /// On submit event listener.
  ///
  final EventCallback? onSubmit;

  const Form({
    this.name,
    this.action,
    this.accept,
    this.enctype,
    this.target,
    this.method,
    this.onSubmit,
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
  DomTagType get correspondingTag => DomTagType.form;

  @override
  String get widgetType => 'Form';

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
        action != oldWidget.action ||
        accept != oldWidget.accept ||
        target != oldWidget.target ||
        enctype != oldWidget.enctype ||
        method != oldWidget.method ||
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

  if (widget.action != oldWidget?.action) {
    attributes[Attributes.action] = widget.action;
  }

  if (widget.accept != oldWidget?.accept) {
    attributes[Attributes.accept] = widget.accept;
  }

  if (widget.target != oldWidget?.target) {
    attributes[Attributes.target] = widget.target;
  }

  if (widget.method != oldWidget?.method) {
    attributes[Attributes.method] = widget.method?.nativeName;
  }

  if (widget.enctype != oldWidget?.enctype) {
    attributes[Attributes.enctype] = widget.enctype?.nativeName;
  }
}
