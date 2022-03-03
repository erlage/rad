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

  /// Current path points to the Route's path. Route, that's currently on top of
  /// Navigator stack.
  ///
  String get currentPath => _currentPath;

  late final Navigator widget;
  late final BuildContext context;

  final nameToPathMap = <String, String>{};
  final pathToRouteMap = <String, Route>{};

  /*
  |--------------------------------------------------------------------------
  | api
  |--------------------------------------------------------------------------
  */

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
  String getValue(String segment) => Router.getValue(this, segment);

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
    /*
    |--------------------------------------------------------------------------
    | initialize navigator state
    |--------------------------------------------------------------------------
    */

    _initState(widgetObject);

    /*
    |--------------------------------------------------------------------------
    | get matching path from Router
    |--------------------------------------------------------------------------
    */

    _currentPath = Router.getPath(this);

    /*
    |--------------------------------------------------------------------------
    | prepare route. if not matched select first as default
    |--------------------------------------------------------------------------
    */

    var route = pathToRouteMap[_currentPath] ?? widget.routes.first;

    /*
    |--------------------------------------------------------------------------
    | build selected route
    |--------------------------------------------------------------------------
    */

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
  void dispose() {
    /*
    |--------------------------------------------------------------------------
    | unregister navigator routes
    |--------------------------------------------------------------------------
    */

    Router.unRegisterRoutes(context);

    /*
    |--------------------------------------------------------------------------
    | unregister navigator state
    |--------------------------------------------------------------------------
    */

    Router.unRegisterState(context);
  }

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
    /*
    |--------------------------------------------------------------------------
    | initialize properties
    |--------------------------------------------------------------------------
    */

    context = widgetObject.context;

    widget = widgetObject.widget as Navigator;

    /*
    |--------------------------------------------------------------------------
    | prepare routes
    |--------------------------------------------------------------------------
    */

    for (var route in widget.routes) {
      /*
      |--------------------------------------------------------------------------
      | check for duplicates
      |--------------------------------------------------------------------------
      */

      if (nameToPathMap.containsKey(route.name) ||
          pathToRouteMap.containsKey(route.path)) {
        throw "Please remove Duplicate routes from your Navigator."
            "Part of your route, name: '${route.name}' => path: '${route.path}', already exists";
      }

      /*
      |--------------------------------------------------------------------------
      | populate jump maps
      |--------------------------------------------------------------------------
      */

      nameToPathMap[route.name] = route.path;

      pathToRouteMap[route.path] = route;
    }

    /*
    |--------------------------------------------------------------------------
    | register navigator state.
    |
    | so that router can use above jump tables and speed up route selection.
    |--------------------------------------------------------------------------
    */

    Router.registerState(context, this);
  }
}
