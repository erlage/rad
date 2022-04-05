// ignore_for_file: camel_case_types

import 'dart:html';

import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// A widget that allows hooking its internals.
///
class RT_TestWidget extends Widget {
  final VoidCallback? roEventHookRender;
  final VoidCallback? roEventHookUpdate;
  final VoidCallback? roEventHookBeforeMount;
  final VoidCallback? roEventHookAfterMount;
  final VoidCallback? roEventHookAfterWidgetRebind;
  final VoidCallback? roEventHookBeforeUnMount;

  final VoidCallback? wEventHookCreateRenderObject;
  final VoidCallback? wEventHookCreateWidgetConfiguration;
  final VoidCallback? wEventHookIsConfigurationChanged;

  final List<Widget>? children;

  const RT_TestWidget({
    String? key,
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
  }) : super(key: key);

  @override
  get concreteType => '$RT_TestWidget';

  @override
  get correspondingTag => DomTag.division;

  @override
  get widgetChildren => children ?? [];

  @override
  createConfiguration() {
    if (null != wEventHookCreateWidgetConfiguration) {
      wEventHookCreateWidgetConfiguration!();
    }

    return const WidgetConfiguration();
  }

  @override
  isConfigurationChanged(oldConfiguration) {
    if (null != wEventHookIsConfigurationChanged) {
      wEventHookIsConfigurationChanged!();
    }

    return true;
  }

  @override
  createRenderObject(context) {
    if (null != wEventHookCreateRenderObject) {
      wEventHookCreateRenderObject!();
    }

    return RT_TestWidgetRenderObject(
      context,
      roEventHookRender: roEventHookRender,
      roEventHookUpdate: roEventHookUpdate,
      roEventHookBeforeMount: roEventHookBeforeMount,
      roEventHookAfterMount: roEventHookAfterMount,
      roEventHookAfterWidgetRebind: roEventHookAfterWidgetRebind,
      roEventHookBeforeUnMount: roEventHookBeforeUnMount,
    );
  }
}

class RT_TestWidgetRenderObject extends RenderObject {
  final VoidCallback? roEventHookRender;
  final VoidCallback? roEventHookUpdate;
  final VoidCallback? roEventHookBeforeMount;
  final VoidCallback? roEventHookAfterMount;
  final VoidCallback? roEventHookAfterWidgetRebind;
  final VoidCallback? roEventHookBeforeUnMount;

  const RT_TestWidgetRenderObject(
    BuildContext context, {
    this.roEventHookRender,
    this.roEventHookUpdate,
    this.roEventHookBeforeMount,
    this.roEventHookAfterMount,
    this.roEventHookAfterWidgetRebind,
    this.roEventHookBeforeUnMount,
  }) : super(context);

  @override
  render(element, configuration) {
    if (null != roEventHookRender) {
      roEventHookRender!();
    }
  }

  @override
  update({
    required element,
    required updateType,
    required oldConfiguration,
    required newConfiguration,
  }) {
    if (null != roEventHookUpdate) {
      roEventHookUpdate!();
    }
  }

  @override
  beforeMount() {
    if (null != roEventHookBeforeMount) {
      roEventHookBeforeMount!();
    }
  }

  @override
  afterMount() {
    if (null != roEventHookAfterMount) {
      roEventHookAfterMount!();
    }
  }

  @override
  afterWidgetRebind(updateType, oldWidget) {
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
