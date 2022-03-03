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

  const DebugOptions({
    this.routerLogs = false,
    this.widgetLogs = false,
    this.frameworkLogs = false,
    this.developmentMode = false,
  });

  /// Enable all debugging options, logs everything to console.
  ///
  static const DebugOptions development = DebugOptions(
    routerLogs: true,
    widgetLogs: true,
    frameworkLogs: true,
    developmentMode: true,
  );
}
