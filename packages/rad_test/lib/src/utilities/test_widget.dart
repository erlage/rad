// ignore_for_file: inference_failure_on_function_return_type

import 'package:meta/meta.dart';

import 'package:rad_test/src/imports.dart';

/// A widget that allows hooking its internals.
///
class TestWidget extends Widget {
  final Callback? roEventRender;
  final Callback? roEventUpdate;
  final Callback? roEventBeforeMount;
  final Callback? roEventAfterMount;
  final Callback? roEventAfterWidgetRebind;
  final Callback? roEventBeforeUnMount;

  final Callback? wEventCreateRenderObject;
  final Callback? wEventCreateWidgetConfiguration;
  final Callback? wEventIsConfigurationChanged;

  final Function(UpdateType)? roHookUpdate;

  final String hash;

  // overrides

  final WidgetConfiguration Function()? wOverrideCreateConfiguration;
  final bool Function()? wOverrideIsConfigurationChanged;

  final List<Widget>? children;

  const TestWidget({
    Key? key,
    this.children,
    this.roEventRender,
    this.roEventUpdate,
    this.roEventBeforeMount,
    this.roEventAfterMount,
    this.roEventAfterWidgetRebind,
    this.roEventBeforeUnMount,
    this.wEventCreateWidgetConfiguration,
    this.wEventIsConfigurationChanged,
    this.wEventCreateRenderObject,
    this.wOverrideCreateConfiguration,
    this.wOverrideIsConfigurationChanged,
    this.roHookUpdate,
    String? customHash,
  })  : hash = customHash ?? 'none',
        super(key: key);

  @nonVirtual
  @override
  String get widgetType => '$TestWidget';

  @override
  DomTagType get correspondingTag => DomTagType.division;

  @override
  get widgetChildren => children ?? [];

  @override
  createConfiguration() {
    if (null != wEventCreateWidgetConfiguration) {
      wEventCreateWidgetConfiguration!();
    }

    if (null != wOverrideCreateConfiguration) {
      return wOverrideCreateConfiguration!();
    }

    return const WidgetConfiguration();
  }

  @override
  isConfigurationChanged(oldConfiguration) {
    if (null != wEventIsConfigurationChanged) {
      wEventIsConfigurationChanged!();
    }

    if (null != wOverrideIsConfigurationChanged) {
      return wOverrideIsConfigurationChanged!();
    }

    return true;
  }

  @override
  createRenderObject(context) {
    if (null != wEventCreateRenderObject) {
      wEventCreateRenderObject!();
    }

    return TestWidgetRenderObject(
      context,
      roEventRender: roEventRender,
      roEventUpdate: roEventUpdate,
      roEventAfterMount: roEventAfterMount,
      roEventAfterWidgetRebind: roEventAfterWidgetRebind,
      roEventBeforeUnMount: roEventBeforeUnMount,
      roHookUpdate: roHookUpdate,
    );
  }
}

class TestWidgetRenderObject extends RenderObject {
  final Callback? roEventRender;
  final Callback? roEventUpdate;
  final Callback? roEventAfterMount;
  final Callback? roEventAfterWidgetRebind;
  final Callback? roEventBeforeUnMount;

  final Function(UpdateType)? roHookUpdate;

  const TestWidgetRenderObject(
    BuildContext context, {
    this.roEventRender,
    this.roEventUpdate,
    this.roEventAfterMount,
    this.roEventAfterWidgetRebind,
    this.roEventBeforeUnMount,
    this.roHookUpdate,
  }) : super(context);

  @override
  render({required configuration}) {
    if (null != roEventRender) {
      roEventRender!();
    }

    return null;
  }

  @override
  update({
    required updateType,
    required oldConfiguration,
    required newConfiguration,
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
