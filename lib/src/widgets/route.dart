import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/classes/framework.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/navigator.dart';

/// Route is a [Navigator] specific widget.
///
/// A [Route] act as a wrapper for your page contents. Along with page,
/// it contains routing specific information that helps [Navigator] manage
/// this widget position in tree.
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
    String? id,
    String? path,
    required this.name,
    required this.page,
  })  : path = path ?? name,
        super(id);

  @override
  DomTag get tag => DomTag.div;

  @override
  String get type => "$Route";

  @override
  createRenderObject(context) {
    return RouteRenderObject(
      name: name,
      path: path,
      page: page,
      context: context,
    );
  }
}

class RouteRenderObject extends RenderObject {
  final String name;
  final String path;
  final Widget page;

  RouteRenderObject({
    required this.name,
    required this.path,
    required this.page,
    required BuildContext context,
  }) : super(context);

  @override
  render(widgetObject) {
    widgetObject.element.dataset[System.attrRouteName] = name;
    widgetObject.element.dataset[System.attrRoutePath] = path;

    Framework.buildChildren(
      widgets: [page],
      parentContext: context,
    );
  }

  @override
  update(
    updateType,
    widgetObject,
    covariant RouteRenderObject updatedRenderObject,
  ) {
    Framework.updateChildren(
      widgets: [updatedRenderObject.page],
      updateType: updateType,
      parentContext: context,
    );
  }
}
