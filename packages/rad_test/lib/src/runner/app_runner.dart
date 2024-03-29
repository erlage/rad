// Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: camel_case_types, invalid_use_of_internal_member

import 'package:rad/rad.dart' as rad;

import 'package:rad_test/src/imports.dart';
import 'package:rad_test/src/modules/all_elements.dart';
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
          app: TestAppRootWidget(key: Key(appId)),
          appTargetId: appTargetId,
          debugOptions: debugOptions,
          routerOptions: routerOptions,
        );

  /// App widget(root widget)'s build context.
  ///
  rad.RenderElement get appRenderElement {
    var elements = collectAllWidgetObjectsFrom(
      rootElement,
      skipOffstage: false,
    );

    for (final element in elements) {
      if (element.key == Key(appId)) {
        return element;
      }
    }

    throw Exception('App widget (#$appId) not found');
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
