import 'dart:html';

import 'package:rad/src/core/classes/framework.dart';
import 'package:rad/src/core/objects/navigator_path.dart';
import 'package:rad/src/core/structures/build_context.dart';
import 'package:rad/src/widgets/main/navigator/navigator.dart';

class Router {
  static var _isInit = false;
  static var _debugMode = false;
  static late final String _routingPath;

  static var _currentPathSegments = <String>[];

  /// Registered navigators.
  ///
  static final Map<String, NavigatorPath> _navigators = {};

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

  /// Register Navigator.
  ///
  /// Registration is mandatory if a Navigator want access to routing.
  /// Navigator's context is enough to register a Navigator.
  ///
  static void register(BuildContext context) {
    if (_debugMode) {
      print("Navigator Registeration request: #${context.key}");
    }

    if (!_isInit) {
      throw "Router not initialized.";
    }

    // if already registered
    if (_navigators.containsKey(context.key)) {
      throw "Framework has gone wild.";
    }

    _register(context);
  }

  /// UnRegister a Navigator.
  ///
  static void unRegister(BuildContext context) {
    // remove from registry
    _navigators.remove(context.key);

    //
  }

  /// Get current path based on Navigator's access.
  ///
  /// Returns empty string, if matches nothing. Navigators should display
  /// default page when [getPath] returns empty string.
  ///
  static String getPath(String navigatorKey) {
    var navigatorPath = _navigators[navigatorKey];

    if (null == navigatorPath) {
      throw "Navigator you trying to look-up must register itself before accessing Router.";
    }

    var systemPathList = [..._currentPathSegments];
    var navigatorPathList = [...navigatorPath.segments];

    for (var segment in _currentPathSegments) {
      if (navigatorPathList.contains(segment)) {
        systemPathList.removeAt(systemPathList.indexOf(segment));
        navigatorPathList.removeAt(navigatorPathList.indexOf(segment));
      }

      return segment;
    }

    return '';
  }

  // internals

  static void _initRouterState() {
    // get current path from window object
    var path = window.location.pathname;

    if (null == path || _routingPath == path) {
      _currentPathSegments = [];

      return;
    }

    _currentPathSegments = path.split('/')
      ..removeWhere(
          (sgmt) => sgmt == '/' || sgmt == _routingPath || sgmt.trim().isEmpty);
  }

  static void _register(BuildContext context) {
    //
    // we've to use context.parent here because navigators are required to register
    // themselves in onContextCreate hook but at the point when onContextCreate
    // hook is fired, context.key is not present in DOM.
    //
    // try to find a parent Navigator
    var parent = Framework.findAncestorOfType<Navigator>(context.parent);

    // if its a navigator
    if (null == parent) {
      _navigators[context.key] = NavigatorPath([_routingPath]);

      if (_debugMode) {
        print("Navigator Registered: #${context.key} at $_routingPath");
      }

      return;
    }

    // else its a nested navigator

    var parentPath = _navigators[parent.context.key];

    if (null == parentPath) {
      throw "Framework has gone wild.";
    }

    var parentState = (parent.renderObject as NavigatorRenderObject).state;

    var segments = [...parentPath.segments, parentState.currentPath];

    _navigators[context.key] = NavigatorPath(segments);

    if (_debugMode) {
      print("Navigator Registered: #${context.key} at ${segments.join("/")}");
    }
  }
}
