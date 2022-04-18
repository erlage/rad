import 'dart:html';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/debug_options.dart';
import 'package:rad/src/core/services/services.dart';
import 'package:rad/src/core/framework.dart';
import 'package:rad/src/core/services/services_registry.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_build_task.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/utils/common_props.dart';

void startApp({
  required Widget app,
  required String targetSelector,
  String routingPath = '',
  VoidCallback? beforeMount,
  DebugOptions debugOptions = DebugOptions.defaultMode,
}) {
  /*
  |--------------------------------------------------------------------------
  | Create root context
  |--------------------------------------------------------------------------
  */

  var rootContext = BuildContext.bigBang(targetSelector);

  /*
  |--------------------------------------------------------------------------
  | Spin framework instance for app
  |--------------------------------------------------------------------------
  */

  var framework = Framework(rootContext);

  /*
  |--------------------------------------------------------------------------
  | Start services
  |--------------------------------------------------------------------------
  */

  var services = Services(rootContext);

  ServicesRegistry.instance.registerServices(rootContext, services);

  services.debug.startService(debugOptions);

  services.router.startService(routingPath);

  services.scheduler.startService(framework.taskProcessor);

  /*
  |--------------------------------------------------------------------------
  | Pre-checks before mount
  |--------------------------------------------------------------------------
  */

  var targetElement = document.getElementById(targetSelector) as HtmlElement?;

  if (null == targetElement) {
    services.debug.exception(
      "Unable to locate target element in HTML document",
    );

    return;
  }

  /*
  |--------------------------------------------------------------------------
  | Decorate target element
  |--------------------------------------------------------------------------
  */

  CommonProps.applyDataAttributes(targetElement, {
    System.attrConcreteType: "Target",
    System.attrRuntimeType: System.contextTypeBigBang,
  });

  /*
  |--------------------------------------------------------------------------
  | Trigger hooks
  |--------------------------------------------------------------------------
  */

  beforeMount?.call();

  /*
  |--------------------------------------------------------------------------
  | Schedule a build task.
  |--------------------------------------------------------------------------
  */

  var scheduler = ServicesRegistry.instance.getScheduler(rootContext);

  scheduler.addTask(
    WidgetsBuildTask(
      widgets: [app],
      parentContext: rootContext,
    ),
  );
}
