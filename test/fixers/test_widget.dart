// ignore_for_file: camel_case_types

import 'package:meta/meta.dart';

import '../test_imports.dart';

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

/// A StatefulWidget that allows hooking its internals.
///
class RT_StatefulTestWidget extends StatefulWidget {
  final Callback? stateEventInitState;
  final Callback? stateEventDidChangeDependencies;
  final Callback? stateEventDidUpdateWidget;
  final Callback? stateEventBuild;
  final Callback? stateEventDispose;
  final Callback? stateEventCreateState;

  final Function(RT_StatefulTestWidget_State state)? stateHookInitState;

  final Function(RT_StatefulTestWidget_State state)? stateHookBuild;

  final Function(
    RT_StatefulTestWidget_State state,
  )? stateHookDidChangeDependencies;

  final Function(
    RT_StatefulTestWidget_State state,
    Widget old,
  )? stateHookDidUpdateWidget;

  final String hash;

  const RT_StatefulTestWidget({
    Key? key,
    this.stateEventInitState,
    this.stateEventDidChangeDependencies,
    this.stateEventDidUpdateWidget,
    this.stateEventBuild,
    this.stateEventDispose,
    this.stateEventCreateState,
    this.stateHookInitState,
    this.stateHookBuild,
    this.stateHookDidUpdateWidget,
    this.stateHookDidChangeDependencies,
    String? customHash,
  })  : hash = customHash ?? 'none',
        super(key: key);

  @override
  RT_StatefulTestWidget_State createState() => RT_StatefulTestWidget_State(
        stateEventCreateState,
      );
}

class RT_StatefulTestWidget_State extends State<RT_StatefulTestWidget> {
  Callback? _stateEventInitState;
  Callback? _stateEventDidChangeDependencies;
  Callback? _stateEventDidUpdateWidget;
  Callback? _stateEventBuild;
  Callback? _stateEventDispose;

  Function(RT_StatefulTestWidget_State state)? _stateHookInitState;

  Function(RT_StatefulTestWidget_State state)? _stateHookBuild;

  Function(
    RT_StatefulTestWidget_State state,
  )? _stateHookDidChangeDependencies;

  Function(
    RT_StatefulTestWidget_State state,
    Widget old,
  )? _stateHookDidUpdateWidget;

  RT_StatefulTestWidget_State(Callback? stateEventCreateState) {
    if (null != stateEventCreateState) {
      stateEventCreateState();
    }
  }

  @override
  initState() {
    bindHooks();

    if (null != _stateEventInitState) {
      _stateEventInitState!();
    }

    if (null != _stateHookInitState) {
      _stateHookInitState!(this);
    }
  }

  @override
  didChangeDependencies() {
    if (null != _stateEventDidChangeDependencies) {
      _stateEventDidChangeDependencies!();
    }

    if (null != _stateHookDidChangeDependencies) {
      _stateHookDidChangeDependencies!(this);
    }
  }

  @override
  didUpdateWidget(oldWidget) {
    if (null != _stateEventDidUpdateWidget) {
      _stateEventDidUpdateWidget!();
    }

    if (null != _stateHookDidUpdateWidget) {
      _stateHookDidUpdateWidget!(this, oldWidget);
    }
  }

  @override
  build(context) {
    if (null != _stateEventBuild) {
      _stateEventBuild!();
    }

    if (null != _stateHookBuild) {
      _stateHookBuild!(this);
    }

    return Text('hello world');
  }

  @override
  dispose() {
    if (null != _stateEventDispose) {
      _stateEventDispose!();
    }
  }

  void bindHooks() {
    if (null != widget.stateEventInitState) {
      _stateEventInitState = widget.stateEventInitState;
    }

    if (null != widget.stateEventDidChangeDependencies) {
      _stateEventDidChangeDependencies = widget.stateEventDidChangeDependencies;
    }

    if (null != widget.stateEventDidUpdateWidget) {
      _stateEventDidUpdateWidget = widget.stateEventDidUpdateWidget;
    }

    if (null != widget.stateEventBuild) {
      _stateEventBuild = widget.stateEventBuild;
    }

    if (null != widget.stateEventDispose) {
      _stateEventDispose = widget.stateEventDispose;
    }

    if (null != widget.stateHookInitState) {
      _stateHookInitState = widget.stateHookInitState;
    }

    if (null != widget.stateHookInitState) {
      _stateHookInitState = widget.stateHookInitState;
    }

    if (null != widget.stateHookDidUpdateWidget) {
      _stateHookDidUpdateWidget = widget.stateHookDidUpdateWidget;
    }

    if (null != widget.stateHookDidChangeDependencies) {
      _stateHookDidChangeDependencies = widget.stateHookDidChangeDependencies;
    }
  }
}
