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

  /// The data-* attributes is used to store custom data
  /// private to the page or application.
  ///
  final Map<String, String>? dataAttributes;

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
  /// Only one thing can be set at a time between [innerText]
  /// , [children] and [child]
  ///
  final String? innerText;

  /// Single child tag.
  ///
  /// If you want to add multiple child widgets, then use [children]
  ///
  /// Only one thing can be set at a time between [innerText]
  /// , [children] and [child]
  ///
  final Widget? child;

  /// Children tags.
  ///
  /// Only one thing can be set at a time between [innerText]
  /// , [children] and [child]
  ///
  final List<Widget>? children;

  /// On click event listener.
  ///
  final EventCallback? onClick;

  const HTMLWidgetBase({
    Key? key,
    this.id,
    this.title,
    this.tabIndex,
    this.style,
    this.classAttribute,
    this.dataAttributes,
    this.hidden,
    this.draggable,
    this.contentEditable,
    this.onClickAttribute,
    this.innerText,
    this.child,
    this.children,
    this.onClick,
  })  : assert(
          (null == children && null == child) ||
              (null == child && null == innerText) ||
              (null == children && null == innerText),
          'At least two thing from child, children & innerText has to be null.',
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
        !fnIsKeyValueMapEqual(dataAttributes, oldWidget.dataAttributes);
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

        _childWidgets = widget.children ??
            (null != widget.child
                ? [widget.child!]
                : ccImmutableEmptyListOfWidgets),

        // base

        super(widget, parent);

  @override
  List<Widget> get childWidgets => _childWidgets;
  List<Widget> _childWidgets;

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

    var dataset = fnCommonPrepareDataset(
      dataAttributes: widget.dataAttributes,
      oldDataAttributes: null,
    );

    return DomNodePatch(
      dataset: dataset,
      attributes: attributes,
      textContents: widget.innerText,
    );
  }

  @mustCallSuper
  @override
  afterWidgetRebind({
    required oldWidget,
    required covariant HTMLWidgetBase newWidget,
    required updateType,
  }) {
    _childWidgets = newWidget.children ??
        (null != newWidget.child
            ? [newWidget.child!]
            : ccImmutableEmptyListOfWidgets);
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

    var dataset = fnCommonPrepareDataset(
      dataAttributes: newWidget.dataAttributes,
      oldDataAttributes: oldWidget.dataAttributes,
    );

    return DomNodePatch(
      dataset: dataset,
      attributes: attributes,
      textContents: newWidget.innerText,
    );
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
  var attributes = <String, String?>{};

  if (null != widget.id) {
    attributes[Attributes.id] = widget.id;
  } else {
    if (null != oldWidget?.id) {
      attributes[Attributes.id] = null;
    }
  }

  if (null != widget.title) {
    attributes[Attributes.title] = widget.title;
  } else {
    if (null != oldWidget?.title) {
      attributes[Attributes.title] = null;
    }
  }

  if (null != widget.style) {
    attributes[Attributes.style] = widget.style;
  } else {
    if (null != oldWidget?.style) {
      attributes[Attributes.style] = null;
    }
  }

  if (null != widget.classAttribute) {
    attributes[Attributes.classAttribute] = widget.classAttribute;
  } else {
    if (null != oldWidget?.classAttribute) {
      attributes[Attributes.classAttribute] = null;
    }
  }

  if (null != widget.tabIndex) {
    attributes[Attributes.tabIndex] = '${widget.tabIndex}';
  } else {
    if (null != oldWidget?.tabIndex) {
      attributes[Attributes.tabIndex] = null;
    }
  }

  if (null != widget.hidden && widget.hidden!) {
    attributes[Attributes.hidden] = '${widget.hidden}';
  } else {
    if (null != oldWidget?.hidden) {
      attributes[Attributes.hidden] = null;
    }
  }

  if (null != widget.draggable) {
    attributes[Attributes.draggable] = '${widget.draggable}';
  } else {
    if (null != oldWidget?.draggable) {
      attributes[Attributes.draggable] = null;
    }
  }

  if (null != widget.contentEditable) {
    attributes[Attributes.contentEditable] = '${widget.contentEditable}';
  } else {
    if (null != oldWidget?.contentEditable) {
      attributes[Attributes.contentEditable] = null;
    }
  }

  if (null != widget.onClickAttribute) {
    attributes[Attributes.onClickAttribute] = widget.onClickAttribute;
  } else {
    if (null != oldWidget?.onClickAttribute) {
      attributes[Attributes.onClickAttribute] = null;
    }
  }

  return attributes;
}
