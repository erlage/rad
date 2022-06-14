import 'package:meta/meta.dart';

import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/dom_node_description.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/widgets/abstract/single_child_widget.dart';
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
class Route extends SingleChildWidget {
  /// Name of the Route path.
  ///
  final String path;

  /// Name of the Route.
  ///
  final String name;

  const Route({
    Key? key,
    String? path,
    required this.name,
    required Widget page,
  })  : path = path ?? name,
        super(key: key, child: page);

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
  DomTagType get correspondingTag => DomTagType.division;

  @override
  shouldWidgetUpdate(Widget oldWidget) => false;

  @override
  createRenderElement(parent) => RouteRenderElement(this, parent);
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
| render element
|--------------------------------------------------------------------------
*/

/// Route render element.
///
class RouteRenderElement extends SingleChildRenderElement {
  RouteRenderElement(super.widget, super.parent);

  @override
  render({required widget}) => _description;
}
