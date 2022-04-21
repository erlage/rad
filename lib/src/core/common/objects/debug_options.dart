import 'package:rad/src/core/common/types.dart';

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

  /// Whether to suppress exceptions.
  ///
  final bool suppressExceptions;

  const DebugOptions({
    this.routerLogs = false,
    this.widgetLogs = false,
    this.frameworkLogs = false,
    this.developmentMode = false,
    this.suppressExceptions = false,
  });

  /// Development mode.
  /// Enable all debugging options, logs everything to console.
  ///
  static const development = DebugOptions(
    routerLogs: true,
    widgetLogs: true,
    frameworkLogs: true,
    developmentMode: true,
    suppressExceptions: false,
  );

  /// Production Mode.
  /// Disable all debugging options.
  ///
  static const production = DebugOptions(
    routerLogs: false,
    widgetLogs: false,
    frameworkLogs: false,
    developmentMode: false,
    suppressExceptions: true,
  );

  /// Default Mode.
  /// Disable logging but enable dev checks.
  ///
  static const defaultMode = DebugOptions(
    routerLogs: false,
    widgetLogs: false,
    frameworkLogs: false,
    developmentMode: true,
    suppressExceptions: false,
  );
}
