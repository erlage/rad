import 'package:rad/src/core/enums.dart';

abstract class SchedulerTask {
  SchedulerTaskType get taskType;
}

abstract class SchedulerEvent {
  SchedulerEventType get eventType;
}
