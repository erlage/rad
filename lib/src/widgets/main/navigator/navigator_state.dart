import 'package:rad/rad.dart';
import 'package:rad/src/core/classes/framework.dart';
import 'package:rad/src/core/classes/router.dart';
import 'package:rad/src/core/objects/widget_object.dart';
import 'package:rad/src/widgets/main/navigator/navigator.dart';
import 'package:rad/src/widgets/main/navigator/route.dart';

/// Navigator's state object.
///
/// Handles the delegated functionality of a [Navigator] widget.
///
class NavigatorState {
  var _currentPath = '';

  String get currentPath => _currentPath;

  late final Navigator widget;
  late final BuildContext context;

  final nameToPathMap = <String, String>{};
  final pathToRouteMap = <String, Route>{};

  // handles for delegated functionality

  void render(WidgetObject widgetObject) {
    _initState(widgetObject);

    var route = pathToRouteMap[_currentPath] ?? widget.routes.first;

    Framework.buildChildren(
      widgets: [route],
      parentContext: context,
    );
  }

  void dispose() => Router.unRegister(context);

  /// Initialize navigator state.
  ///
  /// Prepare routes, checks for duplicates.
  ///
  _initState(WidgetObject widgetObject) {
    //
    // set properties.
    //
    context = widgetObject.context;
    widget = widgetObject.widget as Navigator;

    // prepare routes

    for (var route in widget.routes) {
      if (nameToPathMap.containsKey(route.name) ||
          pathToRouteMap.containsKey(route.path)) {
        throw "Please remove Duplicate routes from your Navigator."
            "Part of your route, name: '${route.name}' => path: '${route.path}', already exists";
      }

      nameToPathMap[route.name] = route.path;
      pathToRouteMap[route.path] = route;
    }

    // update current path from Router
    _currentPath = Router.getPath(this);
  }
}
