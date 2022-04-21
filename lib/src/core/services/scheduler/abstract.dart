import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/types.dart';

/// A task that can be scheduled.
///
abstract class SchedulerTask {
  /// This callback is supposed to get called just before running task.
  ///
  final Callback? beforeTaskCallback;

  /// This callback is supposed to get called after task has be run.
  ///
  final Callback? afterTaskCallback;

  /// Type of task.
  ///
  SchedulerTaskType get taskType;

  SchedulerTask({
    this.afterTaskCallback,
    this.beforeTaskCallback,
  });
}

/// A scheduler event.
///
abstract class SchedulerEvent {
  SchedulerEventType get eventType;
}
