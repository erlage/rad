// Copyright 2022 H. Singh<hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:html';

import 'package:meta/meta.dart';
import 'package:rad/rad.dart';

import 'package:rad_html_vscode/src/abstract/html_table_cell_base.dart';

/// The Table Header Cell widget (HTML's `th` tag).
///
@internal
class TableHeaderCell extends HTMLTableCellBase {
  const TableHeaderCell(
    List<Widget> children, {
    String? abbr,
    int? rowSpan,
    int? colSpan,
    String? headers,
    ScopeType? scope,
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
          abbr: abbr,
          rowSpan: rowSpan,
          colSpan: colSpan,
          headers: headers,
          scope: scope,
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
  DomTagType get correspondingTag => DomTagType.tableHeaderCell;
}
