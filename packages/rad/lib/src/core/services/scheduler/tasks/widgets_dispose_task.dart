import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/render_element.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/services/scheduler/abstract.dart';

/// A task that dispose widgets.
///
class WidgetsDisposeTask extends SchedulerTask {
  /// Element to dispose.
  ///
  final RenderElement renderElement;

  /// Whether to preserve target.
  ///
  final bool flagPreserveTarget;

  WidgetsDisposeTask({
    required this.renderElement,
    this.flagPreserveTarget = false,
    VoidCallback? afterTaskCallback,
    VoidCallback? beforeTaskCallback,
  }) : super(
          afterTaskCallback: afterTaskCallback,
          beforeTaskCallback: beforeTaskCallback,
        );

  @override
  SchedulerTaskType get taskType => SchedulerTaskType.dispose;
}
