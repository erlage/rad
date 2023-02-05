// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: inference_failure_on_function_return_type
// ignore_for_file: invalid_use_of_internal_member

import 'package:rad_test/src/imports.dart';

/// A widget that allows hooking its internals.
///
class TestWidget extends Widget {
  // widget events

  final VoidCallback? wEventCreateRenderObject;
  final VoidCallback? wEventShouldUpdateWidget;
  final VoidCallback? wEventShouldUpdateWidgetChildren;

  // render element events

  final VoidCallback? roEventInit;
  final VoidCallback? roEventRender;
  final VoidCallback? roEventUpdate;
  final VoidCallback? roEventBeforeMount;
  final VoidCallback? roEventAfterMount;
  final VoidCallback? roEventAfterWidgetRebind;
  final VoidCallback? roEventAfterUnMount;

  // data hooks

  final Function(Widget)? wHookShouldUpdateWidget;
  final Function(Widget, bool)? wHookShouldUpdateWidgetChildren;
  final Function(UpdateType)? roHookUpdate;

  // overrides

  final bool Function()? wOverrideShouldUpdateWidget;
  final bool Function()? wOverrideShouldUpdateWidgetChildren;

  final List<Widget>? children;

  final String hash;

  const TestWidget({
    Key? key,
    this.children,

    // render object events

    this.roEventInit,
    this.roEventRender,
    this.roEventUpdate,
    this.roEventBeforeMount,
    this.roEventAfterMount,
    this.roEventAfterWidgetRebind,
    this.roEventAfterUnMount,

    // widget events

    this.wEventCreateRenderObject,
    this.wEventShouldUpdateWidget,
    this.wEventShouldUpdateWidgetChildren,

    // overrides

    this.wOverrideShouldUpdateWidget,
    this.wOverrideShouldUpdateWidgetChildren,

    // data hooks

    this.roHookUpdate,
    this.wHookShouldUpdateWidget,
    this.wHookShouldUpdateWidgetChildren,
    String? customHash,
  })  : hash = customHash ?? 'none',
        super(key: key);

  @override
  DomTagType get correspondingTag => DomTagType.division;

  @override
  bool shouldUpdateWidget(oldWidget) {
    if (null != wEventShouldUpdateWidget) {
      wEventShouldUpdateWidget!();
    }

    if (null != wHookShouldUpdateWidget) {
      wHookShouldUpdateWidget!(oldWidget);
    }

    if (null != wOverrideShouldUpdateWidget) {
      return wOverrideShouldUpdateWidget!();
    }

    return true;
  }

  @override
  bool shouldUpdateWidgetChildren(oldWidget, shouldUpdateWidget) {
    if (null != wEventShouldUpdateWidgetChildren) {
      wEventShouldUpdateWidgetChildren!();
    }

    if (null != wHookShouldUpdateWidgetChildren) {
      wHookShouldUpdateWidgetChildren!(oldWidget, shouldUpdateWidget);
    }

    if (null != wOverrideShouldUpdateWidgetChildren) {
      return wOverrideShouldUpdateWidgetChildren!();
    }

    return true;
  }

  @override
  createRenderElement(parent) {
    if (null != wEventCreateRenderObject) {
      wEventCreateRenderObject!();
    }

    return TestRenderElement(
      this,
      parent,
      roEventInit: roEventInit,
      roEventRender: roEventRender,
      roEventUpdate: roEventUpdate,
      roEventAfterMount: roEventAfterMount,
      roEventAfterWidgetRebind: roEventAfterWidgetRebind,
      roEventAfterUnMount: roEventAfterUnMount,
      roHookUpdate: roHookUpdate,
    );
  }
}

/// Render object of test widget.
///
class TestRenderElement extends WatchfulRenderElement {
  final VoidCallback? roEventInit;
  final VoidCallback? roEventRender;
  final VoidCallback? roEventUpdate;
  final VoidCallback? roEventAfterMount;
  final VoidCallback? roEventAfterWidgetRebind;
  final VoidCallback? roEventAfterUnMount;

  final Function(UpdateType)? roHookUpdate;

  TestRenderElement(
    TestWidget widget,
    RenderElement parent, {
    this.roEventInit,
    this.roEventRender,
    this.roEventUpdate,
    this.roEventAfterMount,
    this.roEventAfterWidgetRebind,
    this.roEventAfterUnMount,
    this.roHookUpdate,
  }) : super(widget, parent);

  @override
  List<Widget> get widgetChildren => (widget as TestWidget).children ?? [];

  @override
  init() {
    if (null != roEventInit) {
      roEventInit!();
    }
  }

  @override
  render({required widget}) {
    if (null != roEventRender) {
      roEventRender!();
    }

    return null;
  }

  @override
  update({
    required updateType,
    required oldWidget,
    required newWidget,
  }) {
    if (null != roEventUpdate) {
      roEventUpdate!();
    }

    if (null != roHookUpdate) {
      roHookUpdate!(updateType);
    }

    return null;
  }

  @override
  afterMount() {
    if (null != roEventAfterMount) {
      roEventAfterMount!();
    }
  }

  @override
  afterWidgetRebind({
    required updateType,
    required oldWidget,
    required newWidget,
  }) {
    if (null != roEventAfterWidgetRebind) {
      roEventAfterWidgetRebind!();
    }
  }

  @override
  afterUnMount() {
    if (null != roEventAfterUnMount) {
      roEventAfterUnMount!();
    }
  }
}
