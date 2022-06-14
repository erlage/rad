import 'package:meta/meta.dart';

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/cache.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/objects/render_element.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_build_task.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_update_task.dart';
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
  bool shouldUpdateWidget(oldWidget) => true;

  /// Overriding this method on [StatelessWidget] can result in unexpected
  /// behavior as [StatelessWidget] build its childs at a later stage. If you
  /// don't want the [StatelessWidget] to update its child widgets, override
  /// [shouldUpdateWidget] instead.
  ///
  @nonVirtual
  @override
  bool shouldUpdateWidgetChildren(oldWidget, shouldUpdateWidget) => false;

  @override
  createRenderElement(parent) => StatelessRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| render element
|--------------------------------------------------------------------------
*/

/// StatelessWidget render element.
///
class StatelessRenderElement extends RenderElement {
  StatelessRenderElement(super.widget, super.parent);

  @override
  List<Widget> get childWidgets => ccImmutableEmptyListOfWidgets;

  // we build child of stateless widget after mount so that users can call
  // any method from context.* inside build method
  @override
  afterMount() {
    services.scheduler.addTask(
      WidgetsBuildTask(
        parentRenderElement: this,
        widgets: [(widget as StatelessWidget).build(this)],
      ),
    );
  }

  @override
  update({
    required updateType,
    required oldWidget,
    required covariant StatelessWidget newWidget,
  }) {
    services.scheduler.addTask(
      WidgetsUpdateTask(
        parentRenderElement: this,
        widgets: [(widget as StatelessWidget).build(this)],
        updateType: updateType,
      ),
    );

    return null;
  }
}
