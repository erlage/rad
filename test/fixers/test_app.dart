// ignore_for_file: camel_case_types

import 'package:rad/rad.dart';
import 'package:rad/widgets_internals.dart';
import 'package:rad/src/core/framework.dart';
import 'package:rad/src/core/interface/window/window.dart';
import 'package:rad/src/core/interface/window/delegates/browser_window.dart';

RT_AppBootstrapper createTestApp({
  DebugOptions debugOptions = DebugOptions.defaultMode,
}) {
  return RT_AppBootstrapper(
    app: Text('hello world'),
    targetId: 'root-div',
    debugOptions: debugOptions,
  );
}

class RT_AppBootstrapper {
  final Widget app;
  final String targetId;
  final String routingPath;
  final Callback? beforeMount;
  final DebugOptions debugOptions;

  BuildContext? _rootContext;
  BuildContext get rootContext => _rootContext!;

  Framework? _framework;
  Framework get framework => _framework!;

  Services? _services;
  Services get services => _services!;

  RT_AppBootstrapper({
    required this.app,
    required this.targetId,
    this.routingPath = '',
    this.beforeMount,
    this.debugOptions = DebugOptions.defaultMode,
  });

  void start() {
    this
      ..setupDelegates()
      ..createContext()
      ..spinFramework()
      ..startServices()
      ..scheduleBuildTask();
  }

  void stop() {
    framework.tearDown();

    services.debug.stopService();

    services.router.stopService();

    services.scheduler.stopService();

    ServicesRegistry.instance.unRegisterServices(rootContext);
  }

  void setupDelegates() => Window.instance.bindDelegate(BrowserWindow());

  void createContext() {
    var globalKey = GlobalKey(targetId);

    _rootContext = BuildContext.bigBang(globalKey);
  }

  void spinFramework() => _framework = Framework(rootContext);

  void startServices() {
    _services = Services(rootContext);

    ServicesRegistry.instance.registerServices(rootContext, services);

    services.debug.startService(debugOptions);

    services.router.startService(routingPath);

    services.scheduler.startService(framework.taskProcessor);
  }

  void scheduleBuildTask() {
    var schedulerService = ServicesRegistry.instance.getScheduler(rootContext);

    schedulerService.addTask(
      WidgetsBuildTask(
        widgets: [app],
        parentContext: rootContext,
      ),
    );
  }
}
