// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/html_widget_base.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The Details widget (HTML's `details` tag).
///
class Details extends HTMLWidgetBase {
  /// This Boolean attribute indicates whether or not the details — that is,
  /// the contents of the details element — are currently visible.
  ///
  final bool? open;

  const Details({
    Key? key,
    this.open,
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

  @override
  DomTagType get correspondingTag => DomTagType.details;

  @override
  bool shouldUpdateWidget(covariant Details oldWidget) {
    return open != oldWidget.open || super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderElement(parent) => DetailsRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// Details render element.
///
class DetailsRenderElement extends HTMLRenderElementBase {
  DetailsRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant Details widget,
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
    required covariant Details oldWidget,
    required covariant Details newWidget,
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
  required Details widget,
  required Details? oldWidget,
  required Map<String, String?> attributes,
}) {
  if (widget.open != oldWidget?.open) {
    if (null == widget.open || false == widget.open) {
      attributes[Attributes.open] = null;
    } else {
      attributes[Attributes.open] = 'true';
    }
  }
}
