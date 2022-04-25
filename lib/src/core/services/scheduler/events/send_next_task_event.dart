import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/services/scheduler/abstract.dart';

/// A event that tells scheduler to push task into task stream for processing.
///
class SendNextTaskEvent extends SchedulerEvent {
  SendNextTaskEvent(String listenerKey) : super(listenerKey);

  @override
  get eventType => SchedulerEventType.sendNextTask;
}
