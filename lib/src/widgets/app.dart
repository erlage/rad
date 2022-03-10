import 'dart:html';

import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/interface/app_component.dart';
import 'package:rad/src/core/objects/debug_options.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/css/include/normalize.generated.dart';
import 'package:rad/src/css/main.generated.dart';
import 'package:rad/src/core/classes/framework.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/widgets/utils/common_props.dart';

class App extends Widget {
  final Widget child;

  final String targetId;

  final AppComponents? components;

  App({
    String? id,
    this.components,
    required this.child,
    required this.targetId,
    String routingPath = "",
    DebugOptions? debugOptions,
  }) : super(id) {
    /*
    |--------------------------------------------------------------------------
    | initialize
    |--------------------------------------------------------------------------
    */

    Framework.init(routingPath: routingPath, debugOptions: debugOptions);

    Framework.addGlobalStyles(GEN_STYLES_NORMALIZE_CSS, "Normalize");
    Framework.addGlobalStyles(GEN_STYLES_MAIN_CSS, "Main");

    /*
    |--------------------------------------------------------------------------
    | prepare target element from DOM
    |--------------------------------------------------------------------------
    */

    var targetElement = document.getElementById(targetId) as HtmlElement?;

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

    var components = this.components;
    components?.load();

    /*
    |--------------------------------------------------------------------------
    | bootstrap
    |--------------------------------------------------------------------------
    */

    Framework.buildChildren(
      widgets: [this],
      parentContext: BuildContext.bigBang(targetId),
    );
  }

  @override
  get concreteType => "$App";

  @override
  get correspondingTag => DomTag.div;

  @override
  createConfiguration() => _AppConfiguration(child);

  @override
  isConfigurationChanged(oldConfiguration) => false;

  @override
  createRenderObject(context) => AppWidgetRenderObject(context);
}

/*
|--------------------------------------------------------------------------
| configuration
|--------------------------------------------------------------------------
*/

class _AppConfiguration extends WidgetConfiguration {
  final Widget child;

  const _AppConfiguration(this.child);
}

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class AppWidgetRenderObject extends RenderObject {
  const AppWidgetRenderObject(BuildContext context) : super(context);

  @override
  render(
    element,
    covariant _AppConfiguration configuration,
  ) {
    Framework.buildChildren(
      widgets: [configuration.child],
      parentContext: context,
    );
  }
}
