// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/services/scheduler/abstract.dart';

/// A task that can be used to run multiple tasks in order.
///
@internal
class AggregateTask extends SchedulerTask {
  /// Tasks to run.
  ///
  final List<SchedulerTask> tasksToProcess;

  @override
  SchedulerTaskType get taskType => SchedulerTaskType.aggregate;

  AggregateTask({
    required this.tasksToProcess,
    VoidCallback? afterTaskCallback,
    VoidCallback? beforeTaskCallback,
  }) : super(
          afterTaskCallback: afterTaskCallback,
          beforeTaskCallback: beforeTaskCallback,
        );
}
