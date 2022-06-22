import 'dart:collection';

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/abstract/build_context.dart';
import 'package:rad/src/core/common/abstract/render_element.dart';
import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/functions.dart';
import 'package:rad/src/core/common/objects/cache.dart';
import 'package:rad/src/core/common/objects/dom_node_patch.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/services/router/open_history_entry.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_build_task.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_manage_task.dart';
import 'package:rad/src/core/services/scheduler/tasks/widgets_update_dependent_task.dart';
import 'package:rad/src/core/services/services.dart';
import 'package:rad/src/core/services/services_registry.dart';
import 'package:rad/src/core/services/services_resolver.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/async_route.dart';
import 'package:rad/src/widgets/route.dart';
import 'package:rad/src/widgets/stateful_widget.dart';

/// Navigator widget.
///
/// Rad comes with a powerful Navigator widget that carries out three big tasks
/// for you:
///
/// - Routing
/// - Deep linking
/// - Single page experience (no page reloads when user hit forward/back
/// buttons)
///
/// ![Deep linking and Single page experience in action](https://github.com/erlage/rad/raw/main/example/routing_example/routing.gif)
///
/// And most importantly, all three tasks are carried out without any special
/// configuration or management from developer side. That is, Framework will
/// automatically deep link your Navigators, and route requests to the correct
/// ones no matter how deeply nested your Navigators are.
///
/// Let's talk about Navigator's syntax:
///
/// ```dart
/// Navigator(
///
///     // required
///
///     routes: [
///         ...
///     ],
///
///
///     // both are optional
///
///     onInit: (NavigatorState state) {
///
///     }
///
///     onRouteChange: (String name) {
///
///     }
/// )
/// ```
///
/// ### routes:[]
///
/// This property takes list of Routes. What is a Route? in simplified view, a
/// Route consists of two things,
///
/// 1. Name of the route e.g 'home', 'settings'
///
/// 2. Contents to show on route e.g some widget
///
/// To declare a route, there's actually a `Route` widget which simply wraps
/// both parts of route into a single widget that Navigator can manage.
///
/// ```dart
/// routes: [
///
///     Route(name: "home", page: HomePage()),
///
///     Route(name: "edit", page: SomeOtherWidget())
///
///     ...
/// ]
/// ```
/// Above, we've defined two routes, home and edit.
///
/// ### Navigator basic Understanding
///
/// Since Navigator's route is basically a widget that have a name attached to
/// it, those routes will be treated as child widgets of Navigator just like
/// Span can have its childs. Difference being, Navigator's childs(Route
/// widgets) are built in a lazy fashion(only when requested). This also means
/// that Navigator do not stack duplicate pages. All Route widgets are built
/// only once. That is when you open a route, if route widget doesn't exists,
/// it'll create it else it'll use the Route widget that's already built.
///
/// ### NavigatorState
///
/// Navigator widget creates a state object. State object provides methods which
/// you can use to jump between routes, open routes and things like that. To
/// access a Navigator's state object, there are two methods:
///
/// 1. If widget from where you accessing NavigatorState is in child tree of
/// Navigator then use `Navigator.of(context)`. This method will return
/// NavigatorState of the nearest ancestor Navigator from the given
/// `BuildContext`.
///
/// 2. For accessing state in parent widget of Navigator, use `onInit` hook of
/// Navigator:
///     ```dart
///     class SomeWidget extends StatelessWidget
///     {
///         @override
///         build(context)
///         {
///             return Navigator(
///                 onInit: _onInit,
///                 ...
///             )
///         }
///
///         _onInit(NavigatorState state)
///         {
///             // do something with state
///         }
///     }
///     ```
///
/// ### onRouteChange hook:
///
/// This hooks gets called when Navigator opens a route. This allows Navigator's
/// parent to do something when Navigator that it's enclosing has changed. for
/// example, you could've a header and you can change active tab when
/// Navigator's route has changed.
///
/// ```dart
/// Navigator(
///     onRouteChange: (name) => print("changed to $name");
///     ...
/// );
/// ```
///
/// ### Jumping to a Route
///
/// To go to a route, use `open` method of Navigator state. We could've named
/// it `push` but `open` conveys what exactly Navigator do when you jump to a
/// route. When you call `open`, Navigator will build route widget if it's not
/// already created. Once ready, it'll bring it to the top simply by hiding all
/// other Route widgets that this Navigator is managing.
///
/// ```dart
/// Navigator.of(context).open(name: "home");
/// ```
///
/// ### Going back
///
/// Going back means, opening the Route that was closed previously.
///
/// ```dart
///
/// Navigator.of(context).open(name: "home")
/// Navigator.of(context).open(name: "profile")
/// Navigator.of(context).open(name: "home")
///
/// Navigator.of(context).back() // ->  open profile
/// Navigator.of(context).back() // ->  open home
/// Navigator.of(context).back() // ->  error, no previous route!
///
/// // helper method to prevent above case:
///
/// Navigator.of(context).canGoBack() // ->  false, since no previous route
///
/// ```
///
/// ### Passing values between routes
///
/// Values can be passed to a route while opening that route:
///
/// ```dart
/// Navigator.of(context).open(name: "home", values: {"id": "123"});
///
/// ```
///
/// Then on homepage, value can be accessed using `getValue`:
///
/// ```dart
/// var id = Navigator.of(context).getValue("id");
/// // "123"
/// ```
///
/// ### Passing multiple values:
///
/// ```dart
/// Navigator.of(context).open(
///   name: "home", values: {"id": "123", "username" : "adamback"}
/// );
/// ```
///
/// On homepage,
///
/// ```dart
/// var id = Navigator.of(context).getValue("id"); // -> "123"
/// var username = Navigator.of(context).getValue("username"); // -> "adamback"
/// ```
///
/// Cool thing about Navigator is that values passed to a route will presist
/// during browser reloads. If you've pushed some values while opening a route,
/// those will presist in browser history too.
///
/// ## Mangaging state in Routes:
///
/// Since Navigator do not duplicate pages, you don't have to parameterize
/// your page content, instead pass values on `open`:
///
/// ```dart
/// // rather than doing this
/// Route(name: "profile", page: Profile(id: 123));
///
/// // do this
/// Route(name: "profile", page: Profile());
///
/// // and when opening profile route
/// Navigator.of(context).open(name: "profile", values: {"id": "123"});
///
/// // on profile page
/// var id = Navigator.of(context).getValue("id");
/// ```
///
/// But remember since routes are built only once, you've to re-initialize state
/// in your `ProfilePage` widget when `id` changes. One way is to make your
/// `ProfilePage` a [StatefulWidget] and re-initialize state in
/// [State.didChangeDependencies] when you see that `id` has changed.
///
/// Here's an example:
///
/// ```dart
/// class ProfilePageState ...
/// {
///   var _userId = '0';
///
///   @override
///   void initState() {
///     // intialize here, all things that don't depend on Navigator
///   }
///
///   @override
///   void didChangeDependencies()
///   {
///     // initialize here, all things that depends on Navigator
///
///     // this method gets called when your app do Navigator.open(name: 'profile')
///     // you can re-initialize page state here if page is opened with different values
///     // remember, you don't have to call setState inside this method as framework always
///     // call build method on this widget after calling this method.
///
///     var newValue = Navigator.of(context).getValue('id');
///
///     // if user id has changed(means your app has opened profile page with
///     // a different id value)
///     if(newValue != _userId) {
///       // change widget state
///       _userId = newValue;
///       // fetch user from server, or other things that depends
///       // on user id.
///     }
///   }
/// }
/// ```
///
/// See also:
///
///  * [Route], for synchronous routes.
///  * [AsyncRoute], for asynchronous routes.
///
class Navigator extends Widget {
  /// Routes that this Navigator instance handles.
  ///
  final List<Route> routes;

  /// Called when Navigator state is created.
  ///
  final NavigatorStateCallback? onInit;

  /// Called when Navigator's route changes.
  ///
  final NavigatorRouteChangeCallback? onRouteChange;

  const Navigator({
    required this.routes,
    this.onInit,
    this.onRouteChange,
    Key? key,
  }) : super(key: key);

  /// Navigator's state from the closest instance of this class
  /// that encloses the given context.
  ///
  static NavigatorState of(BuildContext context) {
    NavigatorRenderElement? parent;

    context.visitAncestorElements((element) {
      if (element is NavigatorRenderElement) {
        parent = element;

        return false;
      }

      return true;
    });

    var parentNavigator = parent;

    if (null == parentNavigator) {
      var debugService = ServicesRegistry.instance.getDebug(context);

      debugService.exception(
        'Navigator operation requested with a context that does not include '
        'a Navigator.\n'
        'The context used to push or pop routes from the Navigator must be '
        'that of a widget that is a descendant of a Navigator widget.',
      );

      /// Return dummy state if user has registered their own error handler
      /// in debug service, which may not throw exception on error above.
      ///
      return NavigatorState(const Navigator(routes: []));
    }

    parentNavigator.addDependent(context);

    return parentNavigator.state;
  }

  /*
  |--------------------------------------------------------------------------
  | widget internals
  |--------------------------------------------------------------------------
  */

  @nonVirtual
  @override
  String get widgetType => 'Navigator';

  // navigator creates a dom node(div) because it has multiple child nodes to
  // manage. another reason for having a corresponding dom node is that someone
  // might want to style navigator default area and they can simply override
  // css rules of navigator class if navigator has its own dom node

  @nonVirtual
  @override
  DomTagType get correspondingTag => DomTagType.division;

  @override
  bool shouldUpdateWidget(oldWidget) => true;

  /// Overriding this method on [Navigator] can result in unexpected
  /// behavior as [Navigator] build its childs from its state. If you don't
  /// want the [Navigator] to update its child widgets, override
  /// [shouldUpdateWidget] instead.
  ///
  @nonVirtual
  @override
  bool shouldUpdateWidgetChildren(oldWidget, shouldUpdateWidget) => false;

  @override
  createRenderElement(parent) => NavigatorRenderElement(this, parent);
}

/*
|--------------------------------------------------------------------------
| description(never changes for navigator widget)
|--------------------------------------------------------------------------
*/

const _description = DomNodePatch(
  attributes: {
    Attributes.classAttribute: Constants.classNavigator,
  },
);

/*
|--------------------------------------------------------------------------
| render object
|--------------------------------------------------------------------------
*/

class NavigatorRenderElement extends RenderElement {
  final NavigatorState state;

  /// currentPage => {widgetKey => widgetContext}
  ///
  final dependents = <String, HashSet<RenderElement>>{};

  NavigatorRenderElement(
    Navigator widget,
    RenderElement parent,
  )   : state = NavigatorState(widget),
        super(widget, parent);

  @override
  List<Widget> get childWidgets => ccImmutableEmptyListOfWidgets;

  @override
  render({required widget}) => _description;

  @override
  afterMount() {
    state
      ..frameworkBindContext(this)
      ..frameworkBindRenderElement(this)
      ..frameworkBindUpdateProcedure(updateProcedure)
      ..frameworkInitState()
      ..frameworkRender();
  }

  @override
  update({
    required updateType,
    required oldWidget,
    required newWidget,
  }) {
    state.frameworkUpdate(updateType);

    // Navigator's dom node's description never changes
    return null;
  }

  @override
  afterUnMount() => state.frameworkDispose();

  void addDependent(BuildContext dependentContext) {
    dependentContext as RenderElement;

    var dependentsOnCurrentPage = dependents[state.currentRouteName];

    if (null == dependentsOnCurrentPage) {
      dependents[state.currentRouteName] = HashSet()..add(dependentContext);

      return;
    }

    dependentsOnCurrentPage.add(dependentContext);
  }

  void updateProcedure() {
    var dependentsOnCurrentPage = dependents[state.currentRouteName];

    if (null != dependentsOnCurrentPage) {
      for (final dependant in dependentsOnCurrentPage) {
        services.scheduler.addTask(
          WidgetsUpdateDependentTask(dependentRenderElement: dependant),
        );
      }
    }
  }
}

/*
|--------------------------------------------------------------------------
| Navigator's state
|--------------------------------------------------------------------------
*/

/// State that each navigator creates and manage.
///
class NavigatorState with ServicesResolver {
  /// Resolve services reference.
  ///
  Services get services => resolveServices(context);

  /// Routes that this Navigator instance handles.
  ///
  final routes = <Route>[];

  /// Route name to route path map.
  ///
  final nameToPathMap = <String, String>{};

  /// Route path to Route instance map.
  ///
  final pathToRouteMap = <String, Route>{};

  /// Name of the active route. Route, that's currently on top of
  /// Navigator stack.
  ///
  String get currentRouteName => _currentName;
  var _currentName = '_';

  // internal stack data

  final _pageStack = <String>[];
  final _historyStack = <OpenHistoryEntry>[];

  /// Navigator widget's instance.
  ///
  final Navigator widget;

  /// Navigator's context
  ///
  BuildContext get context => _context!;
  BuildContext? _context;

  /// Navigator's render element
  ///
  NavigatorRenderElement get renderElement => _renderElement!;
  NavigatorRenderElement? _renderElement;

  NavigatorState(this.widget);

  /*
  |--------------------------------------------------------------------------
  | Methods available on Navigator's state
  |--------------------------------------------------------------------------
  */

  /// Open a page on Navigator's stack.
  ///
  /// Please note that if a Page with same name already exists, it'll bring that
  /// to top rather than creating new one.
  ///
  /// Will throw exception if Navigator doesn't have a route with the provided
  /// name.
  ///
  void open({
    required String name,
    Map<String, String> values = const {},
    bool updateHistory = true,
  }) {
    // if already on same page
    if (_historyStack.isNotEmpty) {
      var lastOpened = _historyStack.last;

      if (lastOpened.name == name) {
        if (fnIsKeyValueMapEqual(lastOpened.values, values)) {
          return;
        }
      }
    }

    // if current navigator doesn't have a matching '$name' route

    if (!nameToPathMap.containsKey(name)) {
      return services.debug.exception(
        "Navigator: Route '$name' is not declared.",
      );
    }

    // callbacks

    frameworkUpdateCurrentName(name);

    // update global state

    if (updateHistory) {
      if (services.debug.routerLogs) {
        print('$context: Push entry: $name');
      }

      services.router.pushEntry(
        name: name,
        values: values,
        navigator: renderElement,
        updateHistory: updateHistory,
      );
    }

    _historyStack.add(OpenHistoryEntry(name, values));

    // if route is already in stack, bring it to the top of stack

    if (isPageStacked(name: name)) {
      services.scheduler.addTask(
        WidgetsManageTask(
          parentRenderElement: renderElement,
          flagIterateInReverseOrder: true,
          widgetActionCallback: (widgetObject) {
            var widget = widgetObject.widget;

            if (widget is Route) {
              var routeName = widget.name;

              if (name == routeName) {
                return [WidgetAction.showWidget];
              }
            }

            return [WidgetAction.hideWidget];
          },
          afterTaskCallback: _updateProcedure,
        ),
      );
    } else {
      //
      // else build the route

      var page = pathToRouteMap[nameToPathMap[name]];

      if (null == page) {
        return services.debug.exception(Constants.coreError);
      }

      _pageStack.add(name);

      // hide all existing widgets

      services.scheduler.addTask(
        WidgetsManageTask(
          parentRenderElement: renderElement,
          flagIterateInReverseOrder: true,
          widgetActionCallback: (widgetObject) {
            return [WidgetAction.hideWidget];
          },
          afterTaskCallback: () {
            services.scheduler.addTask(
              WidgetsBuildTask(
                widgets: [page],
                parentRenderElement: renderElement,
                flagCleanParentContents: 1 == _historyStack.length,
              ),
            );
          },
        ),
      );
    }
  }

  /// Go back.
  ///
  void back() {
    if (canGoBack()) {
      _historyStack.removeLast();

      frameworkUpdateCurrentName(_historyStack.last.name);

      services.router.dispatchBackAction();
    } else {
      services.debug.exception('Navigator: No previous route to go back.');
    }
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
  String getValue(String segment) => services.router.getValue(
        renderElement,
        segment,
      );

  /// Whether current active stack contains a route with matching [name].
  ///
  bool isPageStacked({required String name}) => _pageStack.contains(name);

  /// Whether navigator can go back to a page.
  ///
  bool canGoBack() => _historyStack.length > 1;

  /*
  |--------------------------------------------------------------------------
  | internals
  |--------------------------------------------------------------------------
  */

  VoidCallback? _updateProcedure;

  @protected
  void frameworkBindContext(BuildContext context) {
    _context = context;
  }

  @protected
  void frameworkBindRenderElement(NavigatorRenderElement element) {
    _renderElement = element;
  }

  @protected
  void frameworkBindUpdateProcedure(VoidCallback updateProcedure) {
    _updateProcedure = updateProcedure;
  }

  @protected
  void frameworkInitState() {
    if (widget.routes.isEmpty) {
      if (services.debug.additionalChecks) {
        services.debug.exception(
          'Navigator instance must have at least one route.',
        );
      }

      return;
    }

    routes.addAll(widget.routes);

    for (final route in routes) {
      if (services.debug.additionalChecks) {
        if (RegExp(r'^ *$').hasMatch(route.name)) {
          if (route.name.isEmpty) {
            return services.debug.exception(
              "Navigator's Route's name can't be empty."
              '\n Route: ${route.name} -> ${route.name} is not allowed',
            );
          }

          return services.debug.exception(
            "Navigator's Route's name cannot contain empty spaces."
            '\n Route: ${route.name} -> ${route.path} is not allowed',
          );
        }

        if (!RegExp(r'^[a-zA-Z0-9_\-]+$').hasMatch(route.path)) {
          if (route.path.isEmpty) {
            return services.debug.exception(
              "Navigator's Route's path can't be empty."
              '\n Route: ${route.name} -> ${route.path} is not allowed',
            );
          }

          return services.debug.exception(
            "Navigator's Route can contains only alphanumeric characters "
            ', underscores(_) and hyphens(-)'
            '\n Route: ${route.name} -> ${route.path} is not allowed',
          );
        }

        var isDuplicate = nameToPathMap.containsKey(route.name) ||
            pathToRouteMap.containsKey(route.path);

        if (isDuplicate) {
          return services.debug.exception(
            'Please remove Duplicate routes from your Navigator. '
            "Part of your route, name: '${route.name}' => path: "
            "'${route.path}', already exists",
          );
        }
      }

      nameToPathMap[route.name] = route.path;

      pathToRouteMap[route.path] = route;
    }

    services.router.register(renderElement);
  }

  @protected
  void frameworkRender() {
    if (widget.routes.isEmpty) {
      return;
    }

    var name = services.router.getPath(renderElement);

    var needsReplacement = name.isEmpty;

    if (name.isEmpty) {
      name = widget.routes.first.name;
    }

    var onInitCallback = widget.onInit;
    if (null != onInitCallback) {
      onInitCallback(this);
    }

    if (needsReplacement && name.isNotEmpty) {
      if (services.debug.routerLogs) {
        print('$context: Push replacement: $name');
      }

      services.router.pushReplacement(
        name: name,
        values: {},
        navigator: renderElement,
      );
    }

    open(name: name, updateHistory: false);
  }

  @protected
  void frameworkUpdate(UpdateType updateType) {
    if (widget.routes.isEmpty) {
      return;
    }

    services.scheduler.addTask(
      WidgetsManageTask(
        parentRenderElement: renderElement,
        flagIterateInReverseOrder: true,
        widgetActionCallback: (widgetObject) {
          var widget = widgetObject.widget;

          if (widget is Route) {
            var routeName = widget.name;

            if (currentRouteName == routeName) {
              return [WidgetAction.updateWidget];
            }
          }

          return [];
        },
      ),
    );
  }

  @protected
  void frameworkDispose() => services.router.unRegister(renderElement);

  /// Framework fires this when parent route changes.
  ///
  void frameworkOnParentRouteChange(String name) {
    var routeName = services.router.getPath(renderElement);

    if (routeName != currentRouteName) {
      if (services.debug.routerLogs) {
        print('$context: Push replacement: $routeName');
      }

      services.router.pushReplacement(
        name: currentRouteName,
        values: {},
        navigator: renderElement,
      );
    }
  }

  @protected
  void frameworkUpdateCurrentName(String name) {
    _currentName = name;

    var onRouteChangeCallback = widget.onRouteChange;

    if (null != onRouteChangeCallback) {
      onRouteChangeCallback(_currentName);
    }
  }
}
