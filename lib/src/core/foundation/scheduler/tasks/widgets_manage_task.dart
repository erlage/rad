import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/foundation/common/build_context.dart';
import 'package:rad/src/core/foundation/scheduler/abstract.dart';
import 'package:rad/src/core/types.dart';

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
  final UpdateType? updateType;

  /// Whether to iterate widgets in reverse order.
  ///
  final bool flagIterateInReverseOrder;

  WidgetsManageTask({
    this.updateType,
    required this.parentContext,
    required this.widgetActionCallback,
    this.flagIterateInReverseOrder = false,
  });

  @override
  get taskType => SchedulerTaskType.manage;
}
