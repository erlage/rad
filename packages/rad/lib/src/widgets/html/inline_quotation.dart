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
    bool? hidden,
    bool? draggable,
    bool? contentEditable,
    int? tabIndex,
    String? id,
    String? title,
    String? style,
    String? className,
    String? innerText,
    List<Widget>? children,
    EventCallback? onClick,
    Map<String, String>? additionalAttributes,
  }) : super(
          key: key,
          id: id,
          title: title,
          tabIndex: tabIndex,
          draggable: draggable,
          contentEditable: contentEditable,
          hidden: hidden,
          style: style,
          className: className,
          innerText: innerText,
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
    var domNodeDescription = super.render(
      widget: widget,
    );

    domNodeDescription?.attributes?.addAll(
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
    required covariant InlineQuotation oldWidget,
    required covariant InlineQuotation newWidget,
  }) {
    var domNodeDescription = super.update(
      updateType: updateType,
      oldWidget: oldWidget,
      newWidget: newWidget,
    );

    domNodeDescription?.attributes?.addAll(
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
  required InlineQuotation widget,
  required InlineQuotation? oldWidget,
}) {
  var attributes = <String, String?>{};

  if (widget.cite != oldWidget?.cite) {
    attributes[Attributes.cite] = widget.cite;
  }

  return attributes;
}
