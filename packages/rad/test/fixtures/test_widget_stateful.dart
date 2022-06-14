// ignore_for_file: camel_case_types

import '../test_imports.dart';

/// A StatefulWidget that allows hooking its internals.
///
class RT_StatefulTestWidget extends StatefulWidget {
  final VoidCallback? stateEventInitState;
  final VoidCallback? stateEventDidChangeDependencies;
  final VoidCallback? stateEventDidUpdateWidget;
  final VoidCallback? stateEventBuild;
  final VoidCallback? stateEventDispose;
  final VoidCallback? stateEventCreateState;

  final Function(RT_StatefulTestWidget_State state)? stateHookInitState;

  final Function(RT_StatefulTestWidget_State state)? stateHookBuild;

  final Function(
    RT_StatefulTestWidget_State state,
  )? stateHookCreateState;

  final Function(
    RT_StatefulTestWidget_State state,
  )? stateHookDidChangeDependencies;

  final Function(
    RT_StatefulTestWidget_State state,
    Widget old,
  )? stateHookDidUpdateWidget;

  final List<Widget> children;

  final String hash;

  const RT_StatefulTestWidget({
    Key? key,
    this.stateEventInitState,
    this.stateEventDidChangeDependencies,
    this.stateEventDidUpdateWidget,
    this.stateEventBuild,
    this.stateEventDispose,
    this.stateEventCreateState,
    this.stateHookCreateState,
    this.stateHookInitState,
    this.stateHookBuild,
    this.stateHookDidUpdateWidget,
    this.stateHookDidChangeDependencies,
    this.children = const [],
    String? customHash,
  })  : hash = customHash ?? 'none',
        super(key: key);

  @override
  RT_StatefulTestWidget_State createState() => RT_StatefulTestWidget_State(
        stateEventCreateState: stateEventCreateState,
        stateHookCreateState: stateHookCreateState,
      );
}

class RT_StatefulTestWidget_State extends State<RT_StatefulTestWidget> {
  VoidCallback? _stateEventInitState;
  VoidCallback? _stateEventDidChangeDependencies;
  VoidCallback? _stateEventDidUpdateWidget;
  VoidCallback? _stateEventBuild;
  VoidCallback? _stateEventDispose;

  Function(RT_StatefulTestWidget_State state)? _stateHookInitState;

  Function(RT_StatefulTestWidget_State state)? _stateHookBuild;

  Function(
    RT_StatefulTestWidget_State state,
  )? _stateHookDidChangeDependencies;

  Function(
    RT_StatefulTestWidget_State state,
    Widget old,
  )? _stateHookDidUpdateWidget;

  RT_StatefulTestWidget_State({
    VoidCallback? stateEventCreateState,
    Function(RT_StatefulTestWidget_State state)? stateHookCreateState,
  }) {
    if (null != stateEventCreateState) {
      stateEventCreateState();
    }

    if (null != stateHookCreateState) {
      stateHookCreateState(this);
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

    return RT_TestWidget(children: widget.children);
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

    if (null != widget.stateHookBuild) {
      _stateHookBuild = widget.stateHookBuild;
    }

    if (null != widget.stateHookDidUpdateWidget) {
      _stateHookDidUpdateWidget = widget.stateHookDidUpdateWidget;
    }

    if (null != widget.stateHookDidChangeDependencies) {
      _stateHookDidChangeDependencies = widget.stateHookDidChangeDependencies;
    }
  }
}

// copy of above widget.

/// Another stateful widget.
///
class RT_AnotherStatefulWidget extends StatefulWidget {
  final VoidCallback? stateEventInitState;
  final VoidCallback? stateEventDidChangeDependencies;
  final VoidCallback? stateEventDidUpdateWidget;
  final VoidCallback? stateEventBuild;
  final VoidCallback? stateEventDispose;
  final VoidCallback? stateEventCreateState;

  final Function(RT_AnotherStatefulWidget_State state)? stateHookInitState;

  final Function(RT_AnotherStatefulWidget_State state)? stateHookBuild;

  final Function(
    RT_AnotherStatefulWidget_State state,
  )? stateHookCreateState;

  final Function(
    RT_AnotherStatefulWidget_State state,
  )? stateHookDidChangeDependencies;

  final Function(
    RT_AnotherStatefulWidget_State state,
    Widget old,
  )? stateHookDidUpdateWidget;

  final List<Widget> children;

  final String hash;

  const RT_AnotherStatefulWidget({
    Key? key,
    this.stateEventInitState,
    this.stateEventDidChangeDependencies,
    this.stateEventDidUpdateWidget,
    this.stateEventBuild,
    this.stateEventDispose,
    this.stateEventCreateState,
    this.stateHookCreateState,
    this.stateHookInitState,
    this.stateHookBuild,
    this.stateHookDidUpdateWidget,
    this.stateHookDidChangeDependencies,
    this.children = const [],
    String? customHash,
  })  : hash = customHash ?? 'none',
        super(key: key);

  @override
  RT_AnotherStatefulWidget_State createState() =>
      RT_AnotherStatefulWidget_State(
        stateEventCreateState: stateEventCreateState,
        stateHookCreateState: stateHookCreateState,
      );
}

class RT_AnotherStatefulWidget_State extends State<RT_AnotherStatefulWidget> {
  VoidCallback? _stateEventInitState;
  VoidCallback? _stateEventDidChangeDependencies;
  VoidCallback? _stateEventDidUpdateWidget;
  VoidCallback? _stateEventBuild;
  VoidCallback? _stateEventDispose;

  Function(RT_AnotherStatefulWidget_State state)? _stateHookInitState;

  Function(RT_AnotherStatefulWidget_State state)? _stateHookBuild;

  Function(
    RT_AnotherStatefulWidget_State state,
  )? _stateHookDidChangeDependencies;

  Function(
    RT_AnotherStatefulWidget_State state,
    Widget old,
  )? _stateHookDidUpdateWidget;

  RT_AnotherStatefulWidget_State({
    VoidCallback? stateEventCreateState,
    Function(RT_AnotherStatefulWidget_State state)? stateHookCreateState,
  }) {
    if (null != stateEventCreateState) {
      stateEventCreateState();
    }

    if (null != stateHookCreateState) {
      stateHookCreateState(this);
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

    return RT_TestWidget(children: widget.children);
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

/// A stateful widget with single child.
///
class RT_SingleChildStateful extends StatefulWidget {
  final Widget child;

  RT_SingleChildStateful({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  _RT_SingleChildStatefulState createState() => _RT_SingleChildStatefulState();
}

class _RT_SingleChildStatefulState extends State<RT_SingleChildStateful> {
  Widget? child;

  @override
  void initState() {
    child = widget.child;
  }

  @override
  build(context) => child!;
}
