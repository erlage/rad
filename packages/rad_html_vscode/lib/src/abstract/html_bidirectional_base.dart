// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:html';

import 'package:meta/meta.dart';
import 'package:rad/rad.dart';

import 'package:rad_html_vscode/src/abstract/html_widget_base.dart';
import 'package:rad_html_vscode/src/patch.dart';

/// Abstract class for Bidirectional HTML widgets.
///
@internal
abstract class HTMLBidirectionalBase extends HTMLWidgetBase {
  /// The direction in which text should be rendered.
  ///
  final DirectionType? dir;

  const HTMLBidirectionalBase(
    List<Widget> children, {
    this.dir,
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
  bool shouldUpdateWidget(
    covariant oldWidget,
  ) {
    oldWidget as HTMLBidirectionalBase;

    return dir != oldWidget.dir || super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderElement(parent) {
    return HTMLBidirectionalBaseRenderElement(this, parent);
  }
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// Table's cell base render element.
///
@internal
class HTMLBidirectionalBaseRenderElement extends HTMLRenderElementBase {
  HTMLBidirectionalBaseRenderElement(super.widget, super.parent);

  @mustCallSuper
  @override
  DomNodePatchFillable render({
    required covariant HTMLBidirectionalBase widget,
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

  @mustCallSuper
  @override
  DomNodePatchFillable update({
    required updateType,
    required covariant HTMLBidirectionalBase oldWidget,
    required covariant HTMLBidirectionalBase newWidget,
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
  required HTMLBidirectionalBase widget,
  required HTMLBidirectionalBase? oldWidget,
  required Map<String, String?> attributes,
}) {
  if (widget.dir != oldWidget?.dir) {
    attributes[Attributes.dir] = widget.dir?.nativeValue;
  }
}
