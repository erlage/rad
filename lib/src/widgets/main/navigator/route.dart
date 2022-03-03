import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/classes/framework.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/classes/build_context.dart';
import 'package:rad/src/core/classes/widget.dart';

class Route extends Widget {
  final String? key;

  final String path;
  final String name;
  final Widget page;

  const Route({
    this.key,
    String? path,
    required this.name,
    required this.page,
  }) : path = path ?? name;

  @override
  DomTag get tag => DomTag.div;

  @override
  String get type => (Route).toString();

  @override
  String get initialKey => key ?? System.keyNotSet;

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
    widgetObject.element.dataset[System.attrRoute] = path;

    Framework.buildChildren(
      widgets: [page],
      parentContext: context,
    );
  }

  @override
  update(widgetObject, updatedRenderObject) {
    updatedRenderObject as RouteRenderObject;

    Framework.updateChildren(
      widgets: [updatedRenderObject.page],
      parentContext: context,
    );
  }
}
