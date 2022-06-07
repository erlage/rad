// ignore_for_file: inference_failure_on_function_return_type

import 'package:meta/meta.dart';

import 'package:rad_test/src/imports.dart';

/// A widget that allows hooking its internals.
///
class TestWidget extends Widget {
  final Callback? roEventHookRender;
  final Callback? roEventHookUpdate;
  final Callback? roEventHookBeforeMount;
  final Callback? roEventHookAfterMount;
  final Callback? roEventHookAfterWidgetRebind;
  final Callback? roEventHookBeforeUnMount;

  final Callback? wEventHookCreateRenderObject;
  final Callback? wEventHookCreateWidgetConfiguration;
  final Callback? wEventHookIsConfigurationChanged;

  final Function(UpdateType)? roHookUpdate;

  final String hash;

  // overrides

  final WidgetConfiguration Function()? wOverrideCreateConfiguration;
  final bool Function()? wOverrideIsConfigurationChanged;

  final List<Widget>? children;

  const TestWidget({
    Key? key,
    this.children,
    this.roEventHookRender,
    this.roEventHookUpdate,
    this.roEventHookBeforeMount,
    this.roEventHookAfterMount,
    this.roEventHookAfterWidgetRebind,
    this.roEventHookBeforeUnMount,
    this.wEventHookCreateWidgetConfiguration,
    this.wEventHookIsConfigurationChanged,
    this.wEventHookCreateRenderObject,
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
    if (null != wEventHookCreateWidgetConfiguration) {
      wEventHookCreateWidgetConfiguration!();
    }

    if (null != wOverrideCreateConfiguration) {
      return wOverrideCreateConfiguration!();
    }

    return const WidgetConfiguration();
  }

  @override
  isConfigurationChanged(oldConfiguration) {
    if (null != wEventHookIsConfigurationChanged) {
      wEventHookIsConfigurationChanged!();
    }

    if (null != wOverrideIsConfigurationChanged) {
      return wOverrideIsConfigurationChanged!();
    }

    return true;
  }

  @override
  createRenderObject(context) {
    if (null != wEventHookCreateRenderObject) {
      wEventHookCreateRenderObject!();
    }

    return TestWidgetRenderObject(
      context,
      roEventHookRender: roEventHookRender,
      roEventHookUpdate: roEventHookUpdate,
      roEventHookAfterMount: roEventHookAfterMount,
      roEventHookAfterWidgetRebind: roEventHookAfterWidgetRebind,
      roEventHookBeforeUnMount: roEventHookBeforeUnMount,
      roHookUpdate: roHookUpdate,
    );
  }
}

class TestWidgetRenderObject extends RenderObject {
  final Callback? roEventHookRender;
  final Callback? roEventHookUpdate;
  final Callback? roEventHookAfterMount;
  final Callback? roEventHookAfterWidgetRebind;
  final Callback? roEventHookBeforeUnMount;

  final Function(UpdateType)? roHookUpdate;

  const TestWidgetRenderObject(
    BuildContext context, {
    this.roEventHookRender,
    this.roEventHookUpdate,
    this.roEventHookAfterMount,
    this.roEventHookAfterWidgetRebind,
    this.roEventHookBeforeUnMount,
    this.roHookUpdate,
  }) : super(context);

  @override
  render({required configuration}) {
    if (null != roEventHookRender) {
      roEventHookRender!();
    }

    return null;
  }

  @override
  update({
    required updateType,
    required oldConfiguration,
    required newConfiguration,
  }) {
    if (null != roEventHookUpdate) {
      roEventHookUpdate!();
    }

    if (null != roHookUpdate) {
      roHookUpdate!(updateType);
    }

    return null;
  }

  @override
  afterMount() {
    if (null != roEventHookAfterMount) {
      roEventHookAfterMount!();
    }
  }

  @override
  afterWidgetRebind({
    required updateType,
    required oldWidget,
    required newWidget,
  }) {
    if (null != roEventHookAfterWidgetRebind) {
      roEventHookAfterWidgetRebind!();
    }
  }

  @override
  beforeUnMount() {
    if (null != roEventHookBeforeUnMount) {
      roEventHookBeforeUnMount!();
    }
  }
}
