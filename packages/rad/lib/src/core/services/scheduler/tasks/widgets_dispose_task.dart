import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/widget_object.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/services/scheduler/abstract.dart';

/// A task that dispose widgets.
///
class WidgetsDisposeTask extends SchedulerTask {
  /// Widget object to dispose.
  ///
  final WidgetObject widgetObject;

  /// Whether to preserve target.
  ///
  final bool flagPreserveTarget;

  WidgetsDisposeTask({
    required this.widgetObject,
    this.flagPreserveTarget = false,
    Callback? afterTaskCallback,
    Callback? beforeTaskCallback,
  }) : super(
          afterTaskCallback: afterTaskCallback,
          beforeTaskCallback: beforeTaskCallback,
        );

  @override
  SchedulerTaskType get taskType => SchedulerTaskType.dispose;
}
