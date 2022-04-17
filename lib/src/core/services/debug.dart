import 'package:rad/src/core/foundation/common/debug_options.dart';

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

  static var onException = presentException;
  static void exception(String message) => onException(Exception(message));

  static void presentException(Exception exception) => throw exception;
}
