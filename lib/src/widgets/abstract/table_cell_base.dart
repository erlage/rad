import 'dart:html';

import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/render_object.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/widgets/html/table_body.dart';
import 'package:rad/src/widgets/html/table_foot.dart';
import 'package:rad/src/widgets/html/table_head.dart';
import 'package:rad/src/widgets/abstract/markup_tag_with_global_props.dart';

/// Abstract class for TableCell and TableHeaderCell.
///
abstract class TableCellBase extends MarkUpTagWithGlobalProps {
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
  /// corresponding to the id attribute of the <th> elements that apply to this
  /// element.
  ///
  final String? headers;

  const TableCellBase({
    this.rowSpan,
    this.colSpan,
    this.headers,
    Key? key,
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

  @override
  createConfiguration() {
    return _TableCellBaseConfiguration(
      headers: headers,
      rowSpan: colSpan,
      colSpan: rowSpan,
      globalConfiguration:
          super.createConfiguration() as MarkUpGlobalConfiguration,
    );
  }

  @override
  isConfigurationChanged(
    covariant _TableCellBaseConfiguration oldConfiguration,
  ) {
    return rowSpan != oldConfiguration.colSpan ||
        colSpan != oldConfiguration.rowSpan ||
        headers != oldConfiguration.headers ||
        super.isConfigurationChanged(oldConfiguration.globalConfiguration);
  }

  @override
  createRenderObject(context) => _TableCellBaseRenderObject(context);
}

/*
|--------------------------------------------------------------------------
| configuration
|--------------------------------------------------------------------------
*/

class _TableCellBaseConfiguration extends WidgetConfiguration {
  final MarkUpGlobalConfiguration globalConfiguration;

  final int? rowSpan;

  final int? colSpan;

  final String? headers;

  const _TableCellBaseConfiguration({
    this.rowSpan,
    this.colSpan,
    this.headers,
    required this.globalConfiguration,
  });
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class _TableCellBaseRenderObject extends RenderObject {
  const _TableCellBaseRenderObject(BuildContext context) : super(context);

  @override
  render(
    element,
    covariant _TableCellBaseConfiguration configuration,
  ) {
    _TableCellBaseProps.apply(element, configuration);
  }

  @override
  update({
    required element,
    required updateType,
    required covariant _TableCellBaseConfiguration oldConfiguration,
    required covariant _TableCellBaseConfiguration newConfiguration,
  }) {
    _TableCellBaseProps.clear(element, oldConfiguration);
    _TableCellBaseProps.apply(element, newConfiguration);
  }
}

/*
|--------------------------------------------------------------------------
| props
|--------------------------------------------------------------------------
*/

class _TableCellBaseProps {
  static void apply(HtmlElement element, _TableCellBaseConfiguration props) {
    element as TableCellElement;

    MarkUpGlobalProps.apply(element, props.globalConfiguration);

    if (null != props.rowSpan) {
      element.rowSpan = props.rowSpan!;
    }

    if (null != props.colSpan) {
      element.colSpan = props.colSpan!;
    }

    if (null != props.headers) {
      element.headers = props.headers;
    }
  }

  static void clear(HtmlElement element, _TableCellBaseConfiguration props) {
    element as TableCellElement;

    MarkUpGlobalProps.clear(element, props.globalConfiguration);

    if (null != props.rowSpan) {
      element.removeAttribute(_Attributes.rowSpan);
    }

    if (null != props.colSpan) {
      element.removeAttribute(_Attributes.colSpan);
    }

    if (null != props.headers) {
      element.removeAttribute(_Attributes.headers);
    }
  }
}

class _Attributes {
  static const rowSpan = "rowspan";
  static const colSpan = "colspan";
  static const headers = "headers";
}
