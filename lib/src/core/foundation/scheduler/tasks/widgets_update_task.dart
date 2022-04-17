import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/foundation/common/build_context.dart';
import 'package:rad/src/core/foundation/scheduler/abstract.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// A task that updates task under given context.
///
class WidgetsUpdateTask extends SchedulerTask {
  /// Target context.
  ///
  final BuildContext parentContext;

  /// List of widgets to update.
  ///
  final List<Widget> widgets;

  /// Type of update.
  ///
  final UpdateType updateType;

  /// Whether to hide obsolute children.
  ///
  final bool flagHideObsoluteChildren;

  /// Whether to delete obsolute children.
  ///
  final bool flagDisposeObsoluteChildren;

  /// Whether to add child if missing.
  ///
  final bool flagAddIfNotFound;

  /// Whether to append missing child.
  ///
  final bool flagAddAsAppendMode;

  /// Whether to build from scratch if child count is not matched with
  /// the previous count.
  ///
  final bool flagTolerateChildrenCountMisMatch;

  WidgetsUpdateTask({
    required this.widgets,
    required this.parentContext,
    required this.updateType,
    this.flagHideObsoluteChildren = false,
    this.flagDisposeObsoluteChildren = true,
    this.flagAddIfNotFound = true,
    this.flagAddAsAppendMode = false,
    this.flagTolerateChildrenCountMisMatch = true,
  });

  @override
  get taskType => SchedulerTaskType.update;
}
