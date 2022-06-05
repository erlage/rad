import 'package:meta/meta.dart';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/core/common/objects/dom_node_description.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/objects/render_object.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/async_route.dart';
import 'package:rad/src/widgets/navigator.dart';

/// [Navigator]'s Route.
///
/// A [Route] act as a wrapper for your page contents. Along with page,
/// it contains routing specific information that helps [Navigator] manage
/// this widget position in tree.
///
/// See also:
///
///  * [AsyncRoute], for asynchronous routes.
///
class Route extends Widget {
  /// Name of the Route path.
  ///
  final String path;

  /// Name of the Route.
  ///
  final String name;

  /// Route's contents.
  ///
  final Widget page;

  const Route({
    Key? key,
    String? path,
    required this.name,
    required this.page,
  })  : path = path ?? name,
        super(key: key);

  @nonVirtual
  @override
  String get widgetType => 'Route';

  // route creates a dom node(div) because when navigator open/close route, it
  // does that using css.
  //
  // if route didn't have its own dom node, framework will try applying css
  // rules on a closest node. this might don't work correctly as closest node
  // can already have conflicting set of css rules.

  @override
  DomTag get correspondingTag => DomTag.division;

  @override
  List<Widget> get widgetChildren => [page];

  @override
  createConfiguration() => RouteConfiguration(name: name, path: path);

  @override
  isConfigurationChanged(covariant RouteConfiguration oldConfiguration) {
    return path != oldConfiguration.path || name != oldConfiguration.name;
  }

  @override
  createRenderObject(context) => RouteRenderObject(context);
}

/*
|--------------------------------------------------------------------------
| configuration
|--------------------------------------------------------------------------
*/

class RouteConfiguration extends WidgetConfiguration {
  final String name;
  final String path;

  const RouteConfiguration({required this.name, required this.path});
}

/*
|--------------------------------------------------------------------------
| description(never changes for route widget)
|--------------------------------------------------------------------------
*/

const _description = DomNodeDescription(
  attributes: {
    Attributes.classAttribute: Constants.classRoute,
  },
);

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class RouteRenderObject extends RenderObject {
  const RouteRenderObject(BuildContext context) : super(context);

  @override
  render({required configuration}) => _description;
}
