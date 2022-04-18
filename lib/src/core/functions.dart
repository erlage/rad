import 'dart:html';

import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/foundation/common/build_context.dart';
import 'package:rad/src/core/foundation/common/debug_options.dart';
import 'package:rad/src/core/foundation/services.dart';
import 'package:rad/src/core/foundation/framework.dart';
import 'package:rad/src/core/utilities/services_registry.dart';
import 'package:rad/src/core/foundation/scheduler/tasks/widgets_build_task.dart';
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

String fnMapDomTag(DomTag tag) {
  switch (tag) {
    case DomTag.header:
      return "header";

    case DomTag.footer:
      return "footer";

    case DomTag.navigation:
      return "nav";

    case DomTag.division:
      return "div";

    case DomTag.span:
      return "span";

    case DomTag.anchor:
      return "a";

    case DomTag.blockquote:
      return "blockquote";

    case DomTag.horizontalRule:
      return "hr";

    case DomTag.label:
      return "label";

    case DomTag.iFrame:
      return "iframe";

    case DomTag.breakLine:
      return "br";

    case DomTag.image:
      return "img";

    case DomTag.canvas:
      return "canvas";

    case DomTag.paragraph:
      return "p";

    case DomTag.input:
      return "input";

    case DomTag.form:
      return "form";

    case DomTag.fieldSet:
      return "fieldset";

    case DomTag.legend:
      return "legend";

    case DomTag.idiomatic:
      return "i";

    case DomTag.strong:
      return "strong";

    case DomTag.small:
      return "small";

    case DomTag.subScript:
      return "sub";

    case DomTag.superScript:
      return "sup";

    case DomTag.unOrderedList:
      return "ul";

    case DomTag.listItem:
      return "li";

    case DomTag.button:
      return "button";

    case DomTag.select:
      return "select";

    case DomTag.option:
      return "option";

    case DomTag.progress:
      return "progress";

    case DomTag.textArea:
      return "textarea";

    // headings

    case DomTag.heading1:
      return "h1";

    case DomTag.heading2:
      return "h2";

    case DomTag.heading3:
      return "h3";

    case DomTag.heading4:
      return "h4";

    case DomTag.heading5:
      return "h5";

    case DomTag.heading6:
      return "h6";
  }
}

String fnMapDomEventType(DomEventType eventType) {
  switch (eventType) {
    case DomEventType.click:
      return "click";

    case DomEventType.change:
      return "change";

    case DomEventType.input:
      return "input";

    case DomEventType.submit:
      return "submit";
  }
}

String fnMapInputType(InputType type) {
  switch (type) {
    case InputType.text:
      return "text";

    case InputType.password:
      return "password";

    case InputType.file:
      return "file";

    case InputType.radio:
      return "radio";

    case InputType.checkbox:
      return "checkbox";

    case InputType.submit:
      return "submit";
  }
}

String fnMapButtonType(ButtonType buttonType) {
  switch (buttonType) {
    case ButtonType.button:
      return "button";

    case ButtonType.submit:
      return "submit";

    case ButtonType.reset:
      return "reset";
  }
}

String fnMapFormEncType(FormEncType type) {
  switch (type) {
    case FormEncType.applicationXwwwFormUrlEncoded:
      return "application/x-www-form-urlencoded";

    case FormEncType.multipartFormData:
      return "multipart/form-data";

    case FormEncType.textPlain:
      return "text/plain";
  }
}

String fnMapFormMethod(FormMethod method) {
  switch (method) {
    case FormMethod.post:
      return "post";

    case FormMethod.get:
      return "get";
  }
}

bool fnIsKeyValueMapEqual(
  Map<String, String> mapOne,
  Map<String, String> mapTwo,
) {
  if (mapOne.length != mapTwo.length) return false;

  for (var key in mapOne.keys) {
    if (mapOne[key] != mapTwo[key]) return false;
  }

  return true;
}

String fnEncodeKeyValueMap(Map<String, String> valueMap) {
  var encodedMap = '';

  for (var key in valueMap.keys) {
    if (key.isNotEmpty) {
      encodedMap += '/${Uri.encodeComponent(key)}';
    }

    var value = valueMap[key];

    if (null != value && value.isNotEmpty) {
      encodedMap += '/${Uri.encodeComponent(valueMap[key]!)}';
    }
  }

  return encodedMap;
}
