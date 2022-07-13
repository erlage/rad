// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/abstract/render_element.dart';
import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/functions.dart';
import 'package:rad/src/core/common/objects/cache.dart';
import 'package:rad/src/core/common/objects/dom_node_patch.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// Base class for HTML widgets that support global attributes.
///
@internal
abstract class HTMLWidgetBase extends Widget {
  /// ID of dom node.
  ///
  final String? id;

  /// The title attribute specifies extra information about an dom node.
  ///
  final String? title;

  /// The classes attribute specifies one or more class names for an dom node.
  ///
  final String? classAttribute;

  /// The style attribute for inline CSS.
  ///
  final String? style;

  /// The tabindex attribute specifies the tab order of an
  /// dom node (when the "tab" button is used for navigating).
  ///
  final int? tabIndex;

  /// The draggable attribute specifies whether an dom node
  /// is draggable or not.
  ///
  final bool? draggable;

  /// The contentEditable attribute specifies whether the content of an
  /// dom node is editable or not.
  ///
  final bool? contentEditable;

  /// The hidden attribute is a boolean attribute.
  /// When present, it specifies that an dom node is not yet, or
  /// is no longer, relevant.
  ///
  final bool? hidden;

  /// onClick raw attribute. for inlined JS callback: onclick="<someJS>"
  ///
  final String? onClickAttribute;

  /// Element's inner text.
  ///
  /// A widget can either have [innerText] or [children] list.
  ///
  final String? innerText;

  /// Children tags.
  ///
  /// A widget can either have [innerText] or [children] list.
  ///
  final List<Widget>? children;

  /// On click event listener.
  ///
  final EventCallback? onClick;

  /// Any additional attributes.
  ///
  final Map<String, String>? additionalAttributes;

  const HTMLWidgetBase({
    Key? key,
    this.id,
    this.title,
    this.tabIndex,
    this.style,
    this.classAttribute,
    this.hidden,
    this.draggable,
    this.contentEditable,
    this.onClickAttribute,
    this.innerText,
    this.children,
    this.onClick,
    this.additionalAttributes,
  })  : assert(
          null == children || null == innerText,
          'A widget can have either innerText or children list.',
        ),
        super(key: key);

  @override
  Map<DomEventType, EventCallback?> get widgetEventListeners {
    if (null == onClick) {
      return ccImmutableEmptyMapOfEventListeners;
    }

    return {
      DomEventType.click: onClick,
    };
  }

  @override
  bool shouldUpdateWidget(oldWidget) {
    oldWidget as HTMLWidgetBase;

    return id != oldWidget.id ||
        title != oldWidget.title ||
        tabIndex != oldWidget.tabIndex ||
        style != oldWidget.style ||
        classAttribute != oldWidget.classAttribute ||
        hidden != oldWidget.hidden ||
        draggable != oldWidget.draggable ||
        contentEditable != oldWidget.contentEditable ||
        onClickAttribute != oldWidget.onClickAttribute ||
        innerText != oldWidget.innerText ||
        !fnIsKeyValueMapEqual(
          additionalAttributes,
          oldWidget.additionalAttributes,
        );
  }

  @override
  createRenderElement(parent) => HTMLBaseElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// Base element for HTML widgets.-
///
@internal
class HTMLBaseElement extends RenderElement {
  HTMLBaseElement(
    HTMLWidgetBase widget,
    RenderElement parent,
  )   :
        // prepare child widgets

        _widgetChildren = widget.children ?? ccImmutableEmptyListOfWidgets,

        // base

        super(widget, parent);

  @override
  List<Widget> get widgetChildren => _widgetChildren;
  List<Widget> _widgetChildren;

  /*
  |--------------------------------------------------------------------------
  | lifecycle hooks
  |-------------------------------------------------------------------------
  */

  @mustCallSuper
  @override
  render({
    required widget,
  }) {
    widget as HTMLWidgetBase;

    var attributes = _prepareAttributes(
      widget: widget,
      oldWidget: null,
    );

    var properties = _prepareProperties(
      widget: widget,
      oldWidget: null,
    );

    return DomNodePatch(attributes: attributes, properties: properties);
  }

  @mustCallSuper
  @override
  afterWidgetRebind({
    required oldWidget,
    required covariant HTMLWidgetBase newWidget,
    required updateType,
  }) {
    _widgetChildren = newWidget.children ?? ccImmutableEmptyListOfWidgets;
  }

  @mustCallSuper
  @override
  update({
    required updateType,
    required oldWidget,
    required newWidget,
  }) {
    oldWidget as HTMLWidgetBase;
    newWidget as HTMLWidgetBase;

    var attributes = _prepareAttributes(
      widget: newWidget,
      oldWidget: oldWidget,
    );

    var properties = _prepareProperties(
      widget: newWidget,
      oldWidget: oldWidget,
    );

    return DomNodePatch(attributes: attributes, properties: properties);
  }
}

/*
|--------------------------------------------------------------------------
| props
|--------------------------------------------------------------------------
*/

Map<String, String?> _prepareAttributes({
  required HTMLWidgetBase widget,
  required HTMLWidgetBase? oldWidget,
}) {
  // prepare additional attributes

  var attributes = <String, String?>{};

  var additionalAttributes = widget.additionalAttributes;
  var oldAdditionalAttributes = oldWidget?.additionalAttributes;

  if (null != additionalAttributes) {
    for (final attributeName in additionalAttributes.keys) {
      attributes[attributeName] = additionalAttributes[attributeName];
    }
  }

  if (null != oldAdditionalAttributes) {
    for (final attributeName in oldAdditionalAttributes.keys) {
      if (!attributes.containsKey(attributeName)) {
        attributes[attributeName] = null;
      }
    }
  }

  // prepare main attributes

  if (widget.id != oldWidget?.id) {
    attributes[Attributes.id] = widget.id;
  }

  if (widget.title != oldWidget?.title) {
    attributes[Attributes.title] = widget.title;
  }

  if (widget.style != oldWidget?.style) {
    attributes[Attributes.style] = widget.style;
  }

  if (widget.classAttribute != oldWidget?.classAttribute) {
    attributes[Attributes.classAttribute] = widget.classAttribute;
  }

  if (widget.tabIndex != oldWidget?.tabIndex) {
    if (null == widget.tabIndex) {
      attributes[Attributes.tabIndex] = null;
    } else {
      attributes[Attributes.tabIndex] = '${widget.tabIndex}';
    }
  }

  if (widget.hidden != oldWidget?.hidden) {
    if (null == widget.hidden || false == widget.hidden) {
      attributes[Attributes.hidden] = null;
    } else {
      attributes[Attributes.hidden] = 'true';
    }
  }

  if (widget.draggable != oldWidget?.draggable) {
    if (null == widget.draggable) {
      attributes[Attributes.draggable] = null;
    } else {
      if (true == widget.draggable) {
        attributes[Attributes.draggable] = 'true';
      } else {
        attributes[Attributes.draggable] = 'false';
      }
    }
  }

  if (widget.contentEditable != oldWidget?.contentEditable) {
    if (null == widget.contentEditable) {
      attributes[Attributes.contentEditable] = null;
    } else {
      if (true == widget.contentEditable) {
        attributes[Attributes.contentEditable] = 'true';
      } else {
        attributes[Attributes.contentEditable] = 'false';
      }
    }
  }

  if (widget.onClickAttribute != oldWidget?.onClickAttribute) {
    attributes[Attributes.onClickAttribute] = widget.onClickAttribute;
  }

  return attributes;
}

Map<String, String?> _prepareProperties({
  required HTMLWidgetBase widget,
  required HTMLWidgetBase? oldWidget,
}) {
  var properties = <String, String?>{};

  if (widget.innerText != oldWidget?.innerText) {
    properties[Properties.innerText] = widget.innerText;
  }

  return properties;
}
