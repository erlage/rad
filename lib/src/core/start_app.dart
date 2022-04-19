import 'dart:html';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/debug_options.dart';
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
/// - [targetSelector] refers to the id of element where you want the app
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
void startApp({
  required Widget app,
  required String targetSelector,
  String routingPath = '',
  Callback? beforeMount,
  DebugOptions debugOptions = DebugOptions.defaultMode,
}) {
  AppBootstrapper(
    app: app,
    targetSelector: targetSelector,
    routingPath: routingPath,
    beforeMount: beforeMount,
    debugOptions: debugOptions,
  )
    ..setupDelegates()
    ..createContext()
    ..spinFramework()
    ..startServices()
    ..prepareMount()
    ..scheduleBuildTask();
}

class AppBootstrapper {
  final Widget app;
  final String targetSelector;
  final String routingPath;
  final Callback? beforeMount;
  final DebugOptions debugOptions;

  BuildContext? _rootContext;
  BuildContext get rootContext => _rootContext!;

  Framework? _framework;
  Framework get framework => _framework!;

  AppBootstrapper({
    required this.app,
    required this.targetSelector,
    this.routingPath = '',
    this.beforeMount,
    this.debugOptions = DebugOptions.defaultMode,
  });

  void setupDelegates() => Window.instance.bindDelegate(BrowserWindow());

  void createContext() => _rootContext = BuildContext.bigBang(targetSelector);

  void spinFramework() => _framework = Framework(rootContext);

  void prepareMount() {
    // Pre-checks before mount

    var targetElement = document.getElementById(targetSelector) as HtmlElement?;

    if (null == targetElement) {
      throw "Unable to locate target element in HTML document";
    }

    // Decorate target element

    CommonProps.applyDataAttributes(targetElement, {
      System.attrConcreteType: "Target",
      System.attrRuntimeType: System.contextTypeBigBang,
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

  void startServices() {
    var services = Services(rootContext);

    ServicesRegistry.instance.registerServices(rootContext, services);

    services.debug.startService(debugOptions);

    services.router.startService(routingPath);

    services.scheduler.startService(framework.taskProcessor);
  }

  /// Schedule a build task.
  ///
  void scheduleBuildTask() {
    var scheduler = ServicesRegistry.instance.getScheduler(rootContext);

    scheduler.addTask(
      WidgetsBuildTask(
        widgets: [app],
        parentContext: rootContext,
      ),
    );
  }
}
