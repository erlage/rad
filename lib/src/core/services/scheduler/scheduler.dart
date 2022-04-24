import 'dart:async';

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/services/scheduler/abstract.dart';
import 'package:rad/src/core/services/scheduler/tasks/stimulate_listener_task.dart';

/// A Task scheduler.
///
/// Running tasks is the responsbility of a task listener. Scheduler service
/// is a mere mediator between objects that want to add tasks and the objects
/// that are capable of running those tasks.
///
class Scheduler {
  final _tasks = <SchedulerTask>[];

  /// Stream, that a listener(e.g Framework) can listen to for getting tasks.
  ///
  StreamController<SchedulerTask>? _tasksStream;

  /// Stream, that a scheduler will listen to for listening to.
  ///
  StreamController<SchedulerEvent>? _eventStream;

  void startService(SchedulerTaskCallback listener) {
    _tasksStream = StreamController<SchedulerTask>();
    _eventStream = StreamController<SchedulerEvent>();

    _tasksStream!.stream.listen(listener);
    _eventStream!.stream.listen(_eventListener);
  }

  void stopService() {
    _tasksStream!.close();
    _eventStream!.close();
  }

  void addEvent(SchedulerEvent event) {
    _eventStream!.sink.add(event);
  }

  void addTask(SchedulerTask task) {
    _tasks.add(task);

    _tasksStream!.sink.add(StimulateListenerTask());
  }

  void _eventListener(SchedulerEvent event) {
    switch (event.eventType) {
      case SchedulerEventType.sendNextTask:
        if (_tasks.isNotEmpty) {
          _tasksStream!.sink.add(_tasks.removeAt(0));
        }

        break;
    }
  }
}
