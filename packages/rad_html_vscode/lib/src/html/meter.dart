// Copyright 2022 H. Singh<hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:html';

import 'package:meta/meta.dart';
import 'package:rad/rad.dart';

import 'package:rad_html_vscode/src/abstract/html_widget_base.dart';
import 'package:rad_html_vscode/src/patch.dart';

/// The Meter widget (HTML's `meter` tag).
///
@internal
class Meter extends HTMLWidgetBase {
  /// The current numeric value.
  ///
  final int? value;

  /// The upper numeric bound of the measured range.
  ///
  final int? max;

  /// The lower numeric bound of the measured range.
  ///
  final int? min;

  /// The lower numeric bound of the high end of the measured range.
  ///
  final int? high;

  /// The upper numeric bound of the low end of the measured range.
  ///
  final int? low;

  /// This attribute indicates the optimal numeric value.
  ///
  final int? optimum;

  const Meter(
    List<Widget> children, {
    this.value,
    this.max,
    this.min,
    this.high,
    this.low,
    this.optimum,
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
  DomTagType get correspondingTag => DomTagType.meter;

  @override
  bool shouldUpdateWidget(covariant Meter oldWidget) {
    return value != oldWidget.value ||
        max != oldWidget.max ||
        min != oldWidget.min ||
        high != oldWidget.high ||
        low != oldWidget.low ||
        optimum != oldWidget.optimum ||
        super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderElement(parent) => MeterRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// Meter render element.
///
class MeterRenderElement extends HTMLRenderElementBase {
  MeterRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant Meter widget,
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
    required covariant Meter oldWidget,
    required covariant Meter newWidget,
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
  required Meter widget,
  required Meter? oldWidget,
  required Map<String, String?> attributes,
}) {
  if (widget.value != oldWidget?.value) {
    if (null == widget.value) {
      attributes[Attributes.value] = null;
    } else {
      attributes[Attributes.value] = '${widget.value}';
    }
  }

  if (widget.max != oldWidget?.max) {
    if (null == widget.max) {
      attributes[Attributes.max] = null;
    } else {
      attributes[Attributes.max] = '${widget.max}';
    }
  }

  if (widget.min != oldWidget?.min) {
    if (null == widget.min) {
      attributes[Attributes.min] = null;
    } else {
      attributes[Attributes.min] = '${widget.min}';
    }
  }

  if (widget.low != oldWidget?.low) {
    if (null == widget.low) {
      attributes[Attributes.low] = null;
    } else {
      attributes[Attributes.low] = '${widget.low}';
    }
  }

  if (widget.high != oldWidget?.high) {
    if (null == widget.high) {
      attributes[Attributes.high] = null;
    } else {
      attributes[Attributes.high] = '${widget.high}';
    }
  }

  if (widget.optimum != oldWidget?.optimum) {
    if (null == widget.optimum) {
      attributes[Attributes.optimum] = null;
    } else {
      attributes[Attributes.optimum] = '${widget.optimum}';
    }
  }
}
