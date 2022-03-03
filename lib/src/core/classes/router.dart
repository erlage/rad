import 'dart:html';

import 'package:rad/src/core/classes/framework.dart';
import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/objects/navigator_route_object.dart';
import 'package:rad/src/core/structures/build_context.dart';
import 'package:rad/src/widgets/main/navigator/navigator.dart';
import 'package:rad/src/widgets/main/navigator/navigator_state.dart';
import 'package:rad/src/widgets/main/navigator/route.dart';

class Router {
  static var _isInit = false;
  static var _debugMode = false;
  static late final String _routingPath;

  static var _currentSegments = <String>[];

  /// Registered navigators.
  ///
  /// navigator key: navigator route object
  ///
  static final Map<String, NavigatorRouteObject> _routeObjects = {};

  /// Registered state objects.
  ///
  /// navigator key: navigator state
  ///
  static final Map<String, NavigatorState> _stateObjects = {};

  /// Initialize Router.
  ///
  static init({
    required bool debugMode,
    required String routingPath,
  }) {
    if (_isInit) {
      throw "Router aleady initialized.";
    }

    _debugMode = debugMode;

    _routingPath = routingPath;

    _initRouterState();

    _isInit = true;
  }

  /// Register Navigator routes.
  ///
  /// Registration is mandatory if a Navigator want access to routing.
  ///
  static void registerRoutes(BuildContext context, List<Route> routes) {
    if (_debugMode) {
      print("Navigator Registeration request: #${context.key}");
    }

    if (!_isInit) {
      throw "Router not initialized.";
    }

    if (_routeObjects.containsKey(context.key)) throw System.coreError;

    _register(context, routes);
  }

  /// Register navigator's state
  ///
  static void registerState(BuildContext context, NavigatorState state) {
    if (_debugMode) {
      print("Navigator State's Registeration request: #${context.key}");
    }

    if (_stateObjects.containsKey(context.key)) throw System.coreError;

    _stateObjects[context.key] = state;
  }

  /// UnRegister a Navigator routes
  ///
  static void unRegisterRoutes(BuildContext context) {
    _routeObjects.remove(context.key);
    _stateObjects.remove(context.key);
  }

  /// UnRegister a Navigator state
  ///
  static void unRegisterState(BuildContext context) {
    _stateObjects.remove(context.key);
  }

  /// Get current path based on Navigator's access.
  ///
  /// Returns empty string, if matches nothing. Navigators should display
  /// default page when [getPath] returns empty string.
  ///
  static String getPath(NavigatorState state) {
    /*
    |--------------------------------------------------------------------------
    | get path segments that current navigator can access
    |--------------------------------------------------------------------------
    */

    var segments = _accessibleSegments(state.context.key);

    /*
    |--------------------------------------------------------------------------
    |  try finding a matching path segment
    |--------------------------------------------------------------------------
    */

    var matchedPathSegment = '';

    for (var segment in segments) {
      if (state.pathToRouteMap.containsKey(segment)) {
        matchedPathSegment = segment;

        break;
      }
    }

    if (_debugMode) {
      print("Navigator(#${state.context.key}) matched: '$matchedPathSegment'");
    }

    return matchedPathSegment;
  }

  /// Get value following the provided segment in URL.
  ///
  static String getValue(NavigatorState state, String segment) {
    /*
    |--------------------------------------------------------------------------
    | get accessible path
    |--------------------------------------------------------------------------
    */

    var path = _accessibleSegments(state.context.key).join("/");

    /*
    |--------------------------------------------------------------------------
    | try to find a value that's following the provided segment in path
    |--------------------------------------------------------------------------
    */

    var match = RegExp(segment + r"\/+(\w+)").firstMatch(path);

    return (null == match) ? '' : match.group(1) ?? '';
  }

  /*
  |--------------------------------------------------------------------------
  | internals
  |--------------------------------------------------------------------------
  */

  static void _initRouterState() {
    // get current path from window object
    var path = window.location.pathname;

    if (null == path || _routingPath == path) {
      _currentSegments = [];

      return;
    }

    _currentSegments = path.split('/')
      ..removeWhere(
        (sgmt) => sgmt == _routingPath || sgmt.trim().isEmpty,
      );
  }

  static void _register(BuildContext context, List<Route> routes) {
    /*
    |--------------------------------------------------------------------------
    | try finding a Navigator in ancestors
    |
    | we've to use context.parent here because navigators are required to register
    | themselves in onContextCreate hook but at the point when onContextCreate
    | hook is fired, context.key is not present in DOM.
    |--------------------------------------------------------------------------
    */

    var parent = Framework.findAncestorOfType<Navigator>(context.parent);

    /*
    |--------------------------------------------------------------------------
    | if no Navigator in ancestors i.e we're dealing with a root navigator
    |--------------------------------------------------------------------------
    */

    if (null == parent) {
      _routeObjects[context.key] = NavigatorRouteObject(
        routes: routes,
        segments: [_routingPath],
      );

      if (_debugMode) {
        print("Navigator Registered: #${context.key} at ${[_routingPath]}");
      }

      return;
    }

    /*
    |--------------------------------------------------------------------------
    | else its a nested navigator
    |--------------------------------------------------------------------------
    */

    var parentState = (parent.renderObject as NavigatorRenderObject).state;

    var parentObject = _routeObjects[parent.context.key];

    if (null == parentObject) throw System.coreError;

    var segments = [...parentObject.segments, parentState.currentPath];

    _routeObjects[context.key] = NavigatorRouteObject(
      routes: routes,
      segments: segments,
      parent: parentObject,
    );

    if (_debugMode) {
      print("Navigator Registered: #${context.key} at $segments");
    }
  }

  static List<String> _accessibleSegments(String navigatorKey) {
    /*
    |--------------------------------------------------------------------------
    | get registered route and state objects of navigator
    |--------------------------------------------------------------------------
    */

    var routeObject = _routeObjects[navigatorKey];
    var stateObject = _stateObjects[navigatorKey];

    if (null == routeObject) throw System.coreError;
    if (null == stateObject) throw System.coreError;

    /*
    |--------------------------------------------------------------------------
    | all segments are accessible, if it's a root navigator
    |--------------------------------------------------------------------------
    */

    if (null == routeObject.parent) {
      return _currentSegments;
    }

    /*
    |--------------------------------------------------------------------------
    | else if it's a nested navigator
    |--------------------------------------------------------------------------
    */

    var matcher = "";

    if (routeObject.segments.length < 3) {
      matcher = r"^\/+[\w\/]*(" + routeObject.segments.last + r"[\/\w]*)";
    } else {
      matcher = r"^\/+" +
          routeObject.segments[1] +
          r"[\w\/]*(" +
          routeObject.segments.last +
          r"[\/\w]*)";
    }

    var path = window.location.pathname ?? _currentSegments.join("/");

    var match = RegExp(matcher).firstMatch(path);

    if (null == match) return [];

    var group = match.group(1);

    if (null == group) return [];

    return group.split("/");
  }
}
