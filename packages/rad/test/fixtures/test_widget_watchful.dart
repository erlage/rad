// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: camel_case_types

import '../test_imports.dart';

/// A watchful widget for testing.
///
class RT_WatchfulWidget extends Widget {
  final VoidCallback? eventInit;
  final VoidCallback? eventAfterMount;
  final VoidCallback? eventRender;
  final VoidCallback? eventUpdate;
  final VoidCallback? eventAfterUpdate;
  final VoidCallback? eventDispose;
  final VoidCallback? eventAfterUnMount;

  final List<Widget>? children;

  const RT_WatchfulWidget({
    Key? key,
    this.eventInit,
    this.eventRender,
    this.eventUpdate,
    this.eventAfterMount,
    this.eventAfterUpdate,
    this.eventDispose,
    this.eventAfterUnMount,
    this.children,
  }) : super(key: key);

  @override
  DomTagType? get correspondingTag => null;

  @override
  createRenderElement(parent) => _WatchfulElement(this, parent);

  @override
  shouldUpdateWidget(oldWidget) => true;
}

class _WatchfulElement extends WatchfulRenderElement {
  _WatchfulElement(
    RT_WatchfulWidget widget,
    RenderElement parent,
  )   :
        // prepare child widgets

        _children = widget.children ?? const [],

        // base

        super(widget, parent);

  @override
  List<Widget> get widgetChildren => _children;
  List<Widget> _children;

  RT_WatchfulWidget get currentWidget => widget as RT_WatchfulWidget;

  @override
  void init() {
    super.init();

    if (null != currentWidget.eventInit) {
      currentWidget.eventInit!();
    }
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
  void afterMount() {
    super.afterMount();

    if (null != currentWidget.eventAfterMount) {
      currentWidget.eventAfterMount!();
    }
  }

  @override
  void afterUpdate() {
    super.afterUpdate();

    if (null != currentWidget.eventAfterUpdate) {
      currentWidget.eventAfterUpdate!();
    }
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
  void dispose() {
    super.dispose();

    if (null != currentWidget.eventDispose) {
      currentWidget.eventDispose!();
    }
  }

  @override
  void afterUnMount() {
    super.afterUnMount();

    if (null != currentWidget.eventAfterUnMount) {
      currentWidget.eventAfterUnMount!();
    }
  }

  @override
  afterWidgetRebind({
    required oldWidget,
    required covariant RT_WatchfulWidget newWidget,
    required updateType,
  }) {
    _children = newWidget.children ?? const [];
  }
}
