// Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: camel_case_types

import '../test_imports.dart';

/// A widget that allows hooking its internals.
///
class RT_TestWidget extends Widget {
  // widget events

  final VoidCallback? wEventCreateRenderObject;
  final VoidCallback? wEventShouldUpdateWidget;
  final VoidCallback? wEventShouldUpdateWidgetChildren;

  final Function(RenderElement)? wHookCreateRenderElement;

  // render element events

  final VoidCallback? roEventInit;
  final VoidCallback? roEventRender;
  final VoidCallback? roEventUpdate;
  final VoidCallback? roEventAfterMount;
  final VoidCallback? roEventAfterWidgetRebind;
  final VoidCallback? roEventDispose;
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

  const RT_TestWidget({
    Key? key,
    this.children,
    this.wHookCreateRenderElement,

    // render object events

    this.roEventInit,
    this.roEventRender,
    this.roEventUpdate,
    this.roEventAfterMount,
    this.roEventAfterWidgetRebind,
    this.roEventDispose,
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

    var renderElement = RT_TestRenderElement(
      this,
      parent,
      roEventInit: roEventInit,
      roEventRender: roEventRender,
      roEventUpdate: roEventUpdate,
      roEventAfterMount: roEventAfterMount,
      roEventAfterWidgetRebind: roEventAfterWidgetRebind,
      roEventDispose: roEventDispose,
      roEventAfterUnMount: roEventAfterUnMount,
      roHookUpdate: roHookUpdate,
    );

    if (null != wHookCreateRenderElement) {
      wHookCreateRenderElement!(renderElement);
    }

    return renderElement;
  }
}

/// Render object of test widget.
///
class RT_TestRenderElement extends WatchfulRenderElement {
  final VoidCallback? roEventInit;
  final VoidCallback? roEventRender;
  final VoidCallback? roEventUpdate;
  final VoidCallback? roEventAfterMount;
  final VoidCallback? roEventAfterWidgetRebind;
  final VoidCallback? roEventDispose;
  final VoidCallback? roEventAfterUnMount;

  final Function(UpdateType)? roHookUpdate;

  RT_TestRenderElement(
    RT_TestWidget widget,
    RenderElement parent, {
    this.roEventInit,
    this.roEventRender,
    this.roEventUpdate,
    this.roEventAfterMount,
    this.roEventAfterWidgetRebind,
    this.roEventDispose,
    this.roEventAfterUnMount,
    this.roHookUpdate,
  }) : super(widget, parent);

  @override
  List<Widget> get widgetChildren => (widget as RT_TestWidget).children ?? [];

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
  dispose() {
    if (null != roEventDispose) {
      roEventDispose!();
    }
  }

  @override
  afterUnMount() {
    if (null != roEventAfterUnMount) {
      roEventAfterUnMount!();
    }
  }
}

/// Another test widget with different runtime type.
///
class RT_AnotherTestWidget extends RT_TestWidget {
  const RT_AnotherTestWidget({
    Key? key,
    List<Widget>? children,
    VoidCallback? roEventRender,
    VoidCallback? roEventUpdate,
    VoidCallback? roEventAfterMount,
    VoidCallback? roEventAfterWidgetRebind,
    VoidCallback? roEventDispose,
    VoidCallback? roEventAfterUnMount,
    VoidCallback? wEventCreateRenderObject,

    // should update

    VoidCallback? wEventShouldUpdateWidget,
    VoidCallback? wEventShouldUpdateWidgetChildren,
    bool Function()? wOverrideShouldUpdateWidget,
    bool Function()? wOverrideShouldUpdateWidgetChildren,
    String? customHash,
  }) : super(
          key: key,
          children: children,
          roEventRender: roEventRender,
          roEventUpdate: roEventUpdate,
          roEventAfterMount: roEventAfterMount,
          roEventAfterWidgetRebind: roEventAfterWidgetRebind,
          roEventDispose: roEventDispose,
          roEventAfterUnMount: roEventAfterUnMount,
          wEventCreateRenderObject: wEventCreateRenderObject,

          // should update

          wEventShouldUpdateWidget: wEventShouldUpdateWidget,
          wEventShouldUpdateWidgetChildren: wEventShouldUpdateWidgetChildren,
          wOverrideShouldUpdateWidget: wOverrideShouldUpdateWidget,
          wOverrideShouldUpdateWidgetChildren:
              wOverrideShouldUpdateWidgetChildren,
          customHash: customHash,
        );
}
