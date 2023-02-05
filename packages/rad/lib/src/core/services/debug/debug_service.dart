// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/objects/common_render_elements.dart';
import 'package:rad/src/core/common/objects/options/debug_options.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/services/abstract.dart';

/// Debug service.
///
@internal
class DebugService extends Service {
  final DebugOptions options;

  final bool routerLogs;
  final bool widgetLogs;
  final bool frameworkLogs;
  final bool additionalChecks;

  ExceptionCallback? _onException;
  ExceptionCallback get onException => _onException!;

  DebugService(RootRenderElement rootElement, this.options)
      : routerLogs = options.routerLogs,
        widgetLogs = options.widgetLogs,
        frameworkLogs = options.frameworkLogs,
        additionalChecks = options.additionalChecks,
        super(rootElement);

  @override
  startService() {
    var suppressExceptions = options.suppressExceptions;

    _onException = suppressExceptions ? suppressException : presentException;
  }

  @override
  stopService() => _onException = suppressException;

  /// Set custom exception handler for app.
  ///
  void setExceptionHandler(ExceptionCallback exceptionHandler) {
    _onException = exceptionHandler;
  }

  void exception(String message) {
    onException(Exception(message));
  }

  void suppressException(Exception exception) {}

  void presentException(Exception exception) {
    throw exception;
  }
}
