// ignore_for_file: camel_case_types

import 'package:meta/meta.dart';

import '../test_imports.dart';

/// A widget that allows hooking its internals.
///
class RT_TestWidget extends Widget {
  // widget events

  final Callback? wEventCreateRenderObject;
  final Callback? wEventshouldWidgetUpdate;
  final Callback? wEventshouldWidgetChildrenUpdate;

  // render element events

  final Callback? roEventRender;
  final Callback? roEventUpdate;
  final Callback? roEventBeforeMount;
  final Callback? roEventAfterMount;
  final Callback? roEventAfterWidgetRebind;
  final Callback? roEventBeforeUnMount;

  // data hooks

  final Function(Widget)? wHookShouldWidgetUpdate;
  final Function(Widget, bool)? wHookShouldWidgetChildrenUpdate;
  final Function(UpdateType)? roHookUpdate;

  // overrides

  final bool Function()? wOverrideShouldWidgetUpdate;
  final bool Function()? wOverrideShouldWidgetChildrenUpdate;

  final List<Widget>? children;

  final String hash;

  const RT_TestWidget({
    Key? key,
    this.children,

    // render object events

    this.roEventRender,
    this.roEventUpdate,
    this.roEventBeforeMount,
    this.roEventAfterMount,
    this.roEventAfterWidgetRebind,
    this.roEventBeforeUnMount,

    // widget events

    this.wEventCreateRenderObject,
    this.wEventshouldWidgetUpdate,
    this.wEventshouldWidgetChildrenUpdate,

    // overrides

    this.wOverrideShouldWidgetUpdate,
    this.wOverrideShouldWidgetChildrenUpdate,

    // data hokks

    this.roHookUpdate,
    this.wHookShouldWidgetUpdate,
    this.wHookShouldWidgetChildrenUpdate,
    String? customHash,
  })  : hash = customHash ?? 'none',
        super(key: key);

  @nonVirtual
  @override
  String get widgetType => 'RT_TestWidget';

  @override
  DomTagType get correspondingTag => DomTagType.division;

  @override
  bool shouldWidgetUpdate(oldWidget) {
    if (null != wEventshouldWidgetUpdate) {
      wEventshouldWidgetUpdate!();
    }

    if (null != wHookShouldWidgetUpdate) {
      wHookShouldWidgetUpdate!(oldWidget);
    }

    if (null != wOverrideShouldWidgetUpdate) {
      return wOverrideShouldWidgetUpdate!();
    }

    return true;
  }

  @override
  bool shouldWidgetChildrenUpdate(oldWidget, shouldWidgetUpdate) {
    if (null != wEventshouldWidgetChildrenUpdate) {
      wEventshouldWidgetChildrenUpdate!();
    }

    if (null != wHookShouldWidgetChildrenUpdate) {
      wHookShouldWidgetChildrenUpdate!(oldWidget, shouldWidgetUpdate);
    }

    if (null != wOverrideShouldWidgetChildrenUpdate) {
      return wOverrideShouldWidgetChildrenUpdate!();
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
      roEventRender: roEventRender,
      roEventUpdate: roEventUpdate,
      roEventAfterMount: roEventAfterMount,
      roEventAfterWidgetRebind: roEventAfterWidgetRebind,
      roEventBeforeUnMount: roEventBeforeUnMount,
      roHookUpdate: roHookUpdate,
    );
  }
}

/// Render object of test widget.
///
class RT_TestRenderElement extends RenderElement {
  final Callback? roEventRender;
  final Callback? roEventUpdate;
  final Callback? roEventAfterMount;
  final Callback? roEventAfterWidgetRebind;
  final Callback? roEventBeforeUnMount;

  final Function(UpdateType)? roHookUpdate;

  RT_TestRenderElement(
    RT_TestWidget widget,
    RenderElement parent, {
    this.roEventRender,
    this.roEventUpdate,
    this.roEventAfterMount,
    this.roEventAfterWidgetRebind,
    this.roEventBeforeUnMount,
    this.roHookUpdate,
  }) : super(widget, parent);

  @override
  List<Widget> get childWidgets => (widget as RT_TestWidget).children ?? [];

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
    Callback? roEventRender,
    Callback? roEventUpdate,
    Callback? roEventAfterMount,
    Callback? roEventAfterWidgetRebind,
    Callback? roEventBeforeUnMount,
    Callback? wEventCreateRenderObject,

    // should update

    Callback? wEventshouldWidgetUpdate,
    Callback? wEventshouldWidgetChildrenUpdate,
    bool Function()? wOverrideShouldWidgetUpdate,
    bool Function()? wOverrideShouldWidgetChildrenUpdate,
    String? customHash,
  }) : super(
          key: key,
          children: children,
          roEventRender: roEventRender,
          roEventUpdate: roEventUpdate,
          roEventAfterMount: roEventAfterMount,
          roEventAfterWidgetRebind: roEventAfterWidgetRebind,
          roEventBeforeUnMount: roEventBeforeUnMount,
          wEventCreateRenderObject: wEventCreateRenderObject,

          // should update

          wEventshouldWidgetUpdate: wEventshouldWidgetUpdate,
          wEventshouldWidgetChildrenUpdate: wEventshouldWidgetChildrenUpdate,
          wOverrideShouldWidgetUpdate: wOverrideShouldWidgetUpdate,
          wOverrideShouldWidgetChildrenUpdate:
              wOverrideShouldWidgetChildrenUpdate,
          customHash: customHash,
        );
}
