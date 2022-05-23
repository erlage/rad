import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/services/scheduler/abstract.dart';

/// A task that tells listener that scheduler state has changed.
/// For example, probably new tasks are added to queue and if listner
/// wants to restart processing tasks then it can.
///
class StimulateListenerTask extends SchedulerTask {
  @override
  SchedulerTaskType get taskType => SchedulerTaskType.stimulateListener;

  StimulateListenerTask({
    Callback? afterTaskCallback,
    Callback? beforeTaskCallback,
  }) : super(
          afterTaskCallback: afterTaskCallback,
          beforeTaskCallback: beforeTaskCallback,
        );
}
