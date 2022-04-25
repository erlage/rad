// ignore_for_file: camel_case_types

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/render_object.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/core/common/objects/key.dart';

/// A widget that allows hooking its internals.
///
class RT_TestWidget extends Widget {
  final Callback? roEventHookRender;
  final Callback? roEventHookUpdate;
  final Callback? roEventHookBeforeMount;
  final Callback? roEventHookAfterMount;
  final Callback? roEventHookAfterWidgetRebind;
  final Callback? roEventHookBeforeUnMount;

  final Callback? wEventHookCreateRenderObject;
  final Callback? wEventHookCreateWidgetConfiguration;
  final Callback? wEventHookIsConfigurationChanged;

  final String hash;

  // overrides

  final WidgetConfiguration Function()? wOverrideCreateConfiguration;
  final bool Function()? wOverrideIsConfigurationChanged;

  final List<Widget>? children;

  const RT_TestWidget({
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
    String? customHash,
  })  : hash = customHash ?? 'none',
        super(key: key);

  @nonVirtual
  @override
  get widgetType => '$RT_TestWidget';

  @override
  get correspondingTag => DomTag.division;

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

/// Another test widget with different runtime type.
///
class RT_AnotherTestWidget extends RT_TestWidget {
  const RT_AnotherTestWidget({
    Key? key,
    List<Widget>? children,
    Callback? roEventHookRender,
    Callback? roEventHookUpdate,
    Callback? roEventHookBeforeMount,
    Callback? roEventHookAfterMount,
    Callback? roEventHookAfterWidgetRebind,
    Callback? roEventHookBeforeUnMount,
    Callback? wEventHookCreateRenderObject,
    Callback? wEventHookCreateWidgetConfiguration,
    Callback? wEventHookIsConfigurationChanged,
    WidgetConfiguration Function()? wOverrideCreateConfiguration,
    bool Function()? wOverrideIsConfigurationChanged,
    String? customHash,
  }) : super(
          key: key,
          children: children,
          roEventHookRender: roEventHookRender,
          roEventHookUpdate: roEventHookUpdate,
          roEventHookBeforeMount: roEventHookBeforeMount,
          roEventHookAfterMount: roEventHookAfterMount,
          roEventHookAfterWidgetRebind: roEventHookAfterWidgetRebind,
          roEventHookBeforeUnMount: roEventHookBeforeUnMount,
          wEventHookCreateWidgetConfiguration:
              wEventHookCreateWidgetConfiguration,
          wEventHookIsConfigurationChanged: wEventHookIsConfigurationChanged,
          wEventHookCreateRenderObject: wEventHookCreateRenderObject,
          wOverrideCreateConfiguration: wOverrideCreateConfiguration,
          wOverrideIsConfigurationChanged: wOverrideIsConfigurationChanged,
          customHash: customHash,
        );
}

class RT_TestWidgetRenderObject extends RenderObject {
  final Callback? roEventHookRender;
  final Callback? roEventHookUpdate;
  final Callback? roEventHookBeforeMount;
  final Callback? roEventHookAfterMount;
  final Callback? roEventHookAfterWidgetRebind;
  final Callback? roEventHookBeforeUnMount;

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
