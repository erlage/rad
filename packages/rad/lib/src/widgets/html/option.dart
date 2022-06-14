import 'package:meta/meta.dart';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/html_widget_base.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The Option widget (HTML's `option` tag).
///
class Option extends HTMLWidgetBase {
  /// The content of this attribute represents the value
  /// to be submitted with the form
  ///
  final String? value;

  /// This attribute is text for the label indicating the meaning
  /// of the option. If the label attribute isn't defined, its value
  /// is that of the dom node text content.
  ///
  final String? label;

  /// If present, this Boolean attribute indicates that the
  /// option is initially selected.
  ///
  final bool? selected;

  /// Whether Option is disabled.
  ///
  final bool? disabled;

  const Option({
    this.value,
    this.selected,
    this.disabled,
    this.label,
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
  String get widgetType => 'Option';

  @override
  DomTagType get correspondingTag => DomTagType.option;

  @override
  bool shouldUpdateWidget(covariant Option oldWidget) {
    return value != oldWidget.value ||
        label != oldWidget.label ||
        selected != oldWidget.selected ||
        disabled != oldWidget.disabled ||
        super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderElement(parent) => OptionRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// Option render element.
///
class OptionRenderElement extends HTMLBaseElement {
  OptionRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant Option widget,
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
    required covariant Option oldWidget,
    required covariant Option newWidget,
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
  required Option widget,
  required Option? oldWidget,
}) {
  var attributes = <String, String?>{};

  if (null != widget.value) {
    attributes[Attributes.value] = widget.value;
  } else {
    if (null != oldWidget?.value) {
      attributes[Attributes.value] = null;
    }
  }

  if (null != widget.label) {
    attributes[Attributes.label] = widget.label;
  } else {
    if (null != oldWidget?.label) {
      attributes[Attributes.label] = null;
    }
  }

  if (null != widget.selected && widget.selected!) {
    attributes[Attributes.selected] = '${widget.selected}';
  } else {
    if (null != oldWidget?.selected) {
      attributes[Attributes.selected] = null;
    }
  }

  if (null != widget.disabled && widget.disabled!) {
    attributes[Attributes.disabled] = '${widget.disabled}';
  } else {
    if (null != oldWidget?.disabled) {
      attributes[Attributes.disabled] = null;
    }
  }

  return attributes;
}
