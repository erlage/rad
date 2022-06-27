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

/// The ListItem widget (HTML's `li` tag).
///
class ListItem extends HTMLWidgetBase {
  /// Value of list item.
  ///
  final int? value;

  const ListItem({
    this.value,
    Key? key,
    String? id,
    bool? hidden,
    bool? draggable,
    bool? contentEditable,
    int? tabIndex,
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
          contentEditable: contentEditable,
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
  String get widgetType => 'ListItem';

  @override
  DomTagType get correspondingTag => DomTagType.listItem;

  @override
  bool shouldUpdateWidget(covariant ListItem oldWidget) {
    return value != oldWidget.value || super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderElement(parent) => ListItemRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

class ListItemRenderElement extends HTMLBaseElement {
  ListItemRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant ListItem widget,
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
    required covariant ListItem oldWidget,
    required covariant ListItem newWidget,
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
  required ListItem widget,
  required ListItem? oldWidget,
}) {
  var attributes = <String, String?>{};

  if (widget.value != oldWidget?.value) {
    if (null == widget.value) {
      attributes[Attributes.value] = null;
    } else {
      attributes[Attributes.value] = '${widget.value}';
    }
  }

  return attributes;
}
