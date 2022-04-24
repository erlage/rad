// ignore_for_file: camel_case_types

import 'package:rad/rad.dart';
import 'package:rad/widgets_internals.dart';
import 'package:rad/src/core/framework.dart';
import 'package:rad/src/core/interface/window/delegates/browser_window.dart';
import 'package:rad/src/core/interface/window/window.dart';

import 'test_bed.dart';
import 'test_widget.dart';

RT_AppRunner createTestApp({
  DebugOptions? debugOptions,
}) {
  return RT_AppRunner(
    app: Text('hello world'),
    targetId: 'root-div',
    debugOptions: debugOptions,
  );
}

/// Test App Runner.
///
class RT_AppRunner {
  final Widget app;
  final String targetId;

  final Callback? beforeMount;
  final DebugOptions? _debugOptions;
  final RouterOptions? _routerOptions;

  BuildContext? _rootContext;
  BuildContext get rootContext => _rootContext!;

  AppOptions? _appOptions;
  AppOptions get appOptions => _appOptions!;

  Services? _services;
  Services get services => _services!;

  Framework? _framework;
  Framework get framework => _framework!;

  BuildContext get appContext => services.walker
      .getWidgetObject(
        'app-widget',
      )!
      .context;

  RT_AppRunner({
    required this.app,
    required this.targetId,
    this.beforeMount,
    RouterOptions? routerOptions,
    DebugOptions? debugOptions,
  })  : _routerOptions = routerOptions,
        _debugOptions = debugOptions;

  void start() {
    this
      .._createRootContext()
      .._prepareOptions()
      .._setupDelegates()
      .._startServices()
      .._createFrameworkInstance();
  }

  void startWithAppWidget() {
    this
      .._createRootContext()
      .._prepareOptions()
      .._setupDelegates()
      .._startServices()
      .._createFrameworkInstance()
      .._buildAppWidget();
  }

  /// Stop app and services associated.
  ///
  void stop() {
    this
      .._disposeFrameworkInstance()
      .._stopServices();
  }

  void _createRootContext() {
    var globalKey = GlobalKey(targetId);

    _rootContext = BuildContext.bigBang(globalKey);
  }

  void _prepareOptions() {
    _appOptions = AppOptions(
      rootContext: rootContext,
      routerOptions: _routerOptions ?? RouterOptions.defaultMode,
      debugOptions: _debugOptions ?? DebugOptions.defaultMode,
    );
  }

  void _setupDelegates() {
    Window.instance.bindDelegate(BrowserWindow());
  }

  void _startServices() {
    _services = Services(appOptions)..startServices();
  }

  void _stopServices() {
    services.stopServices();
  }

  void _createFrameworkInstance() {
    _framework = Framework(rootContext)..initState();
  }

  void _disposeFrameworkInstance() {
    _framework!.dispose();
  }

  void _buildAppWidget() {
    framework.buildChildren(
      widgets: [RT_TestWidget(key: GlobalKey('app-widget'))],
      parentContext: RT_TestBed.rootContext,
    );
  }
}
