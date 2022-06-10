import 'package:meta/meta.dart';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/html_widget_base.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The FieldSet widget (HTML's `fieldset` tag).
///
/// Group several controls as well as labels (<label>) within a web form.
///
class FieldSet extends HTMLWidgetBase {
  /// Whether field set is disabled.
  ///
  final bool? disabled;

  const FieldSet({
    this.disabled,
    Key? key,
    bool? hidden,
    bool? draggable,
    bool? contenteditable,
    int? tabIndex,
    String? id,
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

  @nonVirtual
  @override
  String get widgetType => 'FieldSet';

  @override
  DomTagType get correspondingTag => DomTagType.fieldSet;

  @override
  bool shouldUpdateWidget(covariant FieldSet oldWidget) {
    return disabled != oldWidget.disabled ||
        super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderObject(context) => _FieldSetRenderObject(context);
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class _FieldSetRenderObject extends MarkUpGlobalRenderObject {
  const _FieldSetRenderObject(BuildContext context) : super(context);

  @override
  render({
    required covariant FieldSet widget,
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
    required covariant FieldSet oldWidget,
    required covariant FieldSet newWidget,
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
  required FieldSet widget,
  required FieldSet? oldWidget,
}) {
  var attributes = <String, String?>{};

  if (null != widget.disabled && widget.disabled!) {
    attributes[Attributes.disabled] = '${widget.disabled}';
  } else {
    if (null != oldWidget?.disabled) {
      attributes[Attributes.disabled] = null;
    }
  }

  return attributes;
}
