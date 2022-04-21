import 'dart:html';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/debug_options.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/interface/components/components.dart';
import 'package:rad/src/core/services/services.dart';
import 'package:rad/src/core/framework.dart';
import 'package:rad/src/core/services/services_registry.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_build_task.dart';
import 'package:rad/src/core/interface/window/delegates/browser_window.dart';
import 'package:rad/src/core/interface/window/window.dart';
import 'package:rad/src/css/main.generated.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/rad_app.dart';
import 'package:rad/src/widgets/utils/common_props.dart';

/// Inflate the given widget and attach it to the screen.
///
/// ### Arguments
///
/// - [targetId] refers to the id of element where you want the app
/// to mount.
///
/// - [app] can be any widget. For convenience we've a [RadApp] that takes as
/// much space as its parents allowed it to.
///
/// - [beforeMount] is the callback that you can set which will be fired before
/// app gets mounted on screen.
///
/// - [debugOptions] - Debug options are set per app. Please refer to
/// [DebugOptions] for more.
///
/// - [routingPath] refers to the path name where your app files are located. If
///  your files are located on main domain/sub domain then you don't have to
/// fiddle with it. But if your files are situated in a sub directory/path on a
/// domain, for example, `x.com/y_folder/index.html` then set `routingPath` to
/// `/y_folder`:
///
/// ```dart
/// startApp(
///   ...
///   routingPath: '/y_folder',
///   ...
/// )
/// ```
///
AppRunner startApp({
  required Widget app,
  required String targetId,
  String routingPath = '',
  Callback? beforeMount,
  DebugOptions debugOptions = DebugOptions.defaultMode,
}) {
  return AppRunner(
    app: app,
    targetId: targetId,
    routingPath: routingPath,
    beforeMount: beforeMount,
    debugOptions: debugOptions,
  )..start();
}

/// App Runner.
///
/// This is responsible for starting/stopping app instance.
///
class AppRunner {
  final Widget app;
  final String targetId;
  final String routingPath;
  final Callback? beforeMount;
  final DebugOptions debugOptions;

  Services? _services;
  Services get services => _services!;

  BuildContext? _rootContext;
  BuildContext get rootContext => _rootContext!;

  Framework? _framework;

  AppRunner({
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
      .._startServices()
      .._prepareMount()
      .._scheduleInitialBuildTask();
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

  void _setupDelegates() => Window.instance.bindDelegate(BrowserWindow());

  void _createContext() {
    var globalKey = GlobalKey(targetId);

    _rootContext = BuildContext.bigBang(globalKey);
  }

  void _spinFramework() => _framework = Framework(rootContext);

  void _prepareMount() {
    // Pre-checks before mount

    var targetElement = document.getElementById(targetId) as HtmlElement?;

    if (null == targetElement) {
      throw "Unable to locate target element in HTML document";
    }

    // Decorate target element

    CommonProps.applyDataAttributes(targetElement, {
      Constants.attrConcreteType: "Target",
      Constants.attrRuntimeType: Constants.contextTypeBigBang,
    });

    // Insert framework's styles
    // Components interface is not public yet.
    Components(rootContext: rootContext).injectStyles(
      GEN_STYLES_MAIN_CSS,
      'Rad default styles.',
    );

    // Trigger hooks

    beforeMount?.call();
  }

  void _startServices() {
    _services = Services(rootContext);

    ServicesRegistry.instance.registerServices(rootContext, services);

    services.debug.startService(debugOptions);

    services.router.startService(routingPath);

    services.scheduler.startService(_framework!.taskProcessor);
  }

  void _scheduleInitialBuildTask() {
    services.scheduler.addTask(
      WidgetsBuildTask(
        widgets: [app],
        parentContext: rootContext,
      ),
    );
  }
}
