import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/widget_object.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/renderer/renderer.dart';
import 'package:rad/src/core/services/scheduler/abstract.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_build_task.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_dispose_task.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_manage_task.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_update_dependent_task.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_update_task.dart';
import 'package:rad/src/core/services/services.dart';
import 'package:rad/src/core/services/services_resolver.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

class Framework with ServicesResolver {
  final Renderer renderer;
  final BuildContext rootContext;

  var _taskListenerKey = '';

  Services get services => resolveServices(rootContext);

  Framework(this.rootContext) : renderer = Renderer(rootContext);

  /// Initialize framework state.
  ///
  void initState() {
    renderer.initState();

    _taskListenerKey = services.keyGen.generateRandomKey();

    services.scheduler.addTaskListener(_taskListenerKey, processTask);
  }

  /// Dispose framework state.
  ///
  void dispose() {
    renderer.dispose();

    services.scheduler.removeTaskListener(_taskListenerKey);
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

  /// Build widgets under given context.
  ///
  void buildChildren({
    // widgets to build
    required List<Widget> widgets,
    required BuildContext parentContext,
    //
    // -- options --
    //
    int? mountAtIndex, // Parent's children list index
    //
    // -- flags --
    //
    flagCleanParentContents = true,
    //
  }) {
    if (widgets.isEmpty) {
      return;
    }

    renderer.render(
      widgets: widgets,
      mountAtIndex: mountAtIndex,
      parentContext: parentContext,
      flagCleanParentContents: flagCleanParentContents,
    );
  }

  /// Update childrens under provided context.
  ///
  void updateChildren({
    //
    // widgets to update
    //
    required List<Widget> widgets,
    required BuildContext parentContext,
    //
    // -- options --
    //
    required UpdateType updateType,
    //
    // -- flags --
    //
    flagAddIfNotFound = true, // add childs right where they are missing
  }) {
    renderer.reRender(
      widgets: widgets,
      parentContext: parentContext,
      updateType: updateType,
      flagAddIfNotFound: flagAddIfNotFound,
    );
  }

  /// Manage child widgets.
  ///
  /// Method will call [widgetActionCallback] for each child's widget object.
  /// Whatever action the [widgetActionCallback] callback returns, framework
  /// will execute it.
  ///
  void manageChildren({
    required BuildContext parentContext,
    required WidgetActionCallback widgetActionCallback,
    //
    // -- options --
    //
    required UpdateType updateType,
    //
    // -- flags --
    //
    bool flagIterateInReverseOrder = false,
  }) {
    renderer.visitWidgets(
      updateType: updateType,
      parentContext: parentContext,
      widgetActionCallback: widgetActionCallback,
      flagIterateInReverseOrder: flagIterateInReverseOrder,
    );
  }

  /// Dispose widgets.
  ///
  void disposeWidget({
    //
    // widget object to dispose
    //
    required WidgetObject? widgetObject,
    //
    // -- flags --
    //

    required bool flagPreserveTarget,
  }) {
    if (null != widgetObject) {
      renderer.disposeWidgets(
        context: widgetObject.context,
        flagPreserveTarget: flagPreserveTarget,
      );
    }
  }

  /*
  |--------------------------------------------------------------------------
  | Internals
  |--------------------------------------------------------------------------
  */

  void _runTask(SchedulerTask task) {
    switch (task.taskType) {
      case SchedulerTaskType.build:
        task as WidgetsBuildTask;

        buildChildren(
          widgets: task.widgets,
          parentContext: task.parentContext,
          mountAtIndex: task.mountAtIndex,
          flagCleanParentContents: task.flagCleanParentContents,
        );

        break;

      case SchedulerTaskType.update:
        task as WidgetsUpdateTask;

        updateChildren(
          widgets: task.widgets,
          updateType: task.updateType,
          parentContext: task.parentContext,
          flagAddIfNotFound: task.flagAddIfNotFound,
        );

        break;

      case SchedulerTaskType.manage:
        task as WidgetsManageTask;

        manageChildren(
          parentContext: task.parentContext,
          updateType: task.updateType,
          widgetActionCallback: task.widgetActionCallback,
          flagIterateInReverseOrder: task.flagIterateInReverseOrder,
        );

        break;

      case SchedulerTaskType.dispose:
        task as WidgetsDisposeTask;

        disposeWidget(
          widgetObject: task.widgetObject,
          flagPreserveTarget: task.flagPreserveTarget,
        );

        break;

      case SchedulerTaskType.updateDependent:
        task as WidgetsUpdateDependentTask;

        renderer.reRenderContext(
          context: task.widgetContext,
        );

        break;

      case SchedulerTaskType.stimulateListener:
        // do nothing..
        break;
    }
  }
}
