import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/services/scheduler/abstract.dart';

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