// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/html_widget_base.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The Dialog widget (HTML's `dialog` tag).
///
class Dialog extends HTMLWidgetBase {
  /// Indicates that the dialog is active and can be interacted with. When the
  /// open attribute is not set, the dialog shouldn't be shown to the user.
  ///
  final bool? open;

  const Dialog({
    this.open,
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
  DomTagType get correspondingTag => DomTagType.dialog;

  @override
  bool shouldUpdateWidget(covariant Dialog oldWidget) {
    return open != oldWidget.open || super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderElement(parent) => DialogRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// Dialog render element.
///
class DialogRenderElement extends HTMLRenderElementBase {
  DialogRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant Dialog widget,
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
    required covariant Dialog oldWidget,
    required covariant Dialog newWidget,
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
  required Dialog widget,
  required Dialog? oldWidget,
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
