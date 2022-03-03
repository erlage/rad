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

  final _nameToPathMap = <String, String>{};
  final _pathToRouteMap = <String, Route>{};

  late final Navigator _widget;
  late final BuildContext _context;

  // handles for delegated functionality

  void render(WidgetObject widgetObject) {
    _initState(widgetObject);

    var route = _pathToRouteMap[_currentPath] ?? _widget.routes.first;

    Framework.buildChildren(
      widgets: [route],
      parentContext: _context,
    );
  }

  void dispose() => Router.unRegister(_context);

  /// Initialize navigator state.
  ///
  /// Prepare routes, checks for duplicates.
  ///
  _initState(WidgetObject widgetObject) {
    //
    // set properties.
    //
    _context = widgetObject.context;
    _widget = widgetObject.widget as Navigator;

    // prepare routes

    for (var route in _widget.routes) {
      if (_nameToPathMap.containsKey(route.name) ||
          _pathToRouteMap.containsKey(route.path)) {
        throw "Please remove Duplicate routes from your Navigator."
            "Part of your route, name: '${route.name}' => path: '${route.path}', already exists";
      }

      _nameToPathMap[route.name] = route.path;
      _pathToRouteMap[route.path] = route;
    }

    // update current path from Router
    _currentPath = Router.getPath(_context.key);
  }
}
