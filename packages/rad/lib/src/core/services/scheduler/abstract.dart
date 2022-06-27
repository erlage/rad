// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/types.dart';

/// A task that can be scheduled.
///
@internal
abstract class SchedulerTask {
  /// This callback is supposed to get called just before running task.
  ///
  final VoidCallback? beforeTaskCallback;

  /// This callback is supposed to get called after task has be run.
  ///
  final VoidCallback? afterTaskCallback;

  SchedulerTask({
    this.afterTaskCallback,
    this.beforeTaskCallback,
  });

  SchedulerTaskType get taskType;
}

/// A scheduler event.
///
@internal
abstract class SchedulerEvent {
  /// Listener key from where event has propagated.
  ///
  final String listenerKey;

  SchedulerEvent(this.listenerKey);

  SchedulerEventType get eventType;
}
