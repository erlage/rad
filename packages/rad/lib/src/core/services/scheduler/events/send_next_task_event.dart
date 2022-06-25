// Copyright (c) 2022, the Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/services/scheduler/abstract.dart';

/// A event that tells scheduler to push task into task stream for processing.
///
@internal
class SendNextTaskEvent extends SchedulerEvent {
  SendNextTaskEvent(String listenerKey) : super(listenerKey);

  @override
  SchedulerEventType get eventType => SchedulerEventType.sendNextTask;
}
