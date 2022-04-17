import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/scheduler/abstract.dart';

/// A task that tells scheduler to push task into task stream for processing.
///
class ProcessTaskEvent extends SchedulerEvent {
  @override
  get eventType => SchedulerEventType.processTask;
}
