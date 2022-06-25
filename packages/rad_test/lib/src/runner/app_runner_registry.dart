// Copyright (c) 2022, the Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:rad_test/src/imports.dart';
import 'package:rad_test/src/runner/app_runner.dart';

/// App runner registry.
///
class AppRunnerRegistry {
  AppRunnerRegistry._();
  static AppRunnerRegistry? _instance;
  static AppRunnerRegistry get instance => _instance ??= AppRunnerRegistry._();

  int _appIdCounter = 0;

  /// Create a app runner.
  ///
  AppRunner createAppRunner({
    DebugOptions? debugOptions,
    RouterOptions? routerOptions,
    required bool useWindowMock,
  }) {
    var appId = _createTarget();
    var appTargetId = _getTargetIdFromAppId(appId);

    return AppRunner(
      appId: appId,
      appTargetId: appTargetId,
      debugOptions: debugOptions,
      routerOptions: routerOptions,
      useWindowMock: useWindowMock,
    );
  }

  /// Dispose a app runner.
  ///
  void disposeAppRunner(AppRunner appRunner) {
    _removeTarget(appRunner.appId);
  }

  /// Create target element for app runner.
  ///
  String _createTarget() {
    _appIdCounter++;

    if (null != _getTargetElement('$_appIdCounter')) {
      return _createTarget();
    }

    var appId = '$_appIdCounter';

    var element = document.createElement('div');

    element.id = _getTargetIdFromAppId(appId);

    document.body!.append(element); // fail-fast if body isn't available

    return appId;
  }

  /// Get id of target element using app id.
  ///
  String _getTargetIdFromAppId(String appId) => 't-app-$appId';

  /// Remove app runner's target element.
  ///
  void _removeTarget(String appId) {
    _getTargetElement(appId)?.remove();
  }

  /// Get app runner's target element.
  ///
  Element? _getTargetElement(String appId) {
    return document.getElementById(
      _getTargetIdFromAppId(appId),
    );
  }
}
