import 'package:meta/meta.dart';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/html_widget_base.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The Image widget (HTML's `img` tag).
///
class Image extends HTMLWidgetBase {
  /// Image src.
  ///
  final String? src;

  /// Alt text for image.
  ///
  final String? alt;

  // size props

  final String? width;
  final String? height;

  const Image({
    this.src,
    this.alt,
    this.width,
    this.height,
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
  String get widgetType => 'Image';

  @override
  DomTagType get correspondingTag => DomTagType.image;

  @override
  bool shouldWidgetUpdate(covariant Image oldWidget) {
    return src != oldWidget.src ||
        alt != oldWidget.alt ||
        width != oldWidget.width ||
        height != oldWidget.height ||
        super.shouldWidgetUpdate(oldWidget);
  }

  @override
  createRenderElement(parent) => ImageRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// Image render element.
///
class ImageRenderElement extends HTMLBaseElement {
  ImageRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant Image widget,
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
    required covariant Image oldWidget,
    required covariant Image newWidget,
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
  required Image widget,
  required Image? oldWidget,
}) {
  var attributes = <String, String?>{};

  if (null != widget.src) {
    attributes[Attributes.src] = widget.src;
  } else {
    if (null != oldWidget?.src) {
      attributes[Attributes.src] = null;
    }
  }

  if (null != widget.alt) {
    attributes[Attributes.alt] = widget.alt;
  } else {
    if (null != oldWidget?.alt) {
      attributes[Attributes.alt] = null;
    }
  }

  if (null != widget.height) {
    attributes[Attributes.height] = widget.height;
  } else {
    if (null != oldWidget?.height) {
      attributes[Attributes.height] = null;
    }
  }

  if (null != widget.width) {
    attributes[Attributes.width] = widget.width;
  } else {
    if (null != oldWidget?.width) {
      attributes[Attributes.width] = null;
    }
  }

  return attributes;
}
