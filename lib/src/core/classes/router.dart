import 'dart:html';

import 'package:rad/src/core/classes/debug.dart';
import 'package:rad/src/core/classes/framework.dart';
import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/objects/router/navigator_route_object.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/widgets/main/navigator/navigator.dart';
import 'package:rad/src/widgets/main/navigator/navigator_state.dart';
import 'package:rad/src/widgets/main/navigator/route.dart';

class Router {
  static var _isInit = false;
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

  static init(String routingPath) {
    if (_isInit) {
      throw "Router aleady initialized.";
    }

    _routingPath = routingPath;

    _initRouterState();

    _isInit = true;
  }

  /// Register Navigator's routes.
  ///
  /// Registration is mandatory if a Navigator want access to routing.
  ///
  static void registerRoutes(BuildContext context, List<Route> routes) {
    if (!_isInit) {
      throw "Router not initialized.";
    }

    if (_routeObjects.containsKey(context.key)) throw System.coreError;

    _register(context, routes);
  }

  /// Register navigator's state.
  ///
  /// As state objects are created after Navigator routes are registered,
  /// state has to register itself using this method.
  ///
  static void registerState(BuildContext context, NavigatorState state) {
    if (Debug.routerLogs) {
      print("Navigator State's Registeration request: #${context.key}");
    }

    if (_stateObjects.containsKey(context.key)) throw System.coreError;

    _stateObjects[context.key] = state;
  }

  static void unRegisterRoutes(BuildContext context) {
    _routeObjects.remove(context.key);
  }

  static void unRegisterState(BuildContext context) {
    _stateObjects.remove(context.key);
  }

  /// Get current path based on Navigator's access.
  ///
  /// Returns empty string, if matches nothing. Navigators should display
  /// default page when [getPath] returns empty string.
  ///
  static String getPath(String navigatorKey) {
    var stateObject = _stateObjects[navigatorKey];

    if (null == stateObject) throw System.coreError;

    var segments = _accessibleSegments(navigatorKey);

    var matchedPathSegment = '';

    for (var segment in segments) {
      if (stateObject.pathToRouteMap.containsKey(segment)) {
        matchedPathSegment = segment;

        break;
      }
    }

    if (Debug.routerLogs) {
      print("Navigator(#$navigatorKey) matched: '$matchedPathSegment'");
    }

    return matchedPathSegment;
  }

  /// Get value following the provided segment in URL.
  ///
  static String getValue(String navigatorKey, String segment) {
    var path = _accessibleSegments(navigatorKey).join("/");

    // try to find a value that's following the provided segment in path

    var match = RegExp(segment + r"\/+(\w+)").firstMatch(path);

    return (null == match) ? '' : match.group(1) ?? '';
  }

  /*
  |--------------------------------------------------------------------------
  | internals
  |--------------------------------------------------------------------------
  */

  static void _initRouterState() {
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
    //
    // try finding a Navigator in ancestors
    //
    // we've to use context.parent here because navigators are required to register
    // themselves in onContextCreate hook but at the point when onContextCreate
    // hook is fired, context.key is not present in DOM.

    var parent = Framework.findAncestorOfType<Navigator>(context.parent);

    // if no Navigator in ancestors i.e we're dealing with a root navigator

    if (null == parent) {
      _routeObjects[context.key] = NavigatorRouteObject(
        context: context,
        routes: routes,
        segments: [_routingPath],
      );

      if (Debug.routerLogs) {
        print("Navigator Registered: #${context.key} at ${[_routingPath]}");
      }

      return;
    }

    // else it's nested navigator

    var parentState = (parent.renderObject as NavigatorRenderObject).state;

    var parentObject = _routeObjects[parent.context.key];

    if (null == parentObject) throw System.coreError;

    var segments = [...parentObject.segments, parentState.currentPath];

    _routeObjects[context.key] = NavigatorRouteObject(
      context: context,
      routes: routes,
      segments: segments,
      parent: parentObject,
    );

    if (Debug.routerLogs) {
      print("Navigator Registered: #${context.key} at $segments");
    }
  }

  /// Part of path(window.location.pathName) that navigator with
  /// [navigatorKey] can access.
  ///
  static List<String> _accessibleSegments(String navigatorKey) {
    var routeObject = _routeObjects[navigatorKey];
    var stateObject = _stateObjects[navigatorKey];

    if (null == routeObject) throw System.coreError;
    if (null == stateObject) throw System.coreError;

    // if root navigator, all segments are available

    if (null == routeObject.parent) {
      return _currentSegments;
    }

    // else limit part of path that's visible to current navigator

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
