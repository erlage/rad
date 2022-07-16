// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';
import 'package:rad/rad.dart';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/widgets/abstract/html_widget_base.dart';

/// Abstract class for Bidirectional HTML widgets.
///
@internal
abstract class HTMLBidirectionalWidgetBase extends HTMLWidgetBase {
  /// The direction in which text should be rendered.
  ///
  final TextDirection? dir;

  const HTMLBidirectionalWidgetBase({
    this.dir,
    Key? key,
    String? id,
    bool? hidden,
    bool? draggable,
    bool? contentEditable,
    int? tabIndex,
    String? title,
    String? style,
    String? className,
    String? innerText,
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
          children: children,
          onClick: onClick,
          additionalAttributes: additionalAttributes,
        );

  @override
  bool shouldUpdateWidget(
    covariant oldWidget,
  ) {
    oldWidget as HTMLBidirectionalWidgetBase;

    return dir != oldWidget.dir || super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderElement(parent) {
    return HTMLBidirectionalBaseRenderElement(this, parent);
  }
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// Table's cell base render element.
///
@internal
class HTMLBidirectionalBaseRenderElement extends HTMLRenderElementBase {
  HTMLBidirectionalBaseRenderElement(super.wudget, super.parent);

  @mustCallSuper
  @override
  render({
    required covariant HTMLBidirectionalWidgetBase widget,
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

  @mustCallSuper
  @override
  update({
    required updateType,
    required covariant HTMLBidirectionalWidgetBase oldWidget,
    required covariant HTMLBidirectionalWidgetBase newWidget,
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
  required HTMLBidirectionalWidgetBase widget,
  required HTMLBidirectionalWidgetBase? oldWidget,
}) {
  var attributes = <String, String?>{};

  if (widget.dir != oldWidget?.dir) {
    attributes[Attributes.dir] = widget.dir?.nativeName;
  }

  return attributes;
}
