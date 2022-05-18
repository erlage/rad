import 'package:meta/meta.dart';

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/table_cell_base.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The Table Data Cell widget (HTML's `td` tag).
///
class TableDataCell extends TableCellBase {
  const TableDataCell({
    int? rowSpan,
    int? colSpan,
    String? headers,
    Key? key,
    String? id,
    bool? hidden,
    bool? draggable,
    bool? contenteditable,
    int? tabIndex,
    String? title,
    String? style,
    String? classAttribute,
    Map<String, String>? dataAttributes,
    String? onClick,
    EventCallback? onClickEventListener,
    String? innerText,
    Widget? child,
    List<Widget>? children,
  }) : super(
          key: key,
          id: id,
          rowSpan: rowSpan,
          colSpan: colSpan,
          headers: headers,
          title: title,
          tabIndex: tabIndex,
          draggable: draggable,
          contenteditable: contenteditable,
          hidden: hidden,
          style: style,
          classAttribute: classAttribute,
          dataAttributes: dataAttributes,
          onClick: onClick,
          onClickEventListener: onClickEventListener,
          innerText: innerText,
          child: child,
          children: children,
        );

  @nonVirtual
  @override
  get widgetType => '$TableDataCell';

  @override
  get correspondingTag => DomTag.tableDataCell;
}
