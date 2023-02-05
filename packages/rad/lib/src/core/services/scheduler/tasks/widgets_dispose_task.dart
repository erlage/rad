// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/abstract/render_element.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/services/scheduler/abstract.dart';

/// A task that dispose widgets.
///
@internal
class WidgetsDisposeTask extends SchedulerTask {
  /// Element to dispose.
  ///
  final RenderElement renderElement;

  /// Whether to preserve target.
  ///
  final bool flagPreserveTarget;

  WidgetsDisposeTask({
    required this.renderElement,
    this.flagPreserveTarget = false,
    VoidCallback? afterTaskCallback,
    VoidCallback? beforeTaskCallback,
  }) : super(
          afterTaskCallback: afterTaskCallback,
          beforeTaskCallback: beforeTaskCallback,
        );

  @override
  SchedulerTaskType get taskType => SchedulerTaskType.dispose;
}
