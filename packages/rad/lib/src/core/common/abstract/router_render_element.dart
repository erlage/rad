import 'dart:collection';

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/abstract/build_context.dart';
import 'package:rad/src/core/common/abstract/render_element.dart';
import 'package:rad/src/core/common/abstract/watchful_render_element.dart';
import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/functions.dart';
import 'package:rad/src/core/common/objects/cache.dart';
import 'package:rad/src/core/common/objects/dom_node_patch.dart';
import 'package:rad/src/core/services/router/open_history_entry.dart';
import 'package:rad/src/core/services/scheduler/tasks/aggregate_task.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_build_task.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_manage_task.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_update_dependent_task.dart';
import 'package:rad/src/core/services/services.dart';
import 'package:rad/src/core/services/services_resolver.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/route.dart';

/// Render Element for using Router's services.
///
/// API is unstable at the moment so this is gonna stay internal for some time.
///
@internal
abstract class RouterRenderElement extends WatchfulRenderElement
    with ServicesResolver {
  /// Routes that this Navigator instance handles.
  ///
  final List<Route> routes;

  /// List of names.
  ///
  final List<String> _nameList = [];

  /// List of routes.
  ///
  final List<String> _pathList = [];

  /// Route name to route path map.
  ///
  final _nameToPathMap = <String, String>{};

  /// Route path to route name map.
  ///
  final _pathToNameMap = <String, String>{};

  /// Path name to Route instance map.
  ///
  final _pathToRouteMap = <String, Route>{};

  final _openedRoutePathStack = <String>[];
  final _openedHistoryStack = <OpenHistoryEntry>[];

  var _currentName = '_';
  var _currentPath = '_';

  /// currentPage => {widgetKey => widgetContext}
  ///
  final dependents = <String, HashSet<RenderElement>>{};

  Services get _services => resolveServices(this);

  @override
  List<Widget> get widgetChildren => ccImmutableEmptyListOfWidgets;

  RouterRenderElement({
    required Widget widget,
    required this.routes,
    required RenderElement parent,
  }) : super(widget, parent);

  /// @nodoc
  @override
  @nonVirtual
  void init() {
    if (routes.isEmpty) {
      if (DEBUG_BUILD) {
        if (_services.debug.additionalChecks) {
          _services.debug.exception(
            'Router Elements must have at least one route.',
          );
        }
      }

      return;
    }

    for (final route in routes) {
      if (DEBUG_BUILD) {
        if (_services.debug.additionalChecks) {
          if (RegExp(r'^ *$').hasMatch(route.name)) {
            if (route.name.isEmpty) {
              return _services.debug.exception(
                "Navigator's Route's name can't be empty."
                '\n Route: ${route.name} -> ${route.path} is not allowed',
              );
            }

            return _services.debug.exception(
              "Navigator's Route's name cannot contain empty spaces."
              '\n Route: ${route.name} -> ${route.path} is not allowed',
            );
          }

          if (!RegExp(r'^[a-zA-Z0-9_\-]+$').hasMatch(route.path)) {
            if (route.path.isEmpty) {
              return _services.debug.exception(
                "Navigator's Route's path can't be empty."
                '\n Route: ${route.name} -> ${route.path} is not allowed',
              );
            }

            return _services.debug.exception(
              "Navigator's Route can contains only alphanumeric characters "
              ', underscores(_) and hyphens(-)'
              '\n Route: ${route.name} -> ${route.path} is not allowed',
            );
          }

          var isDuplicateRouteName = isRouteNameExists(name: route.name);
          var isDuplicateRoutePath = isRoutePathExists(path: route.path);

          if (isDuplicateRouteName) {
            return _services.debug.exception(
              'Please remove duplicate routes from your Routing widget. '
              "Route's name: '${route.name}' already exists",
            );
          }

          if (isDuplicateRoutePath) {
            return _services.debug.exception(
              'Please remove duplicate routes from your Routing widget. '
              "Route's path: '${route.path}' already exists",
            );
          }
        }
      }

      _nameList.add(route.name);
      _pathList.add(route.path);

      _nameToPathMap[route.name] = route.path;
      _pathToNameMap[route.path] = route.name;

      _pathToRouteMap[route.path] = route;
    }

    _services.router.register(this);
  }

  @mustCallSuper
  @override
  render({required widget}) => const DomNodePatch(
        attributes: {
          Attributes.className: Constants.classRouterElement,
        },
      );

  @mustCallSuper
  @override
  afterMount() {
    if (routes.isEmpty) {
      return;
    }

    willInit();

    var currentPath = _services.router.getCurrentPath(this);

    var needsReplacement = currentPath.isEmpty;
    if (needsReplacement) {
      currentPath = _pathList.first;
    }

    if (needsReplacement && currentPath.isNotEmpty) {
      if (DEBUG_BUILD) {
        if (_services.debug.routerLogs) {
          print('$this: Push replacement: $currentPath');
        }
      }

      _services.router.pushReplacement(
        path: currentPath,
        values: {},
        routerElement: this,
      );
    }

    openPath(path: currentPath, updateHistory: false);

    didInit();
  }

  @override
  update({
    required updateType,
    required oldWidget,
    required newWidget,
  }) {
    _services.scheduler.addTask(
      WidgetsManageTask(
        parentRenderElement: this,
        flagIterateInReverseOrder: true,
        widgetActionCallback: (widgetObject) {
          var widget = widgetObject.widget;

          if (widget is Route) {
            var pathName = widget.path;

            if (getCurrentRoutePath() == pathName) {
              return [WidgetAction.updateWidget];
            }
          }

          return [];
        },
      ),
    );

    return null;
  }

  /// @nodoc
  @nonVirtual
  @override
  void afterUnMount() {
    _services.router.unRegister(this);
  }

  /*
  |--------------------------------------------------------------------------
  | methods that concrete router elements can use
  |--------------------------------------------------------------------------
  */

  @nonVirtual
  List<String> getPathList() => _pathList;

  @nonVirtual
  List<String> getNameList() => _nameList;

  // @nonVirtual
  String getCurrentRouteName() => _currentName;

  @nonVirtual
  String getCurrentRoutePath() => _currentPath;

  @nonVirtual
  Services getServices() => _services;

  @nonVirtual
  bool isRouteNameExists({required String name}) {
    return _nameToPathMap.containsKey(name);
  }

  @nonVirtual
  bool isRoutePathExists({required String path}) {
    return _pathToNameMap.containsKey(path);
  }

  @nonVirtual
  bool isRoutePathInOpenedStack({required String path}) {
    return _openedRoutePathStack.contains(path);
  }

  @nonVirtual
  String getPathFromName({required String name}) {
    if (DEBUG_BUILD) {
      if (!_nameToPathMap.containsKey(name)) {
        throw Exception("Router: Route with name: '$name' is not declared");
      }
    }

    return _nameToPathMap[name]!;
  }

  @nonVirtual
  String getNameFromPath({required String path}) {
    if (DEBUG_BUILD) {
      if (!_pathToNameMap.containsKey(path)) {
        throw Exception("Router: Route with path: '$path' is not declared");
      }
    }

    return _pathToNameMap[path]!;
  }

  @nonVirtual
  Route getRouteFromPath({required String path}) {
    assert(
      _pathToRouteMap.containsKey(path),
      'Router has gone wild',
    );

    return _pathToRouteMap[path]!;
  }

  @nonVirtual
  void addDependent(BuildContext dependentContext) {
    dependentContext as RenderElement;

    var dependentsOnCurrentRouteName = dependents[getCurrentRoutePath()];

    if (null == dependentsOnCurrentRouteName) {
      dependents[getCurrentRoutePath()] = HashSet()..add(dependentContext);

      return;
    }

    dependentsOnCurrentRouteName.add(dependentContext);
  }

  /// Open path on router.
  ///
  @nonVirtual
  void openPath({
    required String path,
    Map<String, String> values = const {},
    bool updateHistory = true,
  }) {
    // if already on same page
    if (_openedHistoryStack.isNotEmpty) {
      var lastOpened = _openedHistoryStack.last;

      if (lastOpened.path == path) {
        if (fnIsKeyValueMapEqual(lastOpened.values, values)) {
          return;
        }
      }
    }

    // check if a route with given path exists
    if (!isRoutePathExists(path: path)) {
      if (DEBUG_BUILD) {
        _services.debug.exception(
          "Navigator: Route with path: '$path' is not declared.",
        );
      }

      return;
    }

    // callbacks

    frameworkUpdateCurrentRoutePath(path);

    // update global state

    if (updateHistory) {
      if (DEBUG_BUILD) {
        if (_services.debug.routerLogs) {
          print('$this: Push entry: ${getNameFromPath(path: path)} => $path');
        }
      }

      _services.router.pushEntry(
        path: path,
        values: values,
        routerElement: this,
        updateHistory: updateHistory,
      );
    }

    _openedHistoryStack.add(OpenHistoryEntry(path, values));

    // if route is already in stack, bring it to the top of stack

    if (isRoutePathInOpenedStack(path: path)) {
      _services.scheduler.addTask(
        WidgetsManageTask(
          parentRenderElement: this,
          flagIterateInReverseOrder: true,
          widgetActionCallback: (widgetObject) {
            var widget = widgetObject.widget;

            if (widget is Route) {
              var routePath = widget.path;

              if (path == routePath) {
                return [WidgetAction.showWidget];
              }
            }

            return [WidgetAction.hideWidget];
          },
          afterTaskCallback: frameworkUpdateProcedure,
        ),
      );
    } else {
      //
      // else build the route

      var route = getRouteFromPath(path: path);
      _openedRoutePathStack.add(path);

      // hide all existing widgets

      _services.scheduler.addTask(
        AggregateTask(
          tasksToProcess: [
            WidgetsManageTask(
              parentRenderElement: this,
              flagIterateInReverseOrder: true,
              widgetActionCallback: (widgetObject) {
                return [WidgetAction.hideWidget];
              },
            ),
            WidgetsBuildTask(
              widgets: [route],
              parentRenderElement: this,
              flagCleanParentContents: 1 == _openedHistoryStack.length,
            ),
          ],
        ),
      );
    }
  }

  @nonVirtual
  void openPreviousPath() {
    if (canOpenPreviousPath()) {
      _openedHistoryStack.removeLast();

      var routePath = _openedHistoryStack.last.path;

      frameworkUpdateCurrentRoutePath(routePath);

      _services.router.dispatchBackAction();
    } else {
      if (DEBUG_BUILD) {
        _services.debug.exception('Router: No previous route to go back.');
      }
    }
  }

  @nonVirtual
  bool canOpenPreviousPath() => _openedHistoryStack.length > 1;

  /// Get value.
  ///
  @nonVirtual
  String getValue(String segment) => _services.router.getValue(this, segment);

  /*
  |--------------------------------------------------------------------------
  | lifecycle hooks
  |--------------------------------------------------------------------------
  */

  /// Called when router element is about to initialized.
  ///
  void willInit() {}

  /// Called when router element is initialized.
  ///
  void didInit() {}

  /// Called by router service when it opens a route.
  ///
  void didChangedPath({
    required String previousPath,
    required String currentPath,
  });

  /*
  |--------------------------------------------------------------------------
  | framework reserved api
  |--------------------------------------------------------------------------
  */

  /// @nodoc
  @nonVirtual
  @internal
  @protected
  void frameworkUpdateCurrentRoutePath(String path) {
    var previousPath = _currentPath;

    _currentPath = path;
    _currentName = getNameFromPath(path: path);

    didChangedPath(
      previousPath: previousPath,
      currentPath: getCurrentRoutePath(),
    );
  }

  /// @nodoc
  @nonVirtual
  @internal
  @protected
  void frameworkUpdateProcedure() {
    var dependentsOnCurrentPage = dependents[getCurrentRoutePath()];

    if (null != dependentsOnCurrentPage) {
      for (final dependant in dependentsOnCurrentPage) {
        frameworkServices.scheduler.addTask(
          WidgetsUpdateDependentTask(dependentRenderElement: dependant),
        );
      }
    }
  }

  /// Framework fires this when parent route changes.
  ///
  /// @nodoc
  @nonVirtual
  @internal
  void frameworkOnParentPathChange(String path) {
    var routePath = _services.router.getCurrentPath(this);

    if (routePath != getCurrentRoutePath()) {
      if (DEBUG_BUILD) {
        if (_services.debug.routerLogs) {
          print('$this: Push replacement: $routePath');
        }
      }

      _services.router.pushReplacement(
        path: getCurrentRoutePath(),
        values: {},
        routerElement: this,
      );
    }
  }
}
