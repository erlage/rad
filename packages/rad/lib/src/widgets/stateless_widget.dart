import 'package:meta/meta.dart';

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/objects/render_object.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_build_task.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_update_task.dart';
import 'package:rad/src/core/services/services_registry.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// A widget that does not require mutable state.
///
@immutable
abstract class StatelessWidget extends Widget {
  const StatelessWidget({Key? key}) : super(key: key);

  /// Describes the part of the user interface represented by this widget.
  ///
  @protected
  Widget build(BuildContext context);

  /*
  |--------------------------------------------------------------------------
  | widget internals
  |--------------------------------------------------------------------------
  */

  @nonVirtual
  @override
  String get widgetType => 'StatelessWidget';

  @nonVirtual
  @override
  DomTagType? get correspondingTag => null;

  @override
  bool shouldWidgetUpdate(oldWidget) => true;

  /// Overriding this method on [StatelessWidget] can result in unexpected
  /// behavior as [StatelessWidget] build its childs at a later stage. If you
  /// don't want the [StatelessWidget] to update its child widgets, override
  /// [shouldWidgetUpdate] instead.
  ///
  @nonVirtual
  @override
  bool shouldWidgetChildrenUpdate(oldWidget, shouldWidgetUpdate) => false;

  @nonVirtual
  @override
  createRenderObject(context) => _StatelessWidgetRenderObject(context);
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class _StatelessWidgetRenderObject extends RenderObject {
  const _StatelessWidgetRenderObject(BuildContext context) : super(context);

  @override
  void afterMount() {
    var services = ServicesRegistry.instance.getServices(context);

    var widgetObject = services.walker.getWidgetObject(context)!;

    var widget = widgetObject.widget as StatelessWidget;

    services.scheduler.addTask(
      WidgetsBuildTask(
        parentContext: context,
        widgets: [widget.build(context)],
      ),
    );
  }

  @override
  update({
    required updateType,
    required oldWidget,
    required covariant StatelessWidget newWidget,
  }) {
    var schedulerService = ServicesRegistry.instance.getScheduler(context);

    schedulerService.addTask(
      WidgetsUpdateTask(
        updateType: updateType,
        parentContext: context,
        widgets: [newWidget.build(context)],
      ),
    );

    // stateless widget's dom node's description never changes.
    return null;
  }
}
