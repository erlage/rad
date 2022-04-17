import 'dart:html';

import 'package:rad/src/core/services/debug.dart';
import 'package:rad/src/core/foundation/framework.dart';
import 'package:rad/src/core/services/framework_registry.dart';
import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/foundation/common/build_context.dart';
import 'package:rad/src/core/foundation/common/debug_options.dart';
import 'package:rad/src/core/foundation/scheduler/tasks/widgets_build_task.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/utils/common_props.dart';

void startApp({
  required Widget app,
  required String targetSelector,
  VoidCallback? beforeMount,
  DebugOptions debugOptions = DebugOptions.defaultMode,
}) {
  /*
  |--------------------------------------------------------------------------
  | Pre-checks
  |--------------------------------------------------------------------------
  */

  var targetElement = document.getElementById(targetSelector) as HtmlElement?;

  if (null == targetElement) {
    throw "Unable to locate target element in HTML document";
  }

  /*
  |--------------------------------------------------------------------------
  | App bootstrap process
  |--------------------------------------------------------------------------
  */

  // Update debug options.

  Debug.update(debugOptions);

  // Decorate root element.

  CommonProps.applyDataAttributes(targetElement, {
    System.attrConcreteType: "Target",
    System.attrRuntimeType: System.contextTypeBigBang,
  });

  // Create framework instance for app.

  var framework = Framework();

  // Create root context for app.

  var rootContext = BuildContext.bigBang(targetSelector);

  // Initialize framework.

  framework.init(rootContext);

  // Fire before mount hook.

  beforeMount?.call();

  // Schedule a build task.

  // Framework is responsible for resgistering a task schedular for provided
  // root context when its init() method is called. therefore by this point
  // we assume that our scheduler for context is all set and ready to go.

  var scheduler = FrameworkRegistry.instance.getTaskScheduler(rootContext);

  scheduler.addTask(
    WidgetsBuildTask(
      widgets: [app],
      parentContext: rootContext,
    ),
  );
}
