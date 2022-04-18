import 'package:rad/src/core/common/enums.dart';

abstract class SchedulerTask {
  SchedulerTaskType get taskType;
}

abstract class SchedulerEvent {
  SchedulerEventType get eventType;
}
