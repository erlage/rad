// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: camel_case_types

import 'package:meta/meta.dart';

import '../test_imports.dart';

/// A widget that allows hooking its internals.
///
class RT_TestWidget extends Widget {
  // widget events

  final VoidCallback? wEventCreateRenderObject;
  final VoidCallback? wEventshouldUpdateWidget;
  final VoidCallback? wEventshouldUpdateWidgetChildren;

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

  const RT_TestWidget({
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
    this.wEventshouldUpdateWidget,
    this.wEventshouldUpdateWidgetChildren,

    // overrides

    this.wOverrideShouldUpdateWidget,
    this.wOverrideShouldUpdateWidgetChildren,

    // data hokks

    this.roHookUpdate,
    this.wHookShouldUpdateWidget,
    this.wHookShouldUpdateWidgetChildren,
    String? customHash,
  })  : hash = customHash ?? 'none',
        super(key: key);

  @nonVirtual
  @override
  String get widgetType => 'RT_TestWidget';

  @override
  DomTagType get correspondingTag => DomTagType.division;

  @override
  bool shouldUpdateWidget(oldWidget) {
    if (null != wEventshouldUpdateWidget) {
      wEventshouldUpdateWidget!();
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
    if (null != wEventshouldUpdateWidgetChildren) {
      wEventshouldUpdateWidgetChildren!();
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

    return RT_TestRenderElement(
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
class RT_TestRenderElement extends WatchfulRenderElement {
  final VoidCallback? roEventInit;
  final VoidCallback? roEventRender;
  final VoidCallback? roEventUpdate;
  final VoidCallback? roEventAfterMount;
  final VoidCallback? roEventAfterWidgetRebind;
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
    this.roEventAfterUnMount,
    this.roHookUpdate,
  }) : super(widget, parent);

  @override
  List<Widget> get childWidgets => (widget as RT_TestWidget).children ?? [];

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
    VoidCallback? roEventAfterUnMount,
    VoidCallback? wEventCreateRenderObject,

    // should update

    VoidCallback? wEventshouldUpdateWidget,
    VoidCallback? wEventshouldUpdateWidgetChildren,
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
          roEventAfterUnMount: roEventAfterUnMount,
          wEventCreateRenderObject: wEventCreateRenderObject,

          // should update

          wEventshouldUpdateWidget: wEventshouldUpdateWidget,
          wEventshouldUpdateWidgetChildren: wEventshouldUpdateWidgetChildren,
          wOverrideShouldUpdateWidget: wOverrideShouldUpdateWidget,
          wOverrideShouldUpdateWidgetChildren:
              wOverrideShouldUpdateWidgetChildren,
          customHash: customHash,
        );
}
