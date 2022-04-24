import 'dart:html';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/objects/app_options.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/objects/options/debug_options.dart';
import 'package:rad/src/core/common/objects/options/router_options.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/interface/components/components.dart';
import 'package:rad/src/core/framework.dart';
import 'package:rad/src/core/interface/window/delegates/browser_window.dart';
import 'package:rad/src/core/interface/window/window.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_build_task.dart';
import 'package:rad/src/core/services/services.dart';
import 'package:rad/src/css/main.generated.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/rad_app.dart';
import 'package:rad/src/widgets/utils/common_props.dart';

/// Inflate the given widget and attach it to the screen.
///
/// ### Arguments
///
/// - [targetId] - id of element where you want the app to mount.
///
/// - [app] - A widget(any widget). For convenience we've a [RadApp] widget.
///
/// - [beforeMount] - Callback that'll be fired before app mount.
///
/// - [debugOptions] - See [DebugOptions].
///
/// - [routerOptions] - See [RouterOptions].
///
AppRunner startApp({
  required Widget app,
  required String targetId,
  Callback? beforeMount,
  RouterOptions? routerOptions,
  DebugOptions? debugOptions,
}) {
  return AppRunner(
    app: app,
    targetId: targetId,
    beforeMount: beforeMount,
    routerOptions: routerOptions,
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

  final Callback? _beforeMount;
  final DebugOptions? _debugOptions;
  final RouterOptions? _routerOptions;

  BuildContext? _rootContext;
  BuildContext get rootContext => _rootContext!;

  AppOptions? _appOptions;
  AppOptions get appOptions => _appOptions!;

  Services? _services;
  Services get services => _services!;

  Framework? _framework;

  AppRunner({
    required this.app,
    required this.targetId,
    Callback? beforeMount,
    RouterOptions? routerOptions,
    DebugOptions? debugOptions,
  })  : _beforeMount = beforeMount,
        _routerOptions = routerOptions,
        _debugOptions = debugOptions;

  /// Run app and services associated.
  ///
  void start() {
    this
      .._createRootContext()
      .._prepareOptions()
      .._setupDelegates()
      .._startServices()
      .._createFrameworkInstance()
      .._prepareMount()
      .._scheduleInitialBuild();
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

  void _scheduleInitialBuild() {
    services.scheduler.addTask(
      WidgetsBuildTask(
        widgets: [app],
        parentContext: rootContext,
      ),
    );
  }

  void _prepareMount() {
    var targetElement = document.getElementById(targetId) as HtmlElement?;

    if (null == targetElement) {
      throw "Unable to locate target element in HTML document";
    }

    CommonProps.applyDataAttributes(targetElement, {
      Constants.attrConcreteType: "Target",
      Constants.attrRuntimeType: Constants.contextTypeBigBang,
    });

    Components(rootContext: rootContext).injectStyles(
      GEN_STYLES_MAIN_CSS,
      'Rad default styles.',
    );

    _beforeMount?.call();
  }
}
