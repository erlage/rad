import 'package:rad/src/core/common/objects/debug_options.dart';
import 'package:rad/src/core/common/types.dart';

/// Service that throw/suppress errors.
///
class Debug {
  bool? _routerLogs;
  bool get routerLogs => _routerLogs!;

  bool? _widgetLogs;
  bool get widgetLogs => _widgetLogs!;

  bool? _frameworkLogs;
  bool get frameworkLogs => _frameworkLogs!;

  bool? _developmentMode;
  bool get developmentMode => _developmentMode!;

  ExceptionCallback? _onException;
  ExceptionCallback get onException => _onException!;

  void startService(DebugOptions options) {
    _routerLogs = options.routerLogs;
    _widgetLogs = options.widgetLogs;
    _frameworkLogs = options.frameworkLogs;
    _developmentMode = options.developmentMode;

    _onException = options.exceptionHandler ?? presentException;
  }

  void stopService() => _onException = supressException;

  void exception(String message) => onException(Exception(message));

  void supressException(Exception exception) {}
  void presentException(Exception exception) => throw exception;
}
