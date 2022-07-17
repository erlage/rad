// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

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
    bool? contentEditable,
    int? tabIndex,
    String? id,
    String? title,
    String? style,
    String? className,
    String? innerText,
    Widget? child,
    List<Widget>? children,
    EventCallback? onClick,
    Map<String, String>? additionalAttributes,
  }) : super(
          key: key,
          id: id,
          title: title,
          tabIndex: tabIndex,
          draggable: draggable,
          contentEditable: contentEditable,
          hidden: hidden,
          style: style,
          className: className,
          innerText: innerText,
          child: child,
          children: children,
          onClick: onClick,
          additionalAttributes: additionalAttributes,
        );

  @nonVirtual
  @override
  String get widgetType => 'Image';

  @override
  DomTagType get correspondingTag => DomTagType.image;

  @override
  bool shouldUpdateWidget(covariant Image oldWidget) {
    return src != oldWidget.src ||
        alt != oldWidget.alt ||
        width != oldWidget.width ||
        height != oldWidget.height ||
        super.shouldUpdateWidget(oldWidget);
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
class ImageRenderElement extends HTMLRenderElementBase {
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

  if (widget.src != oldWidget?.src) {
    attributes[Attributes.src] = widget.src;
  }

  if (widget.alt != oldWidget?.alt) {
    attributes[Attributes.alt] = widget.alt;
  }

  if (widget.width != oldWidget?.width) {
    attributes[Attributes.width] = widget.width;
  }

  if (widget.height != oldWidget?.height) {
    attributes[Attributes.height] = widget.height;
  }

  return attributes;
}
