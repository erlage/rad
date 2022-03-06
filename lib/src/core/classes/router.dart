import 'dart:html';

import 'package:rad/src/core/classes/debug.dart';
import 'package:rad/src/core/classes/framework.dart';
import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/objects/router/navigator_route_object.dart';
import 'package:rad/src/core/objects/router/router_stack.dart';
import 'package:rad/src/core/objects/router/router_stack_entry.dart';
import 'package:rad/src/widgets/main/navigator/navigator.dart';
import 'package:rad/src/widgets/main/navigator/navigator_state.dart';
import 'package:rad/src/widgets/main/navigator/route.dart';

class Router {
  static var _isInit = false;
  static late final String _routingPath;

  static final _initialLocation = window.location.href;

  /// Tells that user will left site if they press back button once again.
  ///
  /// For handling [_onPopState]
  ///
  static var _flagUserIsLeaving = true;

  /// Path list: [window.location.path]
  ///
  static final _currentSegments = <String>[];

  /// Registered navigators.
  ///
  /// navigator key: navigator route object
  ///
  static final _routeObjects = <String, NavigatorRouteObject>{};

  /// Registered state objects.
  ///
  /// navigator key: navigator state
  ///
  static final _stateObjects = <String, NavigatorState>{};

  /// Router stack.
  ///
  /// For keeping track of page push/pop
  ///
  static late final RouterStack _routerStack;

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

    if (_routeObjects.containsKey(context.key)) throw System.coreError;

    _register(context, routes);
  }

  /// Register navigator's state.
  ///
  /// As state objects are created after Navigator routes are registered,
  /// state has to register itself using this method.
  ///
  static void registerState(BuildContext context, NavigatorState state) {
    if (_stateObjects.containsKey(context.key)) {
      throw System.coreError;
    }

    _stateObjects[context.key] = state;
  }

  static void unRegister(BuildContext context) {
    _routeObjects.remove(context.key);

    _routerStack.remove(context.key);

    _stateObjects.remove(context.key);
  }

  /// Push page entry.
  ///
  static void pushEntry({
    required String name,
    required String values,
    required String navigatorKey,
    required bool updateHistory,
  }) {
    if (updateHistory) {
      var protectedSegments = _protectedSegments(navigatorKey);

      var historyEntry = protectedSegments.join("/") + "/$name$values";

      window.history.pushState(null, '', historyEntry);

      _updateCurrentSegments();
    }

    var entry = RouterStackEntry(
      name: name,
      values: values,
      navigatorKey: navigatorKey,
      location: window.location.href,
    );

    _routerStack.push(entry);

    _flagUserIsLeaving = false;
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
      print(
        "Navigator(#$navigatorKey) matched: '$matchedPathSegment' from '${segments.join("/")}'",
      );
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
    _routerStack = RouterStack();

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

      //  if user is back on homepage

      if (location == _initialLocation) {
        //
        // user either left or they had pressed back button
        // after reload
        //
        if (_flagUserIsLeaving) {
          window.location.reload();

          return;
        }

        // flag that user will left site if they press back button once again.

        if (Debug.routerLogs) {
          print("Router: onPopState: flagged for leave: $_initialLocation");
        }

        _flagUserIsLeaving = true;

        // rollback interface to initial page
        // to go to initial page, clean page stacks of all navigators while keeping one
        // entry at top.

        for (var entry in _routerStack.entries.values.toList().reversed) {
          var navigatorState = _stateObjects[entry.navigatorKey];

          if (null != navigatorState) {
            while (navigatorState.canPop()) {
              navigatorState.pop();
            }
          }
        }

        return;
      }

      // else we're not at initial page.
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
        var navigatorState = _stateObjects[entry.navigatorKey]!;

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

    var segments = [...parentObject.segments, parentState.currentName];

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
  /// [navigatorKey] can't change.
  ///
  /// Note that, navigator still can access **some parts** of protected
  /// segements using [_accessibleSegments]
  ///
  static List<String> _protectedSegments(String navigatorKey) {
    var routeObject = _routeObjects[navigatorKey];
    var stateObject = _stateObjects[navigatorKey];

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
