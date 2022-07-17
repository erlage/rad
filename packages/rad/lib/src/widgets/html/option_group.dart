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

/// The OptionGroup widget (HTML's `optgroup` tag).
///
class OptionGroup extends HTMLWidgetBase {
  /// The name of the group of options, which the browser can use when labeling
  /// the options in the user interface.
  ///
  final String? label;

  /// If this Boolean attribute is set, none of the items in this option group
  /// is selectable. Often browsers grey out such control and it won't receive
  /// any browsing events, like mouse clicks or focus-related ones.
  ///
  final bool? disabled;

  const OptionGroup({
    this.label,
    this.disabled,
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

  @nonVirtual
  @override
  String get widgetType => 'OptionGroup';

  @override
  DomTagType get correspondingTag => DomTagType.optionGroup;

  @override
  bool shouldUpdateWidget(covariant OptionGroup oldWidget) {
    return label != oldWidget.label ||
        disabled != oldWidget.disabled ||
        super.shouldUpdateWidget(oldWidget);
  }

  @override
  createRenderElement(parent) => OptionGroupRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// OptionGroup render element.
///
class OptionGroupRenderElement extends HTMLRenderElementBase {
  OptionGroupRenderElement(super.widget, super.parent);

  @override
  render({
    required covariant OptionGroup widget,
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
    required covariant OptionGroup oldWidget,
    required covariant OptionGroup newWidget,
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
  required OptionGroup widget,
  required OptionGroup? oldWidget,
}) {
  var attributes = <String, String?>{};

  if (widget.label != oldWidget?.label) {
    attributes[Attributes.label] = widget.label;
  }

  if (widget.disabled != oldWidget?.disabled) {
    if (null == widget.disabled || false == widget.disabled) {
      attributes[Attributes.disabled] = null;
    } else {
      attributes[Attributes.disabled] = 'true';
    }
  }

  return attributes;
}
