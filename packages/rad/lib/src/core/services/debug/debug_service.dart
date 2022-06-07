import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/options/debug_options.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/services/abstract.dart';

/// Debug service.
///
class DebugService extends Service {
  final DebugOptions options;

  final bool routerLogs;
  final bool widgetLogs;
  final bool frameworkLogs;
  final bool additionalChecks;

  ExceptionCallback? _onException;
  ExceptionCallback get onException => _onException!;

  DebugService(BuildContext context, this.options)
      : routerLogs = options.routerLogs,
        widgetLogs = options.widgetLogs,
        frameworkLogs = options.frameworkLogs,
        additionalChecks = options.additionalChecks,
        super(context);

  @override
  startService() {
    var suppressExceptions = options.suppressExceptions;

    _onException = suppressExceptions ? supressException : presentException;
  }

  @override
  stopService() => _onException = supressException;

  /// Set custom exception handler for app.
  ///
  void setExceptionHandler(ExceptionCallback exceptionHandler) {
    _onException = exceptionHandler;
  }

  void exception(String message) {
    onException(Exception(message));
  }

  void supressException(Exception exception) {}

  void presentException(Exception exception) {
    throw exception;
  }
}
