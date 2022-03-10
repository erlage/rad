import 'package:rad/src/core/objects/debug_options.dart';

class Debug {
  static var developmentMode = false;

  static var routerLogs = false;
  static var widgetLogs = false;
  static var frameworkLogs = false;

  static void update(DebugOptions options) {
    routerLogs = options.routerLogs;
    widgetLogs = options.widgetLogs;
    frameworkLogs = options.frameworkLogs;
    developmentMode = options.developmentMode;
  }
}
