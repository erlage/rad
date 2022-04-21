// ignore_for_file: camel_case_types

import 'package:rad/rad.dart';
import 'package:rad/widgets_internals.dart';
import 'package:rad/src/core/framework.dart';
import 'package:rad/src/core/interface/window/delegates/browser_window.dart';
import 'package:rad/src/core/interface/window/window.dart';

import 'test_bed.dart';
import 'test_widget.dart';

RT_AppRunner createTestApp({
  DebugOptions debugOptions = DebugOptions.defaultMode,
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
  final String routingPath;
  final Callback? beforeMount;
  final DebugOptions debugOptions;

  Services? _services;
  Services get services => _services!;

  BuildContext? _rootContext;
  BuildContext get rootContext => _rootContext!;

  BuildContext get appContext => services.walker
      .getWidgetObject(
        'app-widget',
      )!
      .context;

  Framework? _framework;
  Framework get framework => _framework!;

  RT_AppRunner({
    required this.app,
    required this.targetId,
    this.routingPath = '',
    this.beforeMount,
    this.debugOptions = DebugOptions.defaultMode,
  });

  /// Run app and services associated.
  ///
  void start() {
    this
      .._setupDelegates()
      .._createContext()
      .._spinFramework()
      .._startServices();
  }

  /// Run app in empty mode.
  ///
  void startWithAppWidget() {
    this
      .._setupDelegates()
      .._createContext()
      .._spinFramework()
      .._startServices()
      .._buildAppWidget();
  }

  /// Stop app and services associated.
  ///
  void stop() {
    _framework!.tearDown();

    services.debug.stopService();

    services.router.stopService();

    services.scheduler.stopService();

    ServicesRegistry.instance.unRegisterServices(rootContext);
  }

  void buildTestApp() {
    framework.buildChildren(
      widgets: [
        RT_TestWidget(key: GlobalKey('app-widget')),
      ],
      parentContext: RT_TestBed.rootContext,
    );
  }

  void _setupDelegates() => Window.instance.bindDelegate(BrowserWindow());

  void _createContext() {
    var globalKey = GlobalKey(targetId);

    _rootContext = BuildContext.bigBang(globalKey);
  }

  void _spinFramework() => _framework = Framework(rootContext);

  void _startServices() {
    _services = Services(rootContext);

    ServicesRegistry.instance.registerServices(rootContext, services);

    services.debug.startService(debugOptions);

    services.router.startService(routingPath);

    services.scheduler.startService(_framework!.taskProcessor);
  }

  // void _scheduleInitialBuildTask() {
  //   services.scheduler.addTask(
  //     WidgetsBuildTask(
  //       widgets: [app],
  //       parentContext: rootContext,
  //     ),
  //   );
  // }

  void _buildAppWidget() {
    framework.buildChildren(
      widgets: [RT_TestWidget(key: GlobalKey('app-widget'))],
      parentContext: RT_TestBed.rootContext,
    );
  }
}
