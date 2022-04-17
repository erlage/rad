import 'package:meta/meta.dart';
import 'package:rad/src/core/classes/registry.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/scheduler/scheduler.dart';
import 'package:rad/src/core/scheduler/tasks/widgets_build_task.dart';
import 'package:rad/src/core/scheduler/tasks/widgets_update_task.dart';
import 'package:rad/src/core/types.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// A widget that does not require mutable state.
///
@immutable
abstract class StatelessWidget extends Widget {
  const StatelessWidget({String? key}) : super(key: key);

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
  get concreteType => "$StatelessWidget";

  @nonVirtual
  @override
  get correspondingTag => DomTag.division;

  @nonVirtual
  @override
  createConfiguration() => _StatelessWidgetConfiguration(build);

  @nonVirtual
  @override
  isConfigurationChanged(oldConfiguration) => true;

  @nonVirtual
  @override
  createRenderObject(context) => _StatelessWidgetRenderObject(
        context: context,
        scheduler: Registry.instance.getTaskScheduler(context),
      );
}

/*
|--------------------------------------------------------------------------
| configuration
|--------------------------------------------------------------------------
*/

class _StatelessWidgetConfiguration extends WidgetConfiguration {
  final WidgetBuilderCallback widgetBuilder;

  const _StatelessWidgetConfiguration(this.widgetBuilder);
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class _StatelessWidgetRenderObject extends RenderObject {
  final Scheduler scheduler;

  const _StatelessWidgetRenderObject({
    required this.scheduler,
    required BuildContext context,
  }) : super(context);

  @override
  render(
    element,
    covariant _StatelessWidgetConfiguration configuration,
  ) {
    scheduler.addTask(
      WidgetsBuildTask(
        parentContext: context,
        widgets: [configuration.widgetBuilder(context)],
      ),
    );
  }

  @override
  update({
    required element,
    required updateType,
    required oldConfiguration,
    required covariant _StatelessWidgetConfiguration newConfiguration,
  }) {
    scheduler.addTask(
      WidgetsUpdateTask(
        updateType: updateType,
        parentContext: context,
        widgets: [newConfiguration.widgetBuilder(context)],
      ),
    );
  }
}
