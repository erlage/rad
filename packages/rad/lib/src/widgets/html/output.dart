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

/// The Output widget (HTML's `output` tag).
///
class Output extends HTMLWidgetBase {
  /// The element's name.
  ///
  final String? name;

  /// The form element to associate the output with (its form owner). The
  /// value of this attribute must be the id of a form in the same document.
  ///
  final String? form;

  /// A space-separated list of other element's ids.
  ///
  final String? forAttribute;

  const Output({
    this.name,
    this.form,
    this.forAttribute,
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
  String get widgetType => 'Output';

  @override
  DomTagType get correspondingTag => DomTagType.output;

  @override
  bool shouldUpdateWidget(covariant Output oldWidget) {
    return name != oldWidget.name ||
        form != oldWidget.form ||
        forAttribute != oldWidget.forAttribute ||
        super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderElement(parent) => OutputRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// Output render element.
///
class OutputRenderElement extends HTMLRenderElementBase {
  OutputRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant Output widget,
  }) {
    var domNodeDescription = super.render(
      widget: widget,
    );

    domNodeDescription.attributes.addAll(
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
    required covariant Output oldWidget,
    required covariant Output newWidget,
  }) {
    var domNodeDescription = super.update(
      updateType: updateType,
      oldWidget: oldWidget,
      newWidget: newWidget,
    );

    domNodeDescription.attributes.addAll(
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
  required Output widget,
  required Output? oldWidget,
}) {
  var attributes = <String, String?>{};

  if (widget.name != oldWidget?.name) {
    attributes[Attributes.name] = widget.name;
  }

  if (widget.form != oldWidget?.form) {
    attributes[Attributes.form] = widget.form;
  }

  if (widget.forAttribute != oldWidget?.forAttribute) {
    attributes[Attributes.forAttribute] = widget.forAttribute;
  }

  return attributes;
}
