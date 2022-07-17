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

/// The InlineQuotation widget (HTML's `q` tag).
///
class InlineQuotation extends HTMLWidgetBase {
  /// The value of this attribute is a URL that designates a source document or
  /// message for the information quoted.
  ///
  final String? cite;

  const InlineQuotation({
    this.cite,
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
  String get widgetType => 'InlineQuotation';

  @override
  DomTagType get correspondingTag => DomTagType.inlineQuotation;

  @override
  bool shouldUpdateWidget(covariant InlineQuotation oldWidget) {
    return cite != oldWidget.cite || super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderElement(parent) => DataRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// Data render element.
///
class DataRenderElement extends HTMLRenderElementBase {
  DataRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant InlineQuotation widget,
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
    required covariant InlineQuotation oldWidget,
    required covariant InlineQuotation newWidget,
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
  required InlineQuotation widget,
  required InlineQuotation? oldWidget,
}) {
  var attributes = <String, String?>{};

  if (widget.cite != oldWidget?.cite) {
    attributes[Attributes.cite] = widget.cite;
  }

  return attributes;
}
