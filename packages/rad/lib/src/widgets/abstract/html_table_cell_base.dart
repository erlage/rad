// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/objects/dom_node_patch.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/html_widget_base.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/html/table_body.dart';
import 'package:rad/src/widgets/html/table_foot.dart';
import 'package:rad/src/widgets/html/table_head.dart';

/// Abstract class for TableCell and TableHeaderCell.
///
@internal
abstract class HTMLTableCellBase extends HTMLWidgetBase {
  /// This attribute contains a non-negative integer value that indicates for
  /// how many rows the cell extends. Its default value is 1; if its value is
  /// set to 0, it extends until the end of the table section ([TableHead],
  /// [TableBody], [TableFoot], even if implicitly defined), that the cell
  /// belongs to. Values higher than 65534 are clipped down to 65534..
  ///
  final int? rowSpan;

  /// This attribute contains a non-negative integer value that indicates for
  /// how many columns the cell extends. Its default value is 1. Values higher
  /// than 1000 will be considered as incorrect and will be set to the default
  /// value (1).
  ///
  final int? colSpan;

  /// This attribute contains a list of space-separated strings, each
  /// corresponding to the id attribute of the <th> dom nodes that apply to this
  /// dom node.
  ///
  final String? headers;

  const HTMLTableCellBase({
    this.rowSpan,
    this.colSpan,
    this.headers,
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

  @override
  bool shouldUpdateWidget(
    covariant oldWidget,
  ) {
    oldWidget as HTMLTableCellBase;

    return rowSpan != oldWidget.rowSpan ||
        colSpan != oldWidget.colSpan ||
        headers != oldWidget.headers ||
        super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderElement(parent) => HTMLTableCellBaseRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// Table's cell base render element.
///
@internal
class HTMLTableCellBaseRenderElement extends HTMLRenderElementBase {
  HTMLTableCellBaseRenderElement(super.wudget, super.parent);

  @mustCallSuper
  @override
  DomNodePatchFillable render({
    required covariant HTMLTableCellBase widget,
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

  @mustCallSuper
  @override
  DomNodePatchFillable update({
    required updateType,
    required covariant HTMLTableCellBase oldWidget,
    required covariant HTMLTableCellBase newWidget,
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
  required HTMLTableCellBase widget,
  required HTMLTableCellBase? oldWidget,
}) {
  var attributes = <String, String?>{};

  if (widget.headers != oldWidget?.headers) {
    attributes[Attributes.headers] = widget.headers;
  }

  if (widget.rowSpan != oldWidget?.rowSpan) {
    if (null == widget.rowSpan) {
      attributes[Attributes.rowSpan] = null;
    } else {
      attributes[Attributes.rowSpan] = '${widget.rowSpan}';
    }
  }

  if (widget.colSpan != oldWidget?.colSpan) {
    if (null == widget.colSpan) {
      attributes[Attributes.colSpan] = null;
    } else {
      attributes[Attributes.colSpan] = '${widget.colSpan}';
    }
  }

  return attributes;
}
