import 'dart:html';

import 'package:rad/src/core/common/objects/app_options.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/objects/options/debug_options.dart';
import 'package:rad/src/core/common/objects/options/router_options.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/framework.dart';
import 'package:rad/src/core/interface/components/components.dart';
import 'package:rad/src/core/interface/window/delegates/browser_window.dart';
import 'package:rad/src/core/interface/window/window.dart';
import 'package:rad/src/core/rad_styles.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_build_task.dart';
import 'package:rad/src/core/services/services.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/rad_app.dart';

/// Convenience function that spin a [AppRunner].
///
/// Note that, [AppRunner] can be used directly to inflate the given widget and
/// attach it to the screen.
///
/// ### Arguments
///
/// - [targetId] - id of dom node where you want the app to mount.
///
/// - [app] - A widget(any widget). For convenience we've a [RadApp] widget.
///
/// - [beforeMount] - Callback that'll be fired before app mount.
///
/// - [debugOptions] - See [DebugOptions].
///
/// - [routerOptions] - See [RouterOptions].
///
AppRunner runApp({
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
  final bool _isInTestMode;

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
  Framework get framework => _framework!;

  /// Create a app runner.
  ///
  AppRunner({
    required this.app,
    required this.targetId,
    Callback? beforeMount,
    RouterOptions? routerOptions,
    DebugOptions? debugOptions,
  })  : _isInTestMode = false,
        _beforeMount = beforeMount,
        _routerOptions = routerOptions,
        _debugOptions = debugOptions;

  /// Create a app runner in test mode.
  ///
  AppRunner.inTestMode({
    required this.app,
    required this.targetId,
    Callback? beforeMount,
    RouterOptions? routerOptions,
    DebugOptions? debugOptions,
  })  : _isInTestMode = true,
        _beforeMount = beforeMount,
        _routerOptions = routerOptions,
        _debugOptions = debugOptions;

  /// Run app and services associated.
  ///
  void start() {
    this
      ..prepareTargetDomNode()
      ..setupRootContext()
      ..setupOptions()
      ..setupDelegates()
      ..startServices()
      ..setupFrameworkInstance()
      ..runPreMountTasks()
      .._scheduleInitialBuild();
  }

  /// Stop app and services associated.
  ///
  void stop() {
    this
      ..disposeFrameworkInstance()
      ..stopServices();
  }

  /// Setuo root context.
  ///
  void setupRootContext() {
    var globalKey = GlobalKey(targetId);

    _rootContext = BuildContext.bigBang(globalKey);
  }

  /// Prepare options for app instance.
  ///
  void setupOptions() {
    _appOptions = AppOptions(
      rootContext: rootContext,
      routerOptions: _routerOptions ?? RouterOptions.defaultMode,
      debugOptions: _debugOptions ?? DebugOptions.defaultMode,
    );
  }

  /// Setup delegates.
  ///
  void setupDelegates() {
    Window.instance.bindDelegate(BrowserWindow());
  }

  /// Start app instance associated services.
  ///
  void startServices() {
    _services = Services(appOptions)..startServices();
  }

  /// Stop app instance associated services.
  ///
  void stopServices() {
    _services?.stopServices();
  }

  /// Setup instance of framework.
  ///
  void setupFrameworkInstance() {
    if (_isInTestMode) {
      _framework = Framework.inTestMode(rootContext)..initState();
    } else {
      _framework = Framework(rootContext)..initState();
    }
  }

  /// Dispose framework instance.
  ///
  void disposeFrameworkInstance() {
    _framework?.dispose();
  }

  void _scheduleInitialBuild() {
    services.scheduler.addTask(
      WidgetsBuildTask(
        widgets: [app],
        parentContext: rootContext,
      ),
    );
  }

  /// Prepare target dom node.
  ///
  void prepareTargetDomNode() {
    var targetElement = document.getElementById(targetId);

    if (null == targetElement) {
      throw Exception('Unable to locate target dom node in HTML document');
    }
  }

  /// Run pre-mount tasks.
  ///
  void runPreMountTasks() {
    Components.instance.injectStyleComponent(RadStylesComponent());

    _beforeMount?.call();
  }
}
