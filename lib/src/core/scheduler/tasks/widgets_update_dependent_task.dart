import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/scheduler/abstract.dart';

/// A task that updates a dependent widgets having given context.
///
class WidgetsUpdateDependentTask extends SchedulerTask {
  /// Widget context to update.
  ///
  final BuildContext widgetContext;

  WidgetsUpdateDependentTask({required this.widgetContext});

  @override
  get taskType => SchedulerTaskType.updateDependent;
}
