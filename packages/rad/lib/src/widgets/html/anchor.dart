import 'package:meta/meta.dart';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/html_widget_base.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The Anchor widget (HTML's `a` tag).
///
class Anchor extends HTMLWidgetBase {
  /// The URL that the hyperlink points to.
  ///
  final String? href;

  /// The relationship of the linked URL as space-separated link types.
  ///
  final String? rel;

  /// Where to display the linked URL.
  ///
  final String? target;

  /// Prompts the user to save the linked URL instead of navigating to it.
  /// Can be used with or without a value.
  ///
  final String? download;

  const Anchor({
    Key? key,
    this.href,
    this.rel,
    this.target,
    this.download,
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
  String get widgetType => 'Anchor';

  @override
  DomTagType get correspondingTag => DomTagType.anchor;

  @override
  bool shouldWidgetUpdate(covariant Anchor oldWidget) {
    return href != oldWidget.href ||
        rel != oldWidget.rel ||
        target != oldWidget.target ||
        download != oldWidget.download ||
        super.shouldWidgetUpdate(oldWidget);
  }

  @override
  createRenderElement(parent) => AnchorRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// Anchor render element.
///
class AnchorRenderElement extends HTMLBaseElement {
  AnchorRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant Anchor widget,
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
    required covariant Anchor oldWidget,
    required covariant Anchor newWidget,
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
  required Anchor widget,
  required Anchor? oldWidget,
}) {
  var attributes = <String, String?>{};

  if (null != widget.href) {
    attributes[Attributes.href] = widget.href;
  } else {
    if (null != oldWidget?.href) {
      attributes[Attributes.href] = null;
    }
  }

  if (null != widget.download) {
    attributes[Attributes.download] = widget.download;
  } else {
    if (null != oldWidget?.download) {
      attributes[Attributes.download] = null;
    }
  }

  if (null != widget.rel) {
    attributes[Attributes.rel] = widget.rel;
  } else {
    if (null != oldWidget?.rel) {
      attributes[Attributes.rel] = null;
    }
  }

  if (null != widget.target) {
    attributes[Attributes.target] = widget.target;
  } else {
    if (null != oldWidget?.target) {
      attributes[Attributes.target] = null;
    }
  }

  return attributes;
}
