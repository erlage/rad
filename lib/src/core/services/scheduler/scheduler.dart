import 'dart:async';

import 'package:rad/src/core/common/objects/app_options.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/services/abstract.dart';
import 'package:rad/src/core/services/scheduler/abstract.dart';

/// A Task scheduler.
///
class Scheduler extends Service {
  final SchedulerOptions options;

  final _listeners = <String, StreamSubscription?>{};

  StreamController<SchedulerTask>? _tasksStream;

  Scheduler(BuildContext context, this.options) : super(context);

  @override
  startService() {
    _tasksStream = StreamController<SchedulerTask>.broadcast();
  }

  @override
  stopService() {
    _tasksStream?.close();
  }

  void addTaskListener(String listenerKey, SchedulerTaskCallback listener) {
    if (null != _listeners[listenerKey]) {
      services.debug.exception(
        'A task listener is already associated with the key: $listenerKey',
      );

      return;
    }

    _listeners[listenerKey] = _tasksStream?.stream.listen(listener);
  }

  void removeTaskListener(String listenerKey) {
    var subscription = _listeners[listenerKey];

    if (null != subscription) {
      subscription.cancel();
    }

    _listeners.remove(listenerKey);
  }

  void addTask(SchedulerTask task) {
    _tasksStream?.add(task);
  }

  void addEvent(SchedulerEvent event) {}
}
