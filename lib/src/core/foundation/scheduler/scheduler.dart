import 'dart:async';

import 'package:rad/rad.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/foundation/scheduler/abstract.dart';
import 'package:rad/src/core/foundation/scheduler/tasks/stimulate_listener_task.dart';

/// A Task scheduler.
///
class Scheduler {
  final _tasks = <SchedulerTask>[];

  /// Stream that listener(e.g Framework) can listen to for getting tasks.
  ///
  StreamController<SchedulerTask>? _tasksStream;

  /// Stream that scheduler will listen to for listening to outer events
  /// , and act accordingly.
  ///
  StreamController<SchedulerEvent>? _eventStream;

  /// Initialize scheduler.
  ///
  /// This process involved setting up listeners and task streams.
  ///
  void init(SchedulerTaskCallback listener) {
    _tasksStream = StreamController<SchedulerTask>();
    _eventStream = StreamController<SchedulerEvent>();

    _tasksStream!.stream.listen(listener);
    _eventStream!.stream.listen(_eventListener);
  }

  /// TearDown task schedular.
  ///
  /// It should be called only during testing.
  ///
  void tearDown() {
    _tasksStream!.close();
    _eventStream!.close();
  }

  /// Add a event to task scheduler.
  ///
  void addEvent(SchedulerEvent event) {
    _eventStream!.sink.add(event);
  }

  /// Schedule a task for processing.
  ///
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
