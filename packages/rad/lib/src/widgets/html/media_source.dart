// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/html_widget_base.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The MediaSource widget (HTML's `source` tag).
///
class MediaSource extends HTMLWidgetBase {
  /// The MIME media type of the resource.
  ///
  final String? type;

  /// Address of the media resource.
  ///
  final String? src;

  /// A list of one or more strings, separated by commas, indicating a set of
  /// possible images represented by the source for the browser to use.
  ///
  final String? srcSet;

  /// A list of source sizes that describes the final rendered width of the
  /// image represented by the source.
  ///
  final String? sizes;

  /// Media query of the resource's intended media.
  ///
  final String? media;

  /// The displayed height of the resource.
  ///
  final String? height;

  /// The displayed width of the resource.
  ///
  final String? width;

  const MediaSource({
    this.type,
    this.src,
    this.srcSet,
    this.sizes,
    this.media,
    this.height,
    this.width,
    Key? key,
    NullableElementCallback? ref,
    String? id,
    String? title,
    String? style,
    String? className,
    bool? hidden,
    String? innerText,
    Widget? child,
    List<Widget>? children,
    EventCallback? onClick,
    Map<String, String>? additionalAttributes,
  }) : super(
          key: key,
          ref: ref,
          id: id,
          title: title,
          style: style,
          className: className,
          hidden: hidden,
          innerText: innerText,
          child: child,
          children: children,
          onClick: onClick,
          additionalAttributes: additionalAttributes,
        );

  @override
  DomTagType get correspondingTag => DomTagType.mediaSource;

  @override
  bool shouldUpdateWidget(covariant MediaSource oldWidget) {
    return type != oldWidget.type ||
        src != oldWidget.src ||
        srcSet != oldWidget.srcSet ||
        sizes != oldWidget.sizes ||
        media != oldWidget.media ||
        height != oldWidget.height ||
        width != oldWidget.width ||
        super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderElement(parent) => MediaSourceRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// MediaSource render element.
///
class MediaSourceRenderElement extends HTMLRenderElementBase {
  MediaSourceRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant MediaSource widget,
  }) {
    var domNodePatch = super.render(
      widget: widget,
    );

    _extendAttributes(
      widget: widget,
      oldWidget: null,
      attributes: domNodePatch.attributes,
    );

    return domNodePatch;
  }

  @override
  update({
    required updateType,
    required covariant MediaSource oldWidget,
    required covariant MediaSource newWidget,
  }) {
    var domNodePatch = super.update(
      updateType: updateType,
      oldWidget: oldWidget,
      newWidget: newWidget,
    );

    _extendAttributes(
      widget: newWidget,
      oldWidget: oldWidget,
      attributes: domNodePatch.attributes,
    );

    return domNodePatch;
  }
}

/*
|--------------------------------------------------------------------------
| patch
|--------------------------------------------------------------------------
*/

void _extendAttributes({
  required MediaSource widget,
  required MediaSource? oldWidget,
  required Map<String, String?> attributes,
}) {
  if (widget.type != oldWidget?.type) {
    attributes[Attributes.type] = widget.type;
  }

  if (widget.src != oldWidget?.src) {
    attributes[Attributes.src] = widget.src;
  }

  if (widget.srcSet != oldWidget?.srcSet) {
    attributes[Attributes.srcSet] = widget.srcSet;
  }

  if (widget.sizes != oldWidget?.sizes) {
    attributes[Attributes.sizes] = widget.sizes;
  }

  if (widget.media != oldWidget?.media) {
    attributes[Attributes.media] = widget.media;
  }

  if (widget.height != oldWidget?.height) {
    attributes[Attributes.height] = widget.height;
  }

  if (widget.width != oldWidget?.width) {
    attributes[Attributes.width] = widget.width;
  }
}
