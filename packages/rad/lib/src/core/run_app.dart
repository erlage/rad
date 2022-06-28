// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:html';

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/objects/app_options.dart';
import 'package:rad/src/core/common/objects/common_render_elements.dart';
import 'package:rad/src/core/common/objects/options/debug_options.dart';
import 'package:rad/src/core/common/objects/options/router_options.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/framework.dart';
import 'package:rad/src/core/interface/components/components.dart';
import 'package:rad/src/core/interface/meta/meta.dart';
import 'package:rad/src/core/interface/window/delegates/browser_window.dart';
import 'package:rad/src/core/interface/window/window.dart';
import 'package:rad/src/core/rad_styles.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_build_task.dart';
import 'package:rad/src/core/services/services.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/rad_app.dart';

/// Convenience function that spin a [AppRunner].
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
  VoidCallback? beforeMount,
  RouterOptions? routerOptions,
  DebugOptions? debugOptions,
}) {
  return AppRunner(
    app: app,
    targetId: targetId,
    beforeMount: beforeMount,
    routerOptions: routerOptions,
    debugOptions: debugOptions,
  )
    ..start()
    ..scheduleInitialBuild();
}

/// App Runner.
///
/// This is responsible for starting/stopping app instance.
///
class AppRunner {
  final Widget app;
  final String targetId;

  final VoidCallback? _beforeMount;
  final DebugOptions? _debugOptions;
  final RouterOptions? _routerOptions;

  RootRenderElement? _rootElement;
  RootRenderElement get rootElement => _rootElement!;

  Framework? _framework;

  /// @nodoc
  @internal
  Services get frameworkServices => _services!;
  Services? _services;

  /// @nodoc
  @internal
  AppOptions get frameworkAppOptions => _appOptions!;
  AppOptions? _appOptions;

  /// Create a app runner.
  ///
  AppRunner({
    required this.app,
    required this.targetId,
    VoidCallback? beforeMount,
    RouterOptions? routerOptions,
    DebugOptions? debugOptions,
  })  : _beforeMount = beforeMount,
        _routerOptions = routerOptions,
        _debugOptions = debugOptions;

  /// Run app and services associated.
  ///
  void start() {
    this
      ..prepareTargetDomNode()
      ..setupRootElement()
      ..setupOptions()
      ..setupDelegates()
      ..startServices()
      ..setupFrameworkInstance()
      ..runPreMountTasks();
  }

  /// Stop app and services associated.
  ///
  void stop() {
    this
      ..cleanUpTasks()
      ..disposeFrameworkInstance()
      ..stopServices();
  }

  /// Setuo root render element.
  ///
  void setupRootElement() {
    _rootElement = RootRenderElement(
      appTargetId: targetId,
      appTargetDomNode: document.getElementById(targetId)!,
    );
  }

  /// Prepare options for app instance.
  ///
  void setupOptions() {
    _appOptions = AppOptions(
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
    _services = Services(
      appOptions: frameworkAppOptions,
      rootElement: rootElement,
    );

    rootElement.frameworkAttachServices(services: frameworkServices);

    frameworkServices.startServices();
  }

  /// Stop app instance associated services.
  ///
  void stopServices() {
    _services?.stopServices();
  }

  /// Setup instance of framework.
  ///
  void setupFrameworkInstance() {
    _framework = Framework(rootElement)..initState();
  }

  /// Dispose framework instance.
  ///
  void disposeFrameworkInstance() {
    _framework?.dispose();
  }

  /// Schedule initial build.
  ///
  void scheduleInitialBuild() {
    frameworkServices.scheduler.addTask(
      WidgetsBuildTask(
        widgets: [app],
        parentRenderElement: rootElement,
        beforeTaskCallback: _beforeMount,
      ),
    );
  }

  /// Schedulr initial build in sync.
  ///
  void schedulerInitialBuildSync() {
    _framework?.processTask(
      WidgetsBuildTask(
        widgets: [app],
        parentRenderElement: rootElement,
        beforeTaskCallback: _beforeMount,
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
  }

  /// Additional clean up tasks.
  ///
  void cleanUpTasks() {
    Meta.instance.cleanAppAssociatedMetaInformation(context: rootElement);
  }
}
