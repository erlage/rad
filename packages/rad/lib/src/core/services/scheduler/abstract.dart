import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/types.dart';

/// A task that can be scheduled.
///
abstract class SchedulerTask {
  /// This callback is supposed to get called just before running task.
  ///
  final VoidCallback? beforeTaskCallback;

  /// This callback is supposed to get called after task has be run.
  ///
  final VoidCallback? afterTaskCallback;

  SchedulerTask({
    this.afterTaskCallback,
    this.beforeTaskCallback,
  });

  SchedulerTaskType get taskType;
}

/// A scheduler event.
///
abstract class SchedulerEvent {
  /// Listener key from where event has propagated.
  ///
  final String listenerKey;

  SchedulerEvent(this.listenerKey);

  SchedulerEventType get eventType;
}
