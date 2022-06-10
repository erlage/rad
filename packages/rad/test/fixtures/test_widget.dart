// ignore_for_file: camel_case_types

import 'package:meta/meta.dart';

import '../test_imports.dart';

/// A widget that allows hooking its internals.
///
class RT_TestWidget extends Widget {
  // widget events

  final Callback? wEventCreateRenderObject;
  final Callback? wEventShouldUpdateWidget;
  final Callback? wEventShouldUpdateWidgetChildren;

  // render object events

  final Callback? roEventHookRender;
  final Callback? roEventHookUpdate;
  final Callback? roEventBeforeMount;
  final Callback? roEventHookAfterMount;
  final Callback? roEventAfterWidgetRebind;
  final Callback? roEventHookBeforeUnMount;

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

    this.roEventHookRender,
    this.roEventHookUpdate,
    this.roEventBeforeMount,
    this.roEventHookAfterMount,
    this.roEventAfterWidgetRebind,
    this.roEventHookBeforeUnMount,

    // widget events

    this.wEventCreateRenderObject,
    this.wEventShouldUpdateWidget,
    this.wEventShouldUpdateWidgetChildren,

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
  get widgetChildren => children ?? [];

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
  createRenderObject(context) {
    if (null != wEventCreateRenderObject) {
      wEventCreateRenderObject!();
    }

    return RT_TestWidgetRenderObject(
      context,
      roEventRender: roEventHookRender,
      roEventUpdate: roEventHookUpdate,
      roEventAfterMount: roEventHookAfterMount,
      roEventAfterWidgetRebind: roEventAfterWidgetRebind,
      roEventBeforeUnMount: roEventHookBeforeUnMount,
      roHookUpdate: roHookUpdate,
    );
  }
}

/// Render object of test widget.
///
class RT_TestWidgetRenderObject extends RenderObject {
  final Callback? roEventRender;
  final Callback? roEventUpdate;
  final Callback? roEventAfterMount;
  final Callback? roEventAfterWidgetRebind;
  final Callback? roEventBeforeUnMount;

  final Function(UpdateType)? roHookUpdate;

  const RT_TestWidgetRenderObject(
    BuildContext context, {
    this.roEventRender,
    this.roEventUpdate,
    this.roEventAfterMount,
    this.roEventAfterWidgetRebind,
    this.roEventBeforeUnMount,
    this.roHookUpdate,
  }) : super(context);

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
  beforeUnMount() {
    if (null != roEventBeforeUnMount) {
      roEventBeforeUnMount!();
    }
  }
}

/// Another test widget with different runtime type.
///
class RT_AnotherTestWidget extends RT_TestWidget {
  const RT_AnotherTestWidget({
    Key? key,
    List<Widget>? children,
    Callback? roEventHookRender,
    Callback? roEventHookUpdate,
    Callback? roEventAfterMount,
    Callback? roEventAfterWidgetRebind,
    Callback? roEventHookBeforeUnMount,
    Callback? wEventCreateRenderObject,

    // should update

    Callback? wEventShouldUpdateWidget,
    Callback? wEventShouldUpdateWidgetChildren,
    bool Function()? wOverrideShouldUpdateWidget,
    bool Function()? wOverrideShouldUpdateWidgetChildren,
    String? customHash,
  }) : super(
          key: key,
          children: children,
          roEventHookRender: roEventHookRender,
          roEventHookUpdate: roEventHookUpdate,
          roEventHookAfterMount: roEventAfterMount,
          roEventAfterWidgetRebind: roEventAfterWidgetRebind,
          roEventHookBeforeUnMount: roEventHookBeforeUnMount,
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
