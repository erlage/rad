import 'dart:html';

import 'package:rad/src/core/classes/debug.dart';
import 'package:rad/src/core/classes/framework.dart';
import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/objects/debug_options.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/utils/common_props.dart';

void startApp({
  required Widget app,
  required String targetSelector,
  DebugOptions debugOptions = DebugOptions.defaultMode,
  VoidCallback? beforeMount,
}) {
  var framework = Framework();

  var appContext = BuildContext.bigBang(targetSelector, framework);

  framework.init(routingPath: '/', debugOptions: debugOptions);

  var targetElement = document.getElementById(targetSelector) as HtmlElement?;

  if (null == targetElement) {
    Debug.exception(
      "Unable to locate target element in HTML document",
    );

    return;
  }

  beforeMount?.call();

  CommonProps.applyDataAttributes(targetElement, {
    System.attrConcreteType: "Target",
    System.attrRuntimeType: System.contextTypeBigBang,
  });

  framework.buildChildren(
    widgets: [app],
    parentContext: appContext,
  );
}
