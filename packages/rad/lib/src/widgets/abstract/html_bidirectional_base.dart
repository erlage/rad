// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/dom_node_patch.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/html_widget_base.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// Abstract class for Bidirectional HTML widgets.
///
@internal
abstract class HTMLBidirectionalBase extends HTMLWidgetBase {
  /// The direction in which text should be rendered.
  ///
  final TextDirection? dir;

  const HTMLBidirectionalBase({
    this.dir,
    Key? key,
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

  @override
  bool shouldUpdateWidget(
    covariant oldWidget,
  ) {
    oldWidget as HTMLBidirectionalBase;

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
  DomNodePatchFillable render({
    required covariant HTMLBidirectionalBase widget,
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

  @mustCallSuper
  @override
  DomNodePatchFillable update({
    required updateType,
    required covariant HTMLBidirectionalBase oldWidget,
    required covariant HTMLBidirectionalBase newWidget,
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
  required HTMLBidirectionalBase widget,
  required HTMLBidirectionalBase? oldWidget,
}) {
  var attributes = <String, String?>{};

  if (widget.dir != oldWidget?.dir) {
    attributes[Attributes.dir] = widget.dir?.nativeName;
  }

  return attributes;
}
