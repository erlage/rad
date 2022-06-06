import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/html_widget_base.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/html/table_body.dart';
import 'package:rad/src/widgets/html/table_foot.dart';
import 'package:rad/src/widgets/html/table_head.dart';

/// Abstract class for TableCell and TableHeaderCell.
///
abstract class TableCellBase extends HTMLWidgetBase {
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

  const TableCellBase({
    this.rowSpan,
    this.colSpan,
    this.headers,
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
    String? onClickAttribute,
    String? innerText,
    Widget? child,
    List<Widget>? children,
    EventCallback? onClick,
  }) : super(
          key: key,
          id: id,
          title: title,
          tabIndex: tabIndex,
          draggable: draggable,
          contenteditable: contenteditable,
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

  @override
  createConfiguration() {
    return _TableCellBaseConfiguration(
      headers: headers,
      rowSpan: rowSpan,
      colSpan: colSpan,
      globalConfiguration:
          super.createConfiguration() as HTMLWidgetBaseConfiguration,
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
  final HTMLWidgetBaseConfiguration globalConfiguration;

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

class _TableCellBaseRenderObject extends MarkUpGlobalRenderObject {
  const _TableCellBaseRenderObject(BuildContext context) : super(context);

  @override
  render({
    required covariant _TableCellBaseConfiguration configuration,
  }) {
    var domNodeDescription = super.render(
      configuration: configuration.globalConfiguration,
    );

    domNodeDescription?.attributes?.addAll(
      _prepareAttributes(
        props: configuration,
        oldProps: null,
      ),
    );

    return domNodeDescription;
  }

  @override
  update({
    required updateType,
    required covariant _TableCellBaseConfiguration oldConfiguration,
    required covariant _TableCellBaseConfiguration newConfiguration,
  }) {
    var domNodeDescription = super.update(
      updateType: updateType,
      oldConfiguration: oldConfiguration.globalConfiguration,
      newConfiguration: newConfiguration.globalConfiguration,
    );

    domNodeDescription?.attributes?.addAll(
      _prepareAttributes(
        props: newConfiguration,
        oldProps: oldConfiguration,
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
  required _TableCellBaseConfiguration props,
  required _TableCellBaseConfiguration? oldProps,
}) {
  var attributes = <String, String?>{};

  if (null != props.headers) {
    attributes[Attributes.headers] = props.headers;
  } else {
    if (null != oldProps?.headers) {
      attributes[Attributes.headers] = null;
    }
  }

  if (null != props.rowSpan) {
    attributes[Attributes.rowSpan] = '${props.rowSpan}';
  } else {
    if (null != oldProps?.rowSpan) {
      attributes[Attributes.rowSpan] = null;
    }
  }

  if (null != props.colSpan) {
    attributes[Attributes.colSpan] = '${props.colSpan}';
  } else {
    if (null != oldProps?.colSpan) {
      attributes[Attributes.colSpan] = null;
    }
  }

  return attributes;
}
