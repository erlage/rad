import 'package:rad/rad.dart';
import 'package:rad/src/core/classes/debug.dart';
import 'package:rad/src/core/scheduler/scheduler.dart';

/// Global Registry.
///
class Registry {
  Registry._();
  static Registry? _instance;
  static Registry get instance => _instance ??= Registry._();

  final _taskSchedulers = <String, Scheduler>{};

  /// Add a reference of task scheduler corresponding to app root context.
  ///
  void registerTaskScheduler(BuildContext context, Scheduler scheduler) {
    if (_taskSchedulers.containsKey(context.appTargetKey)) {
      Debug.exception(
        "A single instance of App can register only one scheduler.",
      );

      return;
    }

    _taskSchedulers[context.appTargetKey] = scheduler;
  }

  /// Find a scheduler that's enclosing give context.
  ///
  Scheduler getTaskScheduler(BuildContext context) {
    var scheduler = _taskSchedulers[context.appTargetKey];

    if (null == scheduler) {
      Debug.exception(
        "No scheduler is registered on the provided context.",
      );

      /// Return dummy scheduler if user has registered there own error handler that
      /// doesn't throw exception onError.
      ///
      return Scheduler();
    }

    return scheduler;
  }

  /// Remove the reference of task scheduler from registered schedulers.
  ///
  void unRegisterTaskScheduler(BuildContext context) {
    _taskSchedulers.remove(context.appTargetKey);
  }
}
