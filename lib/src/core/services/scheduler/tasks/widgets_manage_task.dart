import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/services/scheduler/abstract.dart';

/// A task that helps iterating widgets under given context and perform
/// specific actions to particular widgets while iterating.
///
class WidgetsManageTask extends SchedulerTask {
  /// Callback to fire on each widget iteration.
  ///
  final WidgetActionCallback widgetActionCallback;

  /// Target context.
  ///
  final BuildContext parentContext;

  /// Update type when necessary.
  ///
  final UpdateType updateType;

  /// Whether to iterate widgets in reverse order.
  ///
  final bool flagIterateInReverseOrder;

  WidgetsManageTask({
    this.updateType = UpdateType.undefined,
    required this.parentContext,
    required this.widgetActionCallback,
    this.flagIterateInReverseOrder = false,
    Callback? afterTaskCallback,
    Callback? beforeTaskCallback,
  }) : super(
          afterTaskCallback: afterTaskCallback,
          beforeTaskCallback: beforeTaskCallback,
        );

  @override
  get taskType => SchedulerTaskType.manage;
}
