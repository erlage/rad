import 'package:meta/meta.dart';

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/render_object.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_build_task.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_update_task.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/services/services_registry.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/core/common/objects/key.dart';

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
  get widgetType => "$StatelessWidget";

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
  createRenderObject(context) => _StatelessWidgetRenderObject(context);
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
  const _StatelessWidgetRenderObject(BuildContext context) : super(context);

  @override
  render(
    element,
    covariant _StatelessWidgetConfiguration configuration,
  ) {
    var schedulerService = ServicesRegistry.instance.getScheduler(context);

    schedulerService.addTask(
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
    var schedulerService = ServicesRegistry.instance.getScheduler(context);

    schedulerService.addTask(
      WidgetsUpdateTask(
        updateType: updateType,
        parentContext: context,
        widgets: [newConfiguration.widgetBuilder(context)],
      ),
    );
  }
}
