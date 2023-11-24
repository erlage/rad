// Copyright 2022 H. Singh<hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:html';

import 'package:meta/meta.dart';
import 'package:rad/rad.dart';

import 'package:rad_html_vscode/src/abstract/html_widget_base.dart';
import 'package:rad_html_vscode/src/patch.dart';

/// The Video widget (HTML's `video` tag).
///
@internal
class Video extends HTMLWidgetBase {
  /// A Boolean attribute: if specified, the Video will automatically begin
  /// playback as soon as it can do so, without waiting for the entire Video
  /// file to finish downloading.
  ///
  final bool? autoPlay;

  /// f this attribute is present, the browser will offer controls to allow the
  /// user to control Video playback, including volume, seeking, and
  /// pause/resume playback.
  ///
  final bool? controls;

  /// This enumerated attribute indicates whether to use CORS to fetch the
  /// related Video file.
  ///
  final CrossOriginType? crossOrigin;

  /// The height of the video's display area.
  ///
  final String? height;

  /// A Boolean attribute: if specified, the Video player will automatically
  /// seek back to the start upon reaching the end of the Video.
  ///
  final bool? loop;

  /// A Boolean attribute that indicates whether the Video will be initially
  /// silenced. Its default value is false.
  ///
  final bool? muted;

  /// A Boolean attribute indicating that the video is to be played "inline",
  /// that is within the element's playback area. Note that the absence of this
  /// attribute does not imply that the video will always be played in
  /// full screen.
  ///
  final bool? playsInline;

  /// A URL for an image to be shown while the video is downloading. If this
  /// attribute isn't specified, nothing is displayed until the first frame is
  /// available, then the first frame is shown as the poster frame.
  ///
  final String? poster;

  /// This enumerated attribute is intended to provide a hint to the browser
  /// about what the author thinks will lead to the best user experience.
  ///
  final PreloadType? preload;

  /// The URL of the Video to embed. This is subject to HTTP access controls.
  /// This is optional; you may instead use the source element within the Video
  /// block to specify the Video to embed.
  ///
  final String? src;

  /// The width of the video's display area.
  ///
  final String? width;

  const Video(
    List<Widget> children, {
    this.autoPlay,
    this.controls,
    this.crossOrigin,
    this.height,
    this.loop,
    this.muted,
    this.playsInline,
    this.poster,
    this.preload,
    this.src,
    this.width,
    Key? key,
    void Function(Element? element)? ref,
    String? id,
    String? title,
    String? style,
    String? className,
    bool? hidden,
    EventCallback? onClick,
    Map<String, String>? additionalAttributes,
  }) : super(
          children,
          key: key,
          ref: ref,
          id: id,
          title: title,
          style: style,
          className: className,
          hidden: hidden,
          onClick: onClick,
          additionalAttributes: additionalAttributes,
        );

  @override
  DomTagType get correspondingTag => DomTagType.video;

  @override
  bool shouldUpdateWidget(covariant Video oldWidget) {
    return autoPlay != oldWidget.autoPlay ||
        controls != oldWidget.controls ||
        crossOrigin != oldWidget.crossOrigin ||
        height != oldWidget.height ||
        loop != oldWidget.loop ||
        muted != oldWidget.muted ||
        playsInline != oldWidget.playsInline ||
        poster != oldWidget.poster ||
        preload != oldWidget.preload ||
        src != oldWidget.src ||
        width != oldWidget.width ||
        super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderElement(parent) => VideoRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// Video render element.
///
class VideoRenderElement extends HTMLRenderElementBase {
  VideoRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant Video widget,
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
    required covariant Video oldWidget,
    required covariant Video newWidget,
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
  required Video widget,
  required Video? oldWidget,
  required Map<String, String?> attributes,
}) {
  if (widget.autoPlay != oldWidget?.autoPlay) {
    if (null == widget.autoPlay || false == widget.autoPlay) {
      attributes[Attributes.autoPlay] = null;
    } else {
      attributes[Attributes.autoPlay] = 'true';
    }
  }

  if (widget.controls != oldWidget?.controls) {
    if (null == widget.controls || false == widget.controls) {
      attributes[Attributes.controls] = null;
    } else {
      attributes[Attributes.controls] = 'true';
    }
  }

  if (widget.crossOrigin != oldWidget?.crossOrigin) {
    attributes[Attributes.crossOrigin] = widget.crossOrigin?.nativeValue;
  }

  if (widget.height != oldWidget?.height) {
    attributes[Attributes.height] = widget.height;
  }

  if (widget.loop != oldWidget?.loop) {
    if (null == widget.loop || false == widget.loop) {
      attributes[Attributes.loop] = null;
    } else {
      attributes[Attributes.loop] = 'true';
    }
  }

  if (widget.muted != oldWidget?.muted) {
    if (null == widget.muted || false == widget.muted) {
      attributes[Attributes.muted] = null;
    } else {
      attributes[Attributes.muted] = 'true';
    }
  }

  if (widget.playsInline != oldWidget?.playsInline) {
    if (null == widget.playsInline || false == widget.playsInline) {
      attributes[Attributes.playsInline] = null;
    } else {
      attributes[Attributes.playsInline] = 'true';
    }
  }

  if (widget.poster != oldWidget?.poster) {
    attributes[Attributes.poster] = widget.poster;
  }

  if (widget.preload != oldWidget?.preload) {
    attributes[Attributes.preload] = widget.preload?.nativeValue;
  }

  if (widget.src != oldWidget?.src) {
    attributes[Attributes.src] = widget.src;
  }

  if (widget.width != oldWidget?.width) {
    attributes[Attributes.width] = widget.width;
  }
}
