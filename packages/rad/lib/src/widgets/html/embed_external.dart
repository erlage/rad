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

/// The EmbedExternal widget (HTML's `embed` tag).
///
class EmbedExternal extends HTMLWidgetBase {
  /// The displayed height of the resource.
  ///
  final String? height;

  /// TThe URL of the resource being embedded.
  ///
  final String? src;

  /// The MIME type to use to select the plug-in to instantiate.
  ///
  final String? type;

  /// The displayed width of the resource.
  ///
  final String? width;

  const EmbedExternal({
    Key? key,
    this.height,
    this.src,
    this.type,
    this.width,
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
  String get widgetType => 'EmbedExternal';

  @override
  DomTagType get correspondingTag => DomTagType.embedExternal;

  @override
  bool shouldUpdateWidget(covariant EmbedExternal oldWidget) {
    return height != oldWidget.height ||
        src != oldWidget.src ||
        type != oldWidget.type ||
        width != oldWidget.width ||
        super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderElement(parent) => EmbedExternalRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// EmbedExternal render element.
///
class EmbedExternalRenderElement extends HTMLRenderElementBase {
  EmbedExternalRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant EmbedExternal widget,
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
    required covariant EmbedExternal oldWidget,
    required covariant EmbedExternal newWidget,
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
  required EmbedExternal widget,
  required EmbedExternal? oldWidget,
}) {
  var attributes = <String, String?>{};

  if (widget.height != oldWidget?.height) {
    attributes[Attributes.height] = widget.height;
  }

  if (widget.src != oldWidget?.src) {
    attributes[Attributes.src] = widget.src;
  }

  if (widget.type != oldWidget?.type) {
    attributes[Attributes.type] = widget.type;
  }

  if (widget.width != oldWidget?.width) {
    attributes[Attributes.width] = widget.width;
  }

  return attributes;
}
