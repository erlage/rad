import 'package:rad/src/core/types.dart';

/// Debug options.
///
/// Setting debug options help debug your applications.
///
/// Most importantly, we've this utility for quick debugging
/// during development.
///
class DebugOptions {
  /// checks application code for potential bugs.
  ///
  final bool developmentMode;

  /// Whether to log navigator, routes, paths
  ///
  final bool routerLogs;

  /// Framework logs
  ///
  final bool frameworkLogs;

  /// Builder logs, logs related to widget builds, rebuilds, disposes
  ///
  final bool widgetLogs;

  /// Custom exception handler
  ///
  final ExceptionCallback? exceptionHandler;

  const DebugOptions({
    this.routerLogs = false,
    this.widgetLogs = false,
    this.frameworkLogs = false,
    this.developmentMode = false,
    this.exceptionHandler,
  });

  /// Development mode.
  /// Enable all debugging options, logs everything to console.
  ///
  static const development = DebugOptions(
    routerLogs: true,
    widgetLogs: true,
    frameworkLogs: true,
    developmentMode: true,
  );

  /// Production Mode.
  /// Disable all debugging options.
  ///
  static const production = DebugOptions(
    routerLogs: false,
    widgetLogs: false,
    frameworkLogs: false,
    developmentMode: false,
  );

  /// Default Mode.
  /// Disable logging but enable dev checks.
  ///
  static const defaultMode = DebugOptions(
    routerLogs: false,
    widgetLogs: false,
    frameworkLogs: false,
    developmentMode: true,
  );
}
