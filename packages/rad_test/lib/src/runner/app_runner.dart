// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: camel_case_types, invalid_use_of_internal_member

import 'package:rad/rad.dart' as rad;

import 'package:rad_test/src/imports.dart';
import 'package:rad_test/src/utilities/test_window.dart';

/// Test app root widget.
///
class TestAppRootWidget extends Division {
  const TestAppRootWidget({super.key, super.children});
}

/// Test app runner.
///
class AppRunner extends rad.AppRunner {
  /// Current app id.
  ///
  /// App ids are generated when framework spins a test environment. This id
  /// is generated unique which allows running multiple test apps and multiple
  /// test environments on the same page.
  ///
  final String appId;

  /// Whether to mock browser's window object.
  ///
  final bool useWindowMock;

  /// Window mock object(if [useWindowMock] is true)
  WindowDelegate? window;

  /// Create test app runner instance.
  ///
  AppRunner({
    required this.appId,
    required String appTargetId,
    required this.useWindowMock,
    rad.DebugOptions? debugOptions,
    rad.RouterOptions? routerOptions,
  }) : super(
          app: TestAppRootWidget(key: GlobalKey(appId)),
          appTargetId: appTargetId,
          debugOptions: debugOptions,
          routerOptions: routerOptions,
        );

  /// App widget(root widget)'s build context.
  ///
  rad.RenderElement get appRenderElement {
    var renderElement =
        frameworkServices.walker.getRenderElementAssociatedWithGlobalKey(
      GlobalKey(appId),
    );

    if (null == renderElement) {
      throw Exception('App widget (#$appId) not found');
    }

    return renderElement;
  }

  @override
  void start() {
    this
      ..prepareTargetDomNode()
      ..setupRootRenderElement()
      .._clearState()
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
      .._clearState();
  }

  @override
  void setupDelegates() {
    if (useWindowMock) {
      window = TestWindow(rootElement);

      Window.instance.bindDelegate(window!);
    } else {
      super.setupDelegates();
    }
  }

  /// Clear app runner state.
  ///
  void _clearState() {
    ServicesRegistry.instance.unRegisterServices(rootElement);
  }
}
