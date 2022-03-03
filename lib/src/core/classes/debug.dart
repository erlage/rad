import 'package:rad/src/core/objects/debug_options.dart';

class Debug {
  static late var developmentMode = false;

  static late var routerLogs = false;
  static late var widgetLogs = false;
  static late var frameworkLogs = false;

  static void set(DebugOptions options) {
    routerLogs = options.routerLogs;
    widgetLogs = options.widgetLogs;
    frameworkLogs = options.frameworkLogs;
    developmentMode = options.developmentMode;
  }
}
