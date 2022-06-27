// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/table_cell_base.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The Table Header Cell widget (HTML's `th` tag).
///
class TableHeaderCell extends TableCellBase {
  const TableHeaderCell({
    int? rowSpan,
    int? colSpan,
    String? headers,
    Key? key,
    String? id,
    bool? hidden,
    bool? draggable,
    bool? contentEditable,
    int? tabIndex,
    String? title,
    String? style,
    String? classAttribute,
    Map<String, String>? dataAttributes,
    String? onClickAttribute,
    String? innerText,
    Widget? child,
    List<Widget>? children,
    EventCallback? onClick,
  }) : super(
          key: key,
          id: id,
          rowSpan: rowSpan,
          colSpan: colSpan,
          headers: headers,
          title: title,
          tabIndex: tabIndex,
          draggable: draggable,
          contentEditable: contentEditable,
          hidden: hidden,
          style: style,
          classAttribute: classAttribute,
          dataAttributes: dataAttributes,
          onClickAttribute: onClickAttribute,
          innerText: innerText,
          child: child,
          children: children,
          onClick: onClick,
        );

  @nonVirtual
  @override
  String get widgetType => 'TableHeaderCell';

  @override
  DomTagType get correspondingTag => DomTagType.tableHeaderCell;
}
