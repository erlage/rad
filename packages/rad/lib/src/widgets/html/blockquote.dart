import 'package:meta/meta.dart';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/html_widget_base.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The Blockquote widget (HTML's `blockquote` tag).
///
class Blockquote extends HTMLWidgetBase {
  /// A URL for the source of the quotation may be given using the cite
  /// attribute.
  ///
  final String? cite;

  const Blockquote({
    Key? key,
    this.cite,
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
          hidden: hidden,
          style: style,
          classAttribute: classAttribute,
          contenteditable: contenteditable,
          dataAttributes: dataAttributes,
          onClickAttribute: onClickAttribute,
          innerText: innerText,
          child: child,
          children: children,
          onClick: onClick,
        );

  @nonVirtual
  @override
  String get widgetType => 'Blockquote';

  @override
  DomTagType get correspondingTag => DomTagType.blockquote;

  @override
  bool shouldWidgetUpdate(covariant Blockquote oldWidget) {
    return cite != oldWidget.cite || super.shouldWidgetUpdate(oldWidget);
  }

  @override
  createRenderElement(parent) => BlockquoteRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// Blockquote render element.
///
class BlockquoteRenderElement extends HTMLBaseElement {
  BlockquoteRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant Blockquote widget,
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
    required covariant Blockquote oldWidget,
    required covariant Blockquote newWidget,
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
  required Blockquote widget,
  required Blockquote? oldWidget,
}) {
  var attributes = <String, String?>{};

  if (null != widget.cite) {
    attributes[Attributes.cite] = widget.cite;
  } else {
    if (null != oldWidget?.cite) {
      attributes[Attributes.cite] = null;
    }
  }

  return attributes;
}
