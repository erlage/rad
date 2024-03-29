// Copyright 2022 H. Singh<hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:html';

import 'package:meta/meta.dart';
import 'package:rad/rad.dart';

import 'package:rad_html_vscode/src/abstract/html_widget_base.dart';
import 'package:rad_html_vscode/src/patch.dart';

/// The Audio widget (HTML's `audio` tag).
///
@internal
class Audio extends HTMLWidgetBase {
  /// A Boolean attribute: if specified, the audio will automatically begin
  /// playback as soon as it can do so, without waiting for the entire audio
  /// file to finish downloading.
  ///
  final bool? autoPlay;

  /// f this attribute is present, the browser will offer controls to allow the
  /// user to control audio playback, including volume, seeking, and
  /// pause/resume playback.
  ///
  final bool? controls;

  /// This enumerated attribute indicates whether to use CORS to fetch the
  /// related audio file.
  ///
  final CrossOriginType? crossOrigin;

  /// A Boolean attribute: if specified, the audio player will automatically
  /// seek back to the start upon reaching the end of the audio.
  ///
  final bool? loop;

  /// A Boolean attribute that indicates whether the audio will be initially
  /// silenced. Its default value is false.
  ///
  final bool? muted;

  /// This enumerated attribute is intended to provide a hint to the browser
  /// about what the author thinks will lead to the best user experience.
  ///
  final PreloadType? preload;

  /// The URL of the audio to embed. This is subject to HTTP access controls.
  /// This is optional; you may instead use the source element within the audio
  /// block to specify the audio to embed.
  ///
  final String? src;

  const Audio(
    List<Widget> children, {
    this.autoPlay,
    this.controls,
    this.crossOrigin,
    this.loop,
    this.muted,
    this.preload,
    this.src,
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
  DomTagType get correspondingTag => DomTagType.audio;

  @override
  bool shouldUpdateWidget(covariant Audio oldWidget) {
    return autoPlay != oldWidget.autoPlay ||
        controls != oldWidget.controls ||
        crossOrigin != oldWidget.crossOrigin ||
        loop != oldWidget.loop ||
        muted != oldWidget.muted ||
        preload != oldWidget.preload ||
        src != oldWidget.src ||
        super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderElement(parent) => AudioRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// Audio render element.
///
class AudioRenderElement extends HTMLRenderElementBase {
  AudioRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant Audio widget,
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
    required covariant Audio oldWidget,
    required covariant Audio newWidget,
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
  required Audio widget,
  required Audio? oldWidget,
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

  if (widget.preload != oldWidget?.preload) {
    attributes[Attributes.preload] = widget.preload?.nativeValue;
  }

  if (widget.src != oldWidget?.src) {
    attributes[Attributes.src] = widget.src;
  }
}
