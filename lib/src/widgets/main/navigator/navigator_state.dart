import 'package:rad/rad.dart';
import 'package:rad/src/core/classes/debug.dart';
import 'package:rad/src/core/classes/framework.dart';
import 'package:rad/src/core/classes/router.dart';
import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/objects/widget_object.dart';
import 'package:rad/src/widgets/main/navigator/navigator.dart';
import 'package:rad/src/widgets/main/navigator/route.dart';

/// Navigator's state object.
///
/// Handles the delegated functionality of a [Navigator] widget.
///
class NavigatorState {
  var _currentPath = '';

  /// Current path points to the Route's path. Route, that's currently on top of
  /// Navigator stack.
  ///
  String get currentPath => _currentPath;

  late final Navigator widget;
  late final BuildContext context;

  final List<String> _pushStack = [];

  final nameToPathMap = <String, String>{};
  final pathToRouteMap = <String, Route>{};

  /*
  |--------------------------------------------------------------------------
  | api
  |--------------------------------------------------------------------------
  */

  /// Push a page on Navigator's stack.
  ///
  /// Will throw exception if Navigator doesn't have a route with the provided name.
  ///
  /// If [name] is prefixed with a forward slash '/', and if current navigator doesn't have
  /// a matching named route, then it'll delegate push to a parent navigator(if exists). If
  /// there are no navigator in ancestors, it'll throw an exception.
  ///
  void push({
    required String name,
    String? values,
  }) {
    var traverseAncestors = name.startsWith("../");

    // clean traversal flag

    var cleanedName = traverseAncestors ? name.substring(3) : name;

    // if current navigator doesn't have a matching '$name' route

    if (!nameToPathMap.containsKey(cleanedName)) {
      if (!traverseAncestors) {
        throw "Navigator: Named routes that are not registered in Navigator's routes are not allowed."
            "If you're trying to push to a parent navigator, add prefix '../' to name of the route. "
            "e.g Navgator.of(context).push(name: '../home')."
            "It'll first tries a push to current navigator, if it doesn't find a matching route, "
            "then it'll try push to a parent navigator and so on. If there are no navigators in ancestors, "
            "then it'll throw an exception";
      } else {
        // push to parent navigator.

        NavigatorState parent;

        try {
          parent = Navigator.of(context);
        } catch (_) {
          throw "Route named '$cleanedName' not defined. Make sure you've declared a named route '$cleanedName' in Navigator's routes.";
        }

        parent.push(name: name, values: values);

        return;
      }
    }

    // push a new entry

    _changeCurrentPath(cleanedName);

    _pushEntry(cleanedName, values);

    // get route details

    var page = pathToRouteMap[nameToPathMap[cleanedName]];

    if (null == page) throw System.coreError;

    // build

    Framework.buildChildren(
      widgets: [page],
      parentContext: context,
      flagCleanParentContents: false,
    );
  }

  /// Get value from URL following the provided segment.
  ///
  /// for example,
  ///
  /// if browser URI is pointing to: https://domain.com/profile/123/posts
  ///
  /// ```dart
  /// Navigator.of(context).getValue('profile'); //-> 123
  /// ```
  ///
  /// Please note that calling getValue on a Navigator who's context is
  /// enclosed on posts pages can only access values past its registration
  /// path.
  ///
  /// for example, if a Navigator is registered posts page it can
  /// only access parts of URI after posts pages.
  ///
  /// In `domain.com/profile/123/posts/456/edit/789`
  /// allowed part is `/posts/456/edit/789`
  ///
  /// ```dart
  /// Navigator.of(context).getValue('posts') // -> '456'
  /// Navigator.of(context).getValue('edit') // -> '789'
  ///
  /// // accessing protected values:
  /// Navigator.of(context).getValue('profile') // -> '', empty,
  /// // because current navigator is registered on posts page
  /// ```
  ///
  String getValue(String segment) => Router.getValue(context.key, segment);

  /*
  |--------------------------------------------------------------------------
  | delegated functionality handlers
  |--------------------------------------------------------------------------
  */

  /// Rendering handle.
  ///
  /// Framework will call this when required.
  /// Calling this mannually will results in undesired behaviour.
  ///
  void render(WidgetObject widgetObject) {
    _initState(widgetObject);

    // get matching path from Router

    _currentPath = Router.getPath(context.key);

    // prepare route. if not matched select first as default

    var route = pathToRouteMap[_currentPath] ?? widget.routes.first;

    // build selected route

    Framework.buildChildren(
      widgets: [route],
      parentContext: context,
    );
  }

  /// Dispose handle.
  ///
  /// Framework will call this when required.
  /// Calling this mannually will results in undesired behaviour.
  ///
  void dispose() => Router.unRegister(context);

  /*
  |--------------------------------------------------------------------------
  | internals
  |--------------------------------------------------------------------------
  */

  /// Initialize navigator state.
  ///
  /// Prepare routes, checks for duplicates.
  ///
  _initState(WidgetObject widgetObject) {
    context = widgetObject.context;
    widget = widgetObject.widget as Navigator;

    for (var route in widget.routes) {
      if (Debug.developmentMode) {
        var isDuplicate = nameToPathMap.containsKey(route.name) ||
            pathToRouteMap.containsKey(route.path);

        if (isDuplicate) {
          throw "Please remove Duplicate routes from your Navigator."
              "Part of your route, name: '${route.name}' => path: '${route.path}', already exists";
        }
      }

      nameToPathMap[route.name] = route.path;

      pathToRouteMap[route.path] = route;
    }

    // register navigator state.
    // so that router can use above jump tables and speed up route selection.

    Router.registerState(context, this);
  }

  void _changeCurrentPath(String name) {
    _currentPath = name;
  }

  void _pushEntry(String name, String? values) {
    _pushStack.add(name);

    Router.pushEntry(context.key, name, values);
  }
}
