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

/// The ImageMap widget (HTML's `map` tag).
///
class ImageMap extends HTMLWidgetBase {
  /// The name attribute gives the map a name so that it can be referenced.
  ///
  final String? name;

  const ImageMap({
    Key? key,
    this.name,
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

  @nonVirtual
  @override
  String get widgetType => 'ImageMap';

  @override
  DomTagType get correspondingTag => DomTagType.imageMap;

  @override
  bool shouldUpdateWidget(covariant ImageMap oldWidget) {
    return name != oldWidget.name || super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderElement(parent) => ImageMapRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// ImageMap render element.
///
class ImageMapRenderElement extends HTMLRenderElementBase {
  ImageMapRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant ImageMap widget,
  }) {
    var domNodeDescription = super.render(
      widget: widget,
    );

    domNodeDescription.attributes.addAll(
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
    required covariant ImageMap oldWidget,
    required covariant ImageMap newWidget,
  }) {
    var domNodeDescription = super.update(
      updateType: updateType,
      oldWidget: oldWidget,
      newWidget: newWidget,
    );

    domNodeDescription.attributes.addAll(
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
  required ImageMap widget,
  required ImageMap? oldWidget,
}) {
  var attributes = <String, String?>{};

  if (widget.name != oldWidget?.name) {
    attributes[Attributes.name] = widget.name;
  }

  return attributes;
}
