import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/html_widget_base.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// Abstract class for TableColumn and TableColumnGroup.
///
abstract class TableColumnBase extends HTMLWidgetBase {
  /// This attribute contains a positive integer indicating the number of
  /// consecutive columns the TableColumn spans. If not present, its default
  /// value is 1.
  ///
  final int? span;

  const TableColumnBase({
    this.span,
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
  @override
  bool shouldUpdateWidget(
    covariant TableColumnBase oldWidget,
  ) {
    return span != oldWidget.span || super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderObject(context) => _TableColumnBaseRenderObject(context);
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class _TableColumnBaseRenderObject extends MarkUpGlobalRenderObject {
  const _TableColumnBaseRenderObject(BuildContext context) : super(context);

  @override
  render({
    required covariant TableColumnBase widget,
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
    required covariant TableColumnBase oldWidget,
    required covariant TableColumnBase newWidget,
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
  required TableColumnBase widget,
  required TableColumnBase? oldWidget,
}) {
  var attributes = <String, String?>{};

  if (null != widget.span) {
    attributes[Attributes.span] = '${widget.span}';
  } else {
    if (null != oldWidget?.span) {
      attributes[Attributes.span] = null;
    }
  }

  return attributes;
}
