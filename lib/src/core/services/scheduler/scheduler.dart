import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/app_options.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/services/abstract.dart';
import 'package:rad/src/core/services/scheduler/abstract.dart';
import 'package:rad/src/core/services/scheduler/tasks/stimulate_listener_task.dart';

/// A Task scheduler.
///
class Scheduler extends Service {
  final SchedulerOptions options;

  final _taskQueues = <String, List<SchedulerTask>>{};
  final _taskListeners = <String, SchedulerTaskCallback>{};

  Scheduler(BuildContext context, this.options) : super(context);

  @override
  startService() {
    _taskQueues.clear();
    _taskListeners.clear();
  }

  @override
  stopService() {
    _taskQueues.clear();
    _taskListeners.clear();
  }

  void addTaskListener(String listenerKey, SchedulerTaskCallback listener) {
    if (_taskListeners.containsKey(listenerKey)) {
      services.debug.exception(
        'A task listener is already associated with the key: $listenerKey',
      );

      return;
    }

    _taskQueues[listenerKey] = [];
    _taskListeners[listenerKey] = listener;
  }

  void removeTaskListener(String listenerKey) {
    _taskQueues.remove(listenerKey);
    _taskListeners.remove(listenerKey);
  }

  void addTask(SchedulerTask task) {
    for (var listenerKey in _taskQueues.keys) {
      var taskQueue = _taskQueues[listenerKey];
      var listener = _taskListeners[listenerKey];

      if (null != taskQueue) {
        taskQueue.add(task);
      }

      if (null != listener) {
        listener(StimulateListenerTask());
      }
    }
  }

  void addEvent(SchedulerEvent event) {
    switch (event.eventType) {
      case SchedulerEventType.sendNextTask:
        _sendNextTask(event.listenerKey);

        break;
    }
  }

  void _sendNextTask(String listenerKey) {
    var queue = _taskQueues[listenerKey];
    var listener = _taskListeners[listenerKey];

    if (null != queue && queue.isNotEmpty) {
      if (null != listener) {
        listener(queue.removeAt(0));
      }
    }
  }
}
