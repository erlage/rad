// Copyright (c) 2022, the Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/objects/app_options.dart';
import 'package:rad/src/core/common/objects/common_render_elements.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/services/abstract.dart';
import 'package:rad/src/core/services/scheduler/abstract.dart';

/// A Task scheduler.
///
@internal
class SchedulerService extends Service {
  final SchedulerOptions options;

  final _listeners = <String, StreamSubscription<SchedulerTask>?>{};

  StreamController<SchedulerTask>? _tasksStream;

  SchedulerService(RootElement rootElement, this.options) : super(rootElement);

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
