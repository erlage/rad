// Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/html_widget_base.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// The EmbedTextTrack widget (HTML's `track` tag).
///
class EmbedTextTrack extends HTMLWidgetBase {
  /// This attribute indicates that the track should be enabled unless the
  /// user's preferences indicate that another track is more appropriate.
  /// This may only be used on one track element per media element.
  ///
  final bool? defaultAttribute;

  /// How the text track is meant to be used. If omitted the default kind is
  /// subtitles. If the attribute contains an invalid value, it will use
  /// metadata (Versions of Chrome earlier than 52 treated an invalid value as
  /// subtitles).
  ///
  final KindType? kind;

  /// A user-readable title of the text track which is used by the browser
  /// when listing available text tracks.
  ///
  final String? label;

  /// Address of the track (.vtt file). Must be a valid URL.
  ///
  final String? src;

  /// Language of the track text data.
  ///
  final String? srcLang;

  const EmbedTextTrack({
    this.defaultAttribute,
    this.kind,
    this.label,
    this.src,
    this.srcLang,
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
  DomTagType get correspondingTag => DomTagType.embedTextTrack;

  @override
  bool shouldUpdateWidget(covariant EmbedTextTrack oldWidget) {
    return defaultAttribute != oldWidget.defaultAttribute ||
        kind != oldWidget.kind ||
        label != oldWidget.label ||
        src != oldWidget.src ||
        srcLang != oldWidget.srcLang ||
        super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderElement(parent) => EmbedTextTrackRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// EmbedTextTrack render element.
///
class EmbedTextTrackRenderElement extends HTMLRenderElementBase {
  EmbedTextTrackRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant EmbedTextTrack widget,
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
    required covariant EmbedTextTrack oldWidget,
    required covariant EmbedTextTrack newWidget,
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
  required EmbedTextTrack widget,
  required EmbedTextTrack? oldWidget,
  required Map<String, String?> attributes,
}) {
  if (widget.defaultAttribute != oldWidget?.defaultAttribute) {
    if (null == widget.defaultAttribute || false == widget.defaultAttribute) {
      attributes[Attributes.defaultAttribute] = null;
    } else {
      attributes[Attributes.defaultAttribute] = 'true';
    }
  }

  if (widget.kind != oldWidget?.kind) {
    attributes[Attributes.kind] = widget.kind?.nativeValue;
  }

  if (widget.label != oldWidget?.label) {
    attributes[Attributes.label] = widget.label;
  }

  if (widget.src != oldWidget?.src) {
    attributes[Attributes.src] = widget.src;
  }

  if (widget.srcLang != oldWidget?.srcLang) {
    attributes[Attributes.srcLang] = widget.srcLang;
  }
}
