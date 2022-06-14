import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/render_element.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/services/scheduler/abstract.dart';

/// A task that updates a dependent widgets having given context.
///
class WidgetsUpdateDependentTask extends SchedulerTask {
  /// Element to update.
  ///
  final RenderElement dependentRenderElement;

  WidgetsUpdateDependentTask({
    required this.dependentRenderElement,
    VoidCallback? afterTaskCallback,
    VoidCallback? beforeTaskCallback,
  }) : super(
          afterTaskCallback: afterTaskCallback,
          beforeTaskCallback: beforeTaskCallback,
        );

  @override
  SchedulerTaskType get taskType => SchedulerTaskType.updateDependent;
}
