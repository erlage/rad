import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/renderer/renderer.dart';
import 'package:rad/src/core/services/scheduler/abstract.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_build_task.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_dispose_task.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_manage_task.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_update_dependent_task.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_update_task.dart';
import 'package:rad/src/core/services/services_registry.dart';

class Framework {
  /// Renderer.
  ///
  final Renderer _renderer;

  /// Root context.
  ///
  final BuildContext rootContext;

  /// Whether framework is in test mode.
  ///
  /// Renderer that is responsible for build and managing widgets is not
  /// exposed in app space, by default. Framework act as a gateway to renderer
  /// in test mode so that test packages can build widgets using a very
  /// unstable but low-level API.
  ///
  final bool _isInTestMode;

  /// Create framework instance.
  ///
  Framework(this.rootContext)
      : _isInTestMode = false,
        _renderer = Renderer(rootContext);

  /// Create framework instance with isTestMode flag on.
  ///
  Framework.inTestMode(this.rootContext)
      : _isInTestMode = true,
        _renderer = Renderer(rootContext);

  /// Renderer is accessible only if framework instance is created in test mode.
  ///
  Renderer get renderer {
    if (_isInTestMode) return _renderer;

    throw Exception('Start app in test-mode for accessing renderer');
  }

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
          _processTask,
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

  /*
  |--------------------------------------------------------------------------
  | Internals
  |--------------------------------------------------------------------------
  */

  /// Process a scheduled task.
  ///
  void _processTask(SchedulerTask task) {
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
            parentContext: task.parentContext,
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
          parentContext: task.parentContext,
          flagAddIfNotFound: task.flagAddIfNotFound,
        );

        break;

      case SchedulerTaskType.manage:
        task as WidgetsManageTask;

        _renderer.visitWidgets(
          parentContext: task.parentContext,
          updateType: task.updateType,
          widgetActionCallback: task.widgetActionCallback,
          flagIterateInReverseOrder: task.flagIterateInReverseOrder,
        );

        break;

      case SchedulerTaskType.dispose:
        task as WidgetsDisposeTask;

        _renderer.disposeWidget(
          context: task.widgetObject.context,
          flagPreserveTarget: task.flagPreserveTarget,
        );

        break;

      case SchedulerTaskType.updateDependent:
        task as WidgetsUpdateDependentTask;

        _renderer.reRenderContext(
          context: task.widgetContext,
        );

        break;

      case SchedulerTaskType.stimulateListener:
        // do nothing..
        break;
    }
  }
}
