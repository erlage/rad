import 'dart:html';

import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/render_object.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/widgets/abstract/markup_tag_with_global_props.dart';

/// Abstract class for TableColumn and TableColumnGroup.
///
abstract class TableColumnBase extends MarkUpTagWithGlobalProps {
  /// This attribute contains a positive integer indicating the number of
  /// consecutive columns the TableColumn spans. If not present, its default
  /// value is 1.
  ///
  final int? span;

  const TableColumnBase({
    this.span,
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
    return _TableColumnBaseConfiguration(
      span: span,
      globalConfiguration:
          super.createConfiguration() as MarkUpGlobalConfiguration,
    );
  }

  @override
  isConfigurationChanged(
    covariant _TableColumnBaseConfiguration oldConfiguration,
  ) {
    return span != oldConfiguration.span ||
        super.isConfigurationChanged(oldConfiguration.globalConfiguration);
  }

  @override
  createRenderObject(context) => _TableColumnBaseRenderObject(context);
}

/*
|--------------------------------------------------------------------------
| configuration
|--------------------------------------------------------------------------
*/

class _TableColumnBaseConfiguration extends WidgetConfiguration {
  final MarkUpGlobalConfiguration globalConfiguration;

  final int? span;

  const _TableColumnBaseConfiguration({
    this.span,
    required this.globalConfiguration,
  });
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class _TableColumnBaseRenderObject extends RenderObject {
  const _TableColumnBaseRenderObject(BuildContext context) : super(context);

  @override
  render(
    element,
    covariant _TableColumnBaseConfiguration configuration,
  ) {
    _TableColumnProps.apply(element, configuration);
  }

  @override
  update({
    required element,
    required updateType,
    required covariant _TableColumnBaseConfiguration oldConfiguration,
    required covariant _TableColumnBaseConfiguration newConfiguration,
  }) {
    _TableColumnProps.clear(element, oldConfiguration);
    _TableColumnProps.apply(element, newConfiguration);
  }
}

/*
|--------------------------------------------------------------------------
| props
|--------------------------------------------------------------------------
*/

class _TableColumnProps {
  static void apply(HtmlElement element, _TableColumnBaseConfiguration props) {
    element as TableColElement;

    MarkUpGlobalProps.apply(element, props.globalConfiguration);

    if (null != props.span) {
      element.span = props.span!;
    }
  }

  static void clear(HtmlElement element, _TableColumnBaseConfiguration props) {
    element as TableColElement;

    MarkUpGlobalProps.clear(element, props.globalConfiguration);

    if (null != props.span) {
      element.removeAttribute(_Attributes.span);
    }
  }
}

class _Attributes {
  static const span = "span";
}
