// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/abstract/build_context.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/renderer/renderer.dart';
import 'package:rad/src/core/services/scheduler/abstract.dart';
import 'package:rad/src/core/services/scheduler/tasks/aggregate_task.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_build_task.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_dispose_task.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_manage_task.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_update_dependent_task.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_update_task.dart';
import 'package:rad/src/core/services/services_registry.dart';

/// Core's gateway.
///
@internal
class Framework {
  /// Renderer.
  ///
  final Renderer _renderer;

  /// Root context.
  ///
  final BuildContext rootContext;

  /// Create framework instance.
  ///
  Framework(this.rootContext) : _renderer = Renderer(rootContext);

  /// Initialize framework state.
  ///
  void initState() {
    _renderer.initState();

    ServicesRegistry.instance
        .getScheduler(
          rootContext,
        )
        .addTaskListener(
          rootContext.appTargetId,
          processTask,
        );
  }

  /// Dispose framework state.
  ///
  void dispose() {
    ServicesRegistry.instance
        .getScheduler(
          rootContext,
        )
        .removeTaskListener(
          rootContext.appTargetId,
        );

    _renderer.dispose();
  }

  /// Process a scheduled task.
  ///
  void processTask(SchedulerTask task) {
    if (null != task.beforeTaskCallback) {
      task.beforeTaskCallback!();
    }

    _runTask(task);

    if (null != task.afterTaskCallback) {
      task.afterTaskCallback!();
    }
  }

  void _runTask(SchedulerTask task) {
    switch (task.taskType) {
      case SchedulerTaskType.build:
        task as WidgetsBuildTask;

        if (task.widgets.isNotEmpty) {
          _renderer.render(
            widgets: task.widgets,
            parentRenderElement: task.parentRenderElement,
            mountAtIndex: task.mountAtIndex,
            flagCleanParentContents: task.flagCleanParentContents,
          );
        }

        break;

      case SchedulerTaskType.update:
        task as WidgetsUpdateTask;

        _renderer.reRender(
          widgets: task.widgets,
          updateType: task.updateType,
          parentRenderElement: task.parentRenderElement,
          flagAddIfNotFound: task.flagAddIfNotFound,
        );

        break;

      case SchedulerTaskType.manage:
        task as WidgetsManageTask;

        _renderer.visitWidgets(
          updateType: task.updateType,
          parentRenderElement: task.parentRenderElement,
          widgetActionCallback: task.widgetActionCallback,
          flagIterateInReverseOrder: task.flagIterateInReverseOrder,
        );

        break;

      case SchedulerTaskType.dispose:
        task as WidgetsDisposeTask;

        _renderer.disposeWidget(
          renderElement: task.renderElement,
          flagPreserveTarget: task.flagPreserveTarget,
        );

        break;

      case SchedulerTaskType.updateDependent:
        task as WidgetsUpdateDependentTask;

        _renderer.reRenderContext(
          renderElement: task.dependentRenderElement,
        );

        break;

      // misc tasks

      case SchedulerTaskType.aggregate:
        task as AggregateTask;

        for (final taskItem in task.tasksToProcess) {
          processTask(taskItem);
        }

        break;

      case SchedulerTaskType.stimulateListener:
        // do nothing..
        break;
    }
  }
}
