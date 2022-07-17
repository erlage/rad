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

/// The Dialog widget (HTML's `dialog` tag).
///
class Dialog extends HTMLWidgetBase {
  /// Indicates that the dialog is active and can be interacted with. When the
  /// open attribute is not set, the dialog shouldn't be shown to the user.
  ///
  final bool? open;

  const Dialog({
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

  @nonVirtual
  @override
  String get widgetType => 'Dialog';

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

    domNodePatch.attributes.addAll(
      _prepareAttributes(
        widget: widget,
        oldWidget: null,
      ),
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

    domNodePatch.attributes.addAll(
      _prepareAttributes(
        widget: newWidget,
        oldWidget: oldWidget,
      ),
    );

    return domNodePatch;
  }
}

/*
|--------------------------------------------------------------------------
| props
|--------------------------------------------------------------------------
*/

Map<String, String?> _prepareAttributes({
  required Dialog widget,
  required Dialog? oldWidget,
}) {
  var attributes = <String, String?>{};

  if (widget.open != oldWidget?.open) {
    if (null == widget.open || false == widget.open) {
      attributes[Attributes.open] = null;
    } else {
      attributes[Attributes.open] = 'true';
    }
  }

  return attributes;
}
