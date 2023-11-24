// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:html';

import 'package:meta/meta.dart';
import 'package:rad/rad.dart';

import 'package:rad_html_vscode/src/patch.dart';

/// Base class for HTML widgets that support global attributes.
///
@internal
abstract class HTMLWidgetBase extends Widget {
  /// Reference callback.
  ///
  /// Rad will call the ref callback with the DOM element before widget renders,
  /// and call it with null before it unmounts.
  ///
  /// Please note, similar to other event listeners, callback has to be present
  /// on the initial render.
  ///
  final void Function(Element? element)? ref;

  /// ID of dom node.
  ///
  final String? id;

  /// The title attribute specifies extra information about an dom node.
  ///
  final String? title;

  /// The style attribute for inline CSS.
  ///
  final String? style;

  /// The classes attribute specifies one or more class names for an dom node.
  ///
  final String? className;

  /// The hidden attribute is a boolean attribute.
  /// When present, it specifies that an dom node is not yet, or
  /// is no longer, relevant.
  ///
  final bool? hidden;

  /// Child widgets.
  ///
  final List<Widget> children;

  /// On click event listener.
  ///
  final EventCallback? onClick;

  /// Any additional attributes.
  ///
  final Map<String, String>? additionalAttributes;

  const HTMLWidgetBase(
    this.children, {
    Key? key,
    this.ref,
    this.id,
    this.title,
    this.style,
    this.className,
    this.hidden,
    this.onClick,
    this.additionalAttributes,
  }) : super(key: key);

  @override
  Map<DomEventType, EventCallback?> get widgetEventListeners {
    if (null == onClick) {
      return const {};
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
        style != oldWidget.style ||
        className != oldWidget.className ||
        hidden != oldWidget.hidden ||
        !fnIsKeyValueMapEqual(
          additionalAttributes,
          oldWidget.additionalAttributes,
        );
  }

  @override
  createRenderElement(parent) => HTMLRenderElementBase(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// Base element for HTML widgets.-
///
@internal
class HTMLRenderElementBase extends RenderElement {
  HTMLRenderElementBase(
    HTMLWidgetBase widget,
    RenderElement parent,
  )   :
        // prepare child widgets

        _widgetChildren = widget.children,

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
  void register() {
    assert(null != domNode, 'DomNode is not bound yet');

    var refCallback = (widget as HTMLWidgetBase).ref;
    if (null != refCallback) {
      refCallback(domNode);

      addRenderEventListeners({
        RenderEventType.willUnMount: (_) {
          refCallback(null);
        },
      });
    }
  }

  @mustCallSuper
  @override
  DomNodePatchFillable render({
    required widget,
  }) {
    widget as HTMLWidgetBase;

    var attributes = _prepareAttributes(
      widget: widget,
      oldWidget: null,
    );

    return DomNodePatchFillable(attributes: attributes, properties: {});
  }

  @mustCallSuper
  @override
  afterWidgetRebind({
    required oldWidget,
    required covariant HTMLWidgetBase newWidget,
    required updateType,
  }) {
    _widgetChildren = newWidget.children;
  }

  @mustCallSuper
  @override
  DomNodePatchFillable update({
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

    return DomNodePatchFillable(attributes: attributes, properties: {});
  }
}

/*
|--------------------------------------------------------------------------
| patch
|--------------------------------------------------------------------------
*/

Map<String, String?> _prepareAttributes({
  required HTMLWidgetBase widget,
  required HTMLWidgetBase? oldWidget,
}) {
  var attributes = <String, String?>{};

  // prepare additional attributes

  var additionalAttributes = widget.additionalAttributes;
  var oldAdditionalAttributes = oldWidget?.additionalAttributes;

  if (additionalAttributes != oldAdditionalAttributes) {
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

  if (widget.className != oldWidget?.className) {
    attributes[Attributes.className] = widget.className;
  }

  if (widget.hidden != oldWidget?.hidden) {
    if (null == widget.hidden || false == widget.hidden) {
      attributes[Attributes.hidden] = null;
    } else {
      attributes[Attributes.hidden] = 'true';
    }
  }

  return attributes;
}
