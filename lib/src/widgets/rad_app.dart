import 'dart:html';

import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/interface/app_component.dart';
import 'package:rad/src/core/objects/debug_options.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/css/main.generated.dart';
import 'package:rad/src/core/classes/framework.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/widgets/utils/common_props.dart';

class RadApp extends Widget {
  final Widget child;

  final String targetKey;

  final Components? additionalComponents;

  RadApp({
    String? key,
    required this.child,
    required this.targetKey,
    String routingPath = "",
    DebugOptions? debugOptions,
    this.additionalComponents,
  }) : super(key) {
    /*
    |--------------------------------------------------------------------------
    | initialize
    |--------------------------------------------------------------------------
    */

    Framework.init(routingPath: routingPath, debugOptions: debugOptions);

    Framework.injectStyles(GEN_STYLES_MAIN_CSS, "Main");

    /*
    |--------------------------------------------------------------------------
    | prepare target element from DOM
    |--------------------------------------------------------------------------
    */

    var targetElement = document.getElementById(targetKey) as HtmlElement?;

    if (null == targetElement) {
      throw "Unable to locate target element in HTML document";
    }

    CommonProps.applyDataAttributes(targetElement, {
      System.attrConcreteType: "Target",
      System.attrRuntimeType: System.contextTypeBigBang,
    });

    /*
    |--------------------------------------------------------------------------
    | load components
    |--------------------------------------------------------------------------
    */

    additionalComponents?.load();

    /*
    |--------------------------------------------------------------------------
    | bootstrap
    |--------------------------------------------------------------------------
    */

    Framework.buildChildren(
      widgets: [this],
      parentContext: BuildContext.bigBang(targetKey),
    );
  }

  @override
  get widgetChildren => [child];

  @override
  get concreteType => "$RadApp";

  @override
  get correspondingTag => DomTag.division;

  @override
  createConfiguration() => const WidgetConfiguration();

  @override
  isConfigurationChanged(oldConfiguration) => false;

  @override
  createRenderObject(context) => AppWidgetRenderObject(context);
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class AppWidgetRenderObject extends RenderObject {
  const AppWidgetRenderObject(BuildContext context) : super(context);
}