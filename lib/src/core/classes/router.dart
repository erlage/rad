import 'dart:html';

import 'package:rad/src/core/classes/debug.dart';
import 'package:rad/src/core/classes/framework.dart';
import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/objects/router/navigator_route_object.dart';
import 'package:rad/src/core/objects/router/router_stack.dart';
import 'package:rad/src/core/objects/router/router_stack_entry.dart';
import 'package:rad/src/widgets/navigator.dart';
import 'package:rad/src/widgets/navigator/navigator_state.dart';
import 'package:rad/src/widgets/route.dart';

class Router {
  static var _isInit = false;
  static late final String _routingPath;

  static final _initialLocation = window.location.href;

  /// Path list
  ///
  static final _currentSegments = <String>[];

  /// Registered navigators.
  ///
  /// navigator id: navigator route object
  ///
  static final _routeObjects = <String, NavigatorRouteObject>{};

  /// Registered state objects.
  ///
  /// navigator id: navigator state
  ///
  static final _stateObjects = <String, NavigatorState>{};

  /// Router stack.
  ///
  /// For keeping track of page push/pop
  ///
  static final _routerStack = RouterStack();

  static init(String routingPath) {
    if (_isInit) {
      throw "Router aleady initialized.";
    }

    if (Debug.routerLogs) {
      print("Router: onPopState: initialized at: $_initialLocation");
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

    if (_routeObjects.containsKey(context.id)) throw System.coreError;

    _register(context, routes);
  }

  /// Register navigator's state.
  ///
  /// As state objects are created after Navigator routes are registered,
  /// state has to register itself using this method.
  ///
  static void registerState(BuildContext context, NavigatorState state) {
    if (_stateObjects.containsKey(context.id)) {
      throw System.coreError;
    }

    _stateObjects[context.id] = state;
  }

  static void unRegister(BuildContext context) {
    _routeObjects.remove(context.id);

    _routerStack.remove(context.id);

    _stateObjects.remove(context.id);
  }

  /// Push page entry.
  ///
  static void pushEntry({
    required String name,
    required String values,
    required String navigatorId,
    required bool updateHistory,
  }) {
    if (updateHistory) {
      var protectedSegments = _protectedSegments(navigatorId);

      var historyEntry = protectedSegments.join("/") + "/$name$values";

      window.history.pushState(null, '', historyEntry);

      _updateCurrentSegments();

      var routeObject = _routeObjects[navigatorId];
      var state = _stateObjects[navigatorId];
      var childRouteObject = routeObject?.child;

      if (null != childRouteObject && null != state) {
        if (state.currentRouteName == childRouteObject.segments.last) {
          var childState = _stateObjects[childRouteObject.context.id];

          childState?.onParentRouteChange(name);
        }
      }
    }

    var entry = RouterStackEntry(
      name: name,
      values: values,
      navigatorId: navigatorId,
      location: window.location.href,
    );

    _routerStack.push(entry);
  }

  /// Push page entry as replacement.
  ///
  /// This allows nested navigators to do initial linking.
  ///
  static void pushReplacement({
    required String name,
    required String values,
    required String navigatorId,
  }) {
    var currentLocation = window.location.href;

    _routerStack.entries.remove(currentLocation);

    var protectedSegments = _protectedSegments(navigatorId);

    var historyEntry = protectedSegments.join("/") + "/$name$values";

    window.history.replaceState(null, '', historyEntry);

    _updateCurrentSegments();

    var entry = RouterStackEntry(
      name: name,
      values: values,
      navigatorId: navigatorId,
      location: window.location.href,
    );

    _routerStack.push(entry);
  }

  /// Get current path based on Navigator's access.
  ///
  /// Returns empty string, if matches nothing. Navigators should display
  /// default page when [getPath] returns empty string.
  ///
  static String getPath(String navigatorId) {
    var stateObject = _stateObjects[navigatorId];

    if (null == stateObject) throw System.coreError;

    var segments = _accessibleSegments(navigatorId);

    var matchedPathSegment = '';

    for (var segment in segments) {
      if (stateObject.pathToRouteMap.containsKey(segment)) {
        matchedPathSegment = segment;

        break;
      }
    }

    if (Debug.routerLogs) {
      print(
        "Navigator(#$navigatorId) matched: '$matchedPathSegment' from '${segments.join("/")}'",
      );
    }

    return matchedPathSegment;
  }

  /// Get value following the provided segment in URL.
  ///
  static String getValue(String navigatorId, String segment) {
    var path = _accessibleSegments(navigatorId).join("/");

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
    window.addEventListener("popstate", _onPopState, false);

    _updateCurrentSegments();
  }

  static void _updateCurrentSegments() {
    _currentSegments.clear();

    _currentSegments.add(_routingPath);

    var path = window.location.pathname;

    if (null == path || _routingPath == path) {
      return;
    }

    _currentSegments.addAll(
      path.split('/')
        ..removeWhere(
          (sgmt) => sgmt == _routingPath || sgmt.trim().isEmpty,
        ),
    );
  }

  static _onPopState(Event event) {
    try {
      var location = window.location.href;

      if (Debug.routerLogs) {
        print("Router: onPopState: location: $location");
      }

      // find or manage user history entry

      var entry = _routerStack.get(location);

      // user is traversing passive history.

      if (null == entry) {
        //
        // passive history is 'state' that browser kept after user had left the site.
        // this is to allow user navigate between sites using back button.
        //
        // since at this point, our state is lost, our entries are lost too.
        // and reloading window will build the correct interface.

        if (Debug.routerLogs) {
          print("Router: onPopState: entry doesnt exists: $entry");
        }

        window.location.reload();

        // for active history, our implementation is ready, see below.

      } else {
        var routeObject = _routeObjects[entry.navigatorId]!;

        _ensureNavigatorIsVisible(routeObject);

        var navigatorState = _stateObjects[entry.navigatorId]!;

        // if navigator has page in active stack

        if (navigatorState.isPageStacked(name: entry.name)) {
          if (Debug.routerLogs) {
            print("Router: onPopState: open: ${entry.name}");
          }

          navigatorState.open(name: entry.name, updateHistory: false);
          //
        } else {
          if (Debug.routerLogs) {
            print("Router: onPopState: synthetic-open: ${entry.name}");
          }

          navigatorState.open(
            name: entry.name,
            values: entry.values,
            updateHistory: false,
          );
        }
      }
    } catch (e) {
      // reload window if anything goes wrong with dynamic management of history.

      window.location.reload();
    }
  }

  static void _ensureNavigatorIsVisible(NavigatorRouteObject routeObject) {
    var parent = routeObject.parent;

    if (null != parent) {
      _ensureNavigatorIsVisible(parent);

      var parentState = _stateObjects[parent.context.id];

      if (null != parentState) {
        var parentRouteNameToOpen = routeObject.segments.last;

        parentState.open(name: parentRouteNameToOpen, updateHistory: false);
      }
    }
  }

  static void _register(BuildContext context, List<Route> routes) {
    //
    // try finding a Navigator in ancestors
    //
    // we've to use context.parent here because navigators are required to register
    // themselves in onContextCreate hook but at the point when onContextCreate
    // hook is fired, context.id is not present in DOM.

    var parent = Framework.findAncestorOfType<Navigator>(context.parent);

    // if no Navigator in ancestors i.e we're dealing with a root navigator

    if (null == parent) {
      _routeObjects[context.id] = NavigatorRouteObject(
        context: context,
        routes: routes,
        segments: [_routingPath],
      );

      if (Debug.routerLogs) {
        print("Navigator Registered: #${context.id} at ${[_routingPath]}");
      }

      return;
    }

    // else it's nested navigator

    var parentState = (parent.renderObject as NavigatorRenderObject).state;

    var parentObject = _routeObjects[parent.context.id];

    if (null == parentObject) throw System.coreError;

    var segments = [...parentObject.segments, parentState.currentRouteName];

    // add route object for current navigator

    _routeObjects[context.id] = NavigatorRouteObject(
      context: context,
      routes: routes,
      segments: segments,
      parent: parentObject,
    );

    // recreate parent object with child reference

    _routeObjects[parent.context.id] = NavigatorRouteObject(
      context: parentObject.context,
      routes: parentObject.routes,
      segments: parentObject.segments,
      parent: parentObject.parent,
      child: _routeObjects[context.id],
    );

    if (Debug.routerLogs) {
      print("Navigator Registered: #${context.id} at $segments");
    }
  }

  /// Part of path(window.location.pathName) that navigator with
  /// [navigatorId] can access.
  ///
  static List<String> _accessibleSegments(String navigatorId) {
    var routeObject = _routeObjects[navigatorId];

    if (null == routeObject) throw System.coreError;

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

    var path = _currentSegments.join("/");

    var match = RegExp(matcher).firstMatch(path);

    if (null == match) return [];

    var group = match.group(1);

    if (null == group) return [];

    return group.split("/");
  }

  /// Part of path(window.location.pathName) that navigator with
  /// [navigatorId] can't change.
  ///
  /// Note that, navigator still can access **some parts** of protected
  /// segements using [_accessibleSegments]
  ///
  static List<String> _protectedSegments(String navigatorId) {
    var routeObject = _routeObjects[navigatorId];
    var stateObject = _stateObjects[navigatorId];

    if (null == routeObject) throw System.coreError;
    if (null == stateObject) throw System.coreError;

    // if root navigator, no segments are protected

    if (null == routeObject.parent) {
      return [];
    }

    // else find protected part

    var matcher = "";

    var matchRoutes = stateObject.nameToPathMap.values.join(r"|\/");

    if (routeObject.segments.length < 3) {
      matcher = r"(^\/+[\w\/]*" +
          routeObject.segments.last +
          r"[\w\/]*(?=\/" +
          matchRoutes +
          r"))";
    } else {
      matcher = r"(^\/+" +
          routeObject.segments[1] +
          r"[\w\/]*" +
          routeObject.segments.last +
          r"[\w\/]*(?=\/" +
          matchRoutes +
          r"))";
    }

    var path = _currentSegments.join("/");

    var match = RegExp(matcher).firstMatch(path);

    if (null == match) return _currentSegments;

    var group = match.group(1);

    if (null == group) return _currentSegments;

    return group.split("/");
  }
}
