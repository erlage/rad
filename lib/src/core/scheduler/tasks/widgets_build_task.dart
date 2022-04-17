import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/scheduler/abstract.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// A task that build widgets under given context.
///
class WidgetsBuildTask extends SchedulerTask {
  /// Target context.
  ///
  final BuildContext parentContext;

  /// List of widgets to build.
  ///
  final List<Widget> widgets;

  /// Parent's children list index.
  ///
  final int? mountAtIndex;

  /// Whether to clean parent contents.
  ///
  final bool flagCleanParentContents;

  WidgetsBuildTask({
    required this.parentContext,
    required this.widgets,
    this.mountAtIndex,
    this.flagCleanParentContents = true,
  });

  @override
  get taskType => SchedulerTaskType.build;
}
