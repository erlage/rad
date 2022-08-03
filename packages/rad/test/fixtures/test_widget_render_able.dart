// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: camel_case_types

import '../test_imports.dart';

/// A RenderAble widget for testing base render element.
///
class RT_RenderAbleWidget extends Widget {
  final VoidCallback? eventRegister;
  final VoidCallback? eventRender;
  final VoidCallback? eventUpdate;

  final RenderEventCallback? eventAfterRenderEffect;
  final RenderEventCallback? eventAfterUpdateEffect;
  final RenderEventCallback? eventBeforeUnMountEffect;
  final RenderEventCallback? eventAfterUnMountEffect;

  final List<Widget>? children;

  const RT_RenderAbleWidget({
    Key? key,
    this.eventRegister,
    this.eventRender,
    this.eventUpdate,
    this.eventAfterRenderEffect,
    this.eventAfterUpdateEffect,
    this.eventBeforeUnMountEffect,
    this.eventAfterUnMountEffect,
    this.children,
  }) : super(key: key);

  @override
  DomTagType? get correspondingTag => null;

  @override
  createRenderElement(parent) => _RenderAbleElement(this, parent);

  @override
  shouldUpdateWidget(oldWidget) => true;
}

class _RenderAbleElement extends RenderElement {
  _RenderAbleElement(
    RT_RenderAbleWidget widget,
    RenderElement parent,
  )   :
        // prepare child widgets

        _children = widget.children ?? const [],

        // base

        super(widget, parent);

  @override
  List<Widget> get widgetChildren => _children;
  List<Widget> _children;

  RT_RenderAbleWidget get currentWidget => widget as RT_RenderAbleWidget;

  @override
  void register() {
    if (null != currentWidget.eventRegister) {
      currentWidget.eventRegister!();
    }

    var eventListeners = <RenderEventType, RenderEventCallback>{};

    var afterRenderEffect = currentWidget.eventAfterRenderEffect;
    var afterUpdateEffect = currentWidget.eventAfterUpdateEffect;
    var beforeUnMountEffect = currentWidget.eventBeforeUnMountEffect;
    var afterUnMountEffect = currentWidget.eventAfterUnMountEffect;

    if (null != afterRenderEffect) {
      eventListeners[RenderEventType.afterRenderEffect] = afterRenderEffect;
    }

    if (null != afterUpdateEffect) {
      eventListeners[RenderEventType.afterUpdateEffect] = afterUpdateEffect;
    }

    if (null != beforeUnMountEffect) {
      eventListeners[RenderEventType.beforeUnMountEffect] = beforeUnMountEffect;
    }

    if (null != afterUnMountEffect) {
      eventListeners[RenderEventType.afterUnMountEffect] = afterUnMountEffect;
    }

    addRenderEventListeners(eventListeners);
  }

  @override
  render({required Widget widget}) {
    var patch = super.render(widget: widget);

    if (null != currentWidget.eventRender) {
      currentWidget.eventRender!();
    }

    return patch;
  }

  @override
  update({
    required UpdateType updateType,
    required Widget oldWidget,
    required Widget newWidget,
  }) {
    var patch = super.update(
      updateType: updateType,
      oldWidget: oldWidget,
      newWidget: newWidget,
    );

    if (null != currentWidget.eventUpdate) {
      currentWidget.eventUpdate!();
    }

    return patch;
  }

  @override
  afterWidgetRebind({
    required oldWidget,
    required covariant RT_RenderAbleWidget newWidget,
    required updateType,
  }) {
    _children = newWidget.children ?? const [];
  }
}
