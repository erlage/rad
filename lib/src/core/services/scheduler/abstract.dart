import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/types.dart';

abstract class SchedulerTask {
  final Callback? beforeTaskCallback;
  final Callback? afterTaskCallback;

  SchedulerTaskType get taskType;

  SchedulerTask({
    this.afterTaskCallback,
    this.beforeTaskCallback,
  });
}

abstract class SchedulerEvent {
  SchedulerEventType get eventType;
}
