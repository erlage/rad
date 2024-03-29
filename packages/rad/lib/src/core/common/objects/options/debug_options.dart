// Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// App debug options.
///
/// By default, app do additional checks during development but logs nothing.
/// You can enable/disable logs for particular modules or use pre-defined
/// modes:
///
/// - [DebugOptions.defaultMode] - Enables exceptions and additional checks.
///
/// - [DebugOptions.developmentMode] Enables exceptions, logs and additional
/// checks.
///
/// - [DebugOptions.productionMode] - Suppress exceptions, logs and additional
/// checks.
///
class DebugOptions {
  final bool widgetLogs;
  final bool routerLogs;
  final bool frameworkLogs;
  final bool additionalChecks;
  final bool suppressExceptions;

  const DebugOptions({
    this.routerLogs = false,
    this.widgetLogs = false,
    this.frameworkLogs = false,
    this.suppressExceptions = false,
    this.additionalChecks = false,
  });

  static const defaultMode = DebugOptions(
    routerLogs: false,
    widgetLogs: false,
    frameworkLogs: false,
    suppressExceptions: false,
    additionalChecks: true,
  );

  static const productionMode = DebugOptions(
    routerLogs: false,
    widgetLogs: false,
    frameworkLogs: false,
    suppressExceptions: true,
    additionalChecks: false,
  );

  static const developmentMode = DebugOptions(
    routerLogs: true,
    widgetLogs: true,
    frameworkLogs: true,
    additionalChecks: true,
    suppressExceptions: false,
  );
}
