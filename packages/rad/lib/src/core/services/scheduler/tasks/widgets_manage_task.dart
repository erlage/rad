import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/render_element.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/services/scheduler/abstract.dart';

/// A task that helps iterating widgets under given context and perform
/// specific actions to particular widgets while iterating.
///
class WidgetsManageTask extends SchedulerTask {
  /// Callback to fire on each widget iteration.
  ///
  final WidgetActionsBuilder widgetActionCallback;

  /// Target context.
  ///
  final RenderElement parentRenderElement;

  /// Update type.
  ///
  final UpdateType updateType;

  /// Whether to iterate widgets in reverse order.
  ///
  final bool flagIterateInReverseOrder;

  WidgetsManageTask({
    this.updateType = UpdateType.visitorUpdate,
    required this.parentRenderElement,
    required this.widgetActionCallback,
    this.flagIterateInReverseOrder = false,
    Callback? afterTaskCallback,
    Callback? beforeTaskCallback,
  }) : super(
          afterTaskCallback: afterTaskCallback,
          beforeTaskCallback: beforeTaskCallback,
        );

  @override
  SchedulerTaskType get taskType => SchedulerTaskType.manage;
}
