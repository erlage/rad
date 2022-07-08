// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: camel_case_types

import '../test_imports.dart';
import '../utils.dart';

RT_AppRunner createTestApp({
  Widget? app,
  DebugOptions? debugOptions,
  RouterOptions? routerOptions,
}) {
  return RT_AppRunner(
    app: app,
    debugOptions: debugOptions,
    routerOptions: routerOptions,
  );
}

/// Test app runner.
///
class RT_AppRunner extends AppRunner {
  final stack = RT_TestStack();
  final window = RT_TestWindow();

  var _isDebugInformationEnabled = false;

  RenderElement get appRenderElement => renderElementByKeyValue('app-widget')!;

  RT_AppRunner({
    Widget? app,
    required DebugOptions? debugOptions,
    required RouterOptions? routerOptions,
  }) : super(
          app: app ?? RT_TestWidget(key: Key('app-widget')),
          appTargetId: RT_TestBed.rootTargetId,
          debugOptions: debugOptions,
          routerOptions: routerOptions,
        );

  @override
  void start() {
    this
      .._clearState()
      ..prepareTargetDomNode()
      ..setupRootRenderElement()
      ..setupOptions()
      ..setupDelegates()
      ..startServices()
      ..setupFrameworkInstance()
      ..runPreMountTasks()
      ..schedulerInitialBuildSync();
  }

  @override
  void stop() {
    this
      ..runCleanUpTasks()
      ..disposeFrameworkInstance()
      ..stopServices()
      .._printDebugInformation()
      .._clearState();
  }

  void _clearState() {
    disableDebugInformation();

    stack.clearState();
    window.clearState();

    ServicesRegistry.instance.unRegisterServices(RT_TestBed.rootRenderElement);
  }

  @override
  void setupDelegates() {
    Window.instance.bindDelegate(window);
  }

  /// Get render element by global key under app context.
  ///
  RenderElement? renderElementByKeyValue(String key) {
    for (final renderElement in collectRenderElements(rootElement)) {
      if (renderElement.key?.frameworkValue == key) {
        return renderElement;
      }
    }

    return null;
  }

  /// Get widget by global key under app context.
  ///
  Widget widgetByKey(String key) => renderElementByKeyValue(key)!.widget;

  /// Get dom node by global key under app context.
  ///
  Element domNodeByKeyValue(String keyValue) {
    return renderElementByKeyValue(keyValue)!.domNode!;
  }

  /// Get app's dom node.
  ///
  Element get appDomNode => domNodeByKeyValue('app-widget');

  /// Get dom node by id.
  ///
  Element domNodeById(String id) => document.getElementById(id)!;

  /// Get state of navigator with global key.
  ///
  NavigatorState navigatorState(String key) {
    var wo = renderElementByKeyValue(key);

    return (wo as NavigatorRenderElement).state;
  }

  Future<void> buildChildren({
    required List<Widget> widgets,
    required RenderElement parentRenderElement,
    int? mountAtIndex,
    bool flagCleanParentContents = true,
  }) async {
    frameworkServices.scheduler.addTask(
      WidgetsBuildTask(
        widgets: widgets,
        parentRenderElement: parentRenderElement,
        mountAtIndex: mountAtIndex,
        flagCleanParentContents: flagCleanParentContents,
      ),
    );

    await Future.delayed(Duration.zero);
  }

  Future<void> updateChildren({
    required List<Widget> widgets,
    required RenderElement parentRenderElement,
    required UpdateType updateType,
    bool flagAddIfNotFound = true,
  }) async {
    frameworkServices.scheduler.addTask(
      WidgetsUpdateTask(
        widgets: widgets,
        parentRenderElement: parentRenderElement,
        updateType: updateType,
        flagAddIfNotFound: flagAddIfNotFound,
      ),
    );

    await Future.delayed(Duration.zero);
  }

  Future<void> updateDependent(
    RenderElement dependentRenderElement,
  ) async {
    frameworkServices.scheduler.addTask(
      WidgetsUpdateDependentTask(
        dependentRenderElement: dependentRenderElement,
      ),
    );

    await Future.delayed(Duration.zero);
  }

  Future<void> manageChildren({
    required RenderElement parentRenderElement,
    required WidgetActionsBuilder widgetActionCallback,
    required UpdateType updateType,
    bool flagIterateInReverseOrder = false,
  }) async {
    frameworkServices.scheduler.addTask(
      WidgetsManageTask(
        updateType: updateType,
        parentRenderElement: parentRenderElement,
        widgetActionCallback: widgetActionCallback,
        flagIterateInReverseOrder: flagIterateInReverseOrder,
      ),
    );

    await Future.delayed(Duration.zero);
  }

  Future<void> disposeWidget({
    required RenderElement? renderElement,
    required bool flagPreserveTarget,
  }) async {
    if (null != renderElement) {
      frameworkServices.scheduler.addTask(
        WidgetsDisposeTask(
          renderElement: renderElement,
          flagPreserveTarget: flagPreserveTarget,
        ),
      );
    }

    await Future.delayed(Duration.zero);
  }

  Future<void> setPath(String toSet) async {
    if (frameworkServices.router.options.enableHashBasedRouting) {
      window.setHash(toSet);
    } else {
      window.setPath(toSet);
    }

    await Future.delayed(Duration(milliseconds: 100));
  }

  void assertMatchPath(String toMatch) {
    if (frameworkServices.router.options.enableHashBasedRouting) {
      expect(window.locationHash, '#$toMatch');
    } else {
      expect(window.locationPathName, toMatch);
    }
  }

  void assertMatchFullPath(String toMatch) {
    expect('${window.locationPathName}${window.locationHash}', toMatch);
  }

  void assertMatchPathStack(List<String> toMatch) {
    var stack = <String>[];

    if (frameworkServices.router.options.enableHashBasedRouting) {
      stack.addAll(window.hashStack.reversed);
    } else {
      stack.addAll(window.pathStack.reversed);
    }

    for (final entry in toMatch) {
      if (frameworkServices.router.options.enableHashBasedRouting) {
        expect(stack.removeLast(), '#$entry');
      } else {
        expect(stack.removeLast(), entry);
      }
    }

    expect(stack.isEmpty, equals(true));
  }

  void enableDebugInformation() {
    _isDebugInformationEnabled = true;
  }

  void disableDebugInformation() {
    _isDebugInformationEnabled = false;
  }

  void _printDebugInformation() {
    if (_isDebugInformationEnabled) {
      for (final entry in window.logs) {
        print('Window: $entry');
      }

      for (final entry in stack.entries) {
        print('Stack: $entry');
      }
    }
  }
}
