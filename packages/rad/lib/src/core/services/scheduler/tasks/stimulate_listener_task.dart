// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/services/scheduler/abstract.dart';

/// A task that tells listener that scheduler state has changed.
/// For example, probably new tasks are added to queue and if listner
/// wants to restart processing tasks then it can.
///
@internal
class StimulateListenerTask extends SchedulerTask {
  @override
  SchedulerTaskType get taskType => SchedulerTaskType.stimulateListener;

  StimulateListenerTask({
    VoidCallback? afterTaskCallback,
    VoidCallback? beforeTaskCallback,
  }) : super(
          afterTaskCallback: afterTaskCallback,
          beforeTaskCallback: beforeTaskCallback,
        );
}
