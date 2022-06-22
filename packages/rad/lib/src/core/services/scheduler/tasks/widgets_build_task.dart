import 'package:rad/src/core/common/abstract/render_element.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/services/scheduler/abstract.dart';
import 'package:rad/src/widgets/abstract/widget.dart';

/// A task that build widgets under given context.
///
class WidgetsBuildTask extends SchedulerTask {
  /// Target context.
  ///
  final RenderElement parentRenderElement;

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
    required this.parentRenderElement,
    required this.widgets,
    this.mountAtIndex,
    this.flagCleanParentContents = true,
    VoidCallback? afterTaskCallback,
    VoidCallback? beforeTaskCallback,
  }) : super(
          afterTaskCallback: afterTaskCallback,
          beforeTaskCallback: beforeTaskCallback,
        );

  @override
  SchedulerTaskType get taskType => SchedulerTaskType.build;
}
