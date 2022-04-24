/// Debug options.
///
/// Setting debug options help debug your applications.
///
/// Most importantly, we've this utility for quick debugging
/// during development.
///
class DebugOptions {
  final bool routerLogs;

  final bool frameworkLogs;

  final bool widgetLogs;

  final bool suppressExceptions;

  final bool developmentMode;

  const DebugOptions({
    this.routerLogs = false,
    this.widgetLogs = false,
    this.frameworkLogs = false,
    this.suppressExceptions = false,
    this.developmentMode = false,
  });

  static const development = DebugOptions(
    routerLogs: true,
    widgetLogs: true,
    frameworkLogs: true,
    suppressExceptions: false,
    developmentMode: true,
  );

  static const production = DebugOptions(
    routerLogs: false,
    widgetLogs: false,
    frameworkLogs: false,
    suppressExceptions: true,
    developmentMode: false,
  );

  static const defaultMode = DebugOptions(
    routerLogs: false,
    widgetLogs: false,
    frameworkLogs: false,
    suppressExceptions: false,
    developmentMode: true,
  );
}
