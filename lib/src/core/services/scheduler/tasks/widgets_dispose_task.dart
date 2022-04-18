import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/services/scheduler/abstract.dart';
import 'package:rad/src/core/common/objects/widget_object.dart';

/// A task that dispose widgets.
///
class WidgetsDisposeTask extends SchedulerTask {
  /// Widget context to update.
  ///
  final WidgetObject? widgetObject;

  /// Whether to preserve target.
  ///
  final bool flagPreserveTarget;

  WidgetsDisposeTask({
    this.widgetObject,
    this.flagPreserveTarget = false,
  });

  @override
  get taskType => SchedulerTaskType.dispose;
}