import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/services/scheduler/abstract.dart';

/// A task that tells scheduler to push task into task stream for processing.
///
class SendNextTaskEvent extends SchedulerEvent {
  @override
  get eventType => SchedulerEventType.sendNextTask;
}
