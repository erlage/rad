import 'package:rad/src/core/classes/debug.dart';
import 'package:rad/src/core/classes/framework.dart';
import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/classes/router.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/objects/widget_object.dart';
import 'package:rad/src/core/types.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/widgets/inherited_widget.dart';
import 'package:rad/src/widgets/route.dart';
import 'package:rad/src/widgets/stateful_widget.dart';

/*
|--------------------------------------------------------------------------
| Navigator's scope (Inherited widget)
|--------------------------------------------------------------------------
*/

class _NavigatorScope extends InheritedWidget {
  final NavigatorState navigatorState;

  const _NavigatorScope({
    String? key,
    required Widget child,
    required this.navigatorState,
  }) : super(key: key, child: child);

  @override
  updateShouldNotify(oldWidget) => true;
}

/*
|--------------------------------------------------------------------------
| Navigator's Scope Bootstrapper.
|--------------------------------------------------------------------------
*/

class _NavigatorScopeBootstrapper extends StatefulWidget {
  const _NavigatorScopeBootstrapper({String? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NavigatorBootstrapState();
}

class _NavigatorBootstrapState extends State<_NavigatorScopeBootstrapper> {
  @override
  initState() {
    Navigator.of(context)
      ..frameworkBindScopeContext(context.parent)
      ..frameworkBootstrapRender();
  }

  @override
  get frameworkIsBuildEnabled => false;

  @override
  build(context) => throw "Navigator uses Framework.x-api to render widgets";
}

/*
|--------------------------------------------------------------------------
| At top, is our actual Navigator widget with state
|--------------------------------------------------------------------------
*/

/// Navigator widget.
///
/// Navigators basic usage is to allow navigating between pages. But Rad's Navigator
/// is bit different. It also carries out three big tasks for you,
///
/// - Routing
/// - Deep linking
/// - Single page experience (no page reloads when user hit forward/back buttons)
///
/// And all three tasks are carried out without any special configuration or management from
/// developer side. That is, Framework will automatically deep link your Navigators, and
/// route requests to the correct ones when requested no matter how deeply nested your
/// Navigators are.
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
/// This property takes list of Routes. What is a Route? in simplified view, a Route consists of two things,
///
/// 1. Name of the route e.g 'home', 'settings'
///
/// 2. Contents to show on route e.g some widget
///
/// To declare a route, there's actually a `Route` widget which simply wraps both parts of route into a single
/// widget that Navigator can manage.
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
/// Since Navigator's route is basically a widget that have a name attached to it, those routes will be treated as child
/// widgets of Navigator just like Span can have its childs. Difference being, Navigator's childs(Route widgets) are built
/// in a lazy fashion(only when requested). This also means that Navigator do not stack duplicate pages. All Route widgets
/// are built only once. That is when you open a route, if route widget doesn't exists, it'll create it else it'll use the
/// Route widget that's already built.
///
/// ### NavigatorState
///
/// Navigator widget creates a state object. State object provides methods which you can use to jump between routes, open
/// routes and things like that. To access a Navigator's state object, there are two methods:
///
/// 1. If widget from where you accessing NavigatorState is in child tree of Navigator then use `Navigator.of(context)`. This method will return NavigatorState of the nearest ancestor Navigator from the given `BuildContext`.
///
/// 2. For accessing state in parent widget of Navigator, use `onInit` hook of Navigator:
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
/// ### Jumping to a Route
///
/// To go to a route, use `open` method of Navigator state. We could've named it `push` but `open` conveys what exactly
/// Navigator do when you jump to a route. When you call `open`, Navigator will build route widget if it's not already
/// created. Once ready, it'll bring it to the top simply by hiding all other Route widgets that this Navigator is
/// managing.
///
/// ```dart
/// Navigator.of(context).open(name: "home");
/// ```
///
/// ### Going back
///
/// Going back means, going to the Route that's previously visited.
///
/// ```dart
///
/// Navigator.of(context).open(name: "home")
/// Navigator.of(context).open(name: "profile")
/// Navigator.of(context).open(name: "home")
///
/// Navigator.of(context).back() // ->  go to profile
/// Navigator.of(context).back() // ->  go to home
/// Navigator.of(context).back() // ->  error, no previous route!
///
/// // helper method to prevent above case:
///
/// Navigator.of(context).canGoBack() // ->  false, since no previous route
///
/// ### Passing values between routes
///
/// Values can be passed to a route while opening that route:
///
/// ```dart
/// Navigator.of(context).open(name: "home", values: "/somevalue"); // leading slash is important
///
/// ```
///
/// Then on homepage, value can be accessed using `getValue`:
///
/// ```dart
/// var value = Navigator.of(context).getValue("home");
/// // "somevalue"
/// ```
///
/// Passing multiple values:
///
/// ```dart
/// Navigator.of(context).open(name: "home", values: "/somevalue/profile/123");
/// ```
///
/// On homepage,
///
/// ```dart
/// var valueOne = Navigator.of(context).getValue("home"); // -> "somevalue"
/// var valueTwo = Navigator.of(context).getValue("profile"); // -> "123"
/// ```
///
/// Cool thing about Navigator is that values passed to a route will presist
/// during browser reloads. If you've pushed some values while opening a route,
/// those will presist in browser history too. This means you don't have to parameterize
/// your page content, instead pass values on `open`:
///
/// ```dart
/// // rather than doing this
/// Route(name: "profile", page: Profile(key: 123));
///
/// // do this
/// Route(name: "profile", page: Profile());
///
/// // and when opening profile route
/// Navigator.of(context).open(name: "profile", value: "/123");
///
/// // on profile page
/// var key = Navigator.of(context).getValue("profile");
/// ```
///
/// ### onRouteChange hook:
///
/// This hooks gets called when Navigator opens a route. This allows Navigator's parent
/// to do something when Navigator that it's enclosing has changed. for example, you
/// could've a header and you can change active tab when Navigator's route has changed.
///
/// ```dart
/// Navigator(
///     onRouteChange: (name) => print("changed to $name");
///     ...
/// );
/// ```
///
class Navigator extends StatefulWidget {
  /// Called when Navigator state is created.
  ///
  final NavigatorStateCallback? onInit;

  /// Called when Navigator's route changes.
  ///
  final NavigatorRouteChangeCallback? onRouteChange;

  /// List of [Route] that this Navigator handles.
  ///
  final List<Route> routes;

  const Navigator({
    String? key,
    this.onInit,
    this.onRouteChange,
    required this.routes,
  }) : super(key: key);

  /// The state from the closest instance of Navigator state that encloses the given context.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// NavigatorState navigator = Navigator.of(context);
  /// ```
  static NavigatorState of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<_NavigatorScope>()!
        .navigatorState;
  }

  @override
  State<StatefulWidget> createState() => NavigatorState();
}

// since Navigator widget is part of framework, it has access
// to Router and Framework core classes.

class NavigatorState extends State<Navigator> {
  /// Routes that this Navigator instance handles.
  ///
  final routes = <Route>[];

  /// Route name to route path map.
  ///
  final nameToPathMap = <String, String>{};

  /// Route path to Route instance map.
  ///
  final pathToRouteMap = <String, Route>{};

  // Name of the active route. Route, that's currently on top of
  /// Navigator stack.
  ///
  String get currentRouteName => _currentName;
  var _currentName = '_';

  /// Navigator's scope context.
  ///
  BuildContext get scopeContext => _scopeContext!;
  BuildContext? _scopeContext;

  // internal stack data

  final _activeStack = <String>[];
  final _historyStack = <String>[];

  @override
  initState() {
    routes.addAll(widget.routes);

    for (final route in routes) {
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

    Router.register(context, this);
  }

  @override
  build(context) {
    return _NavigatorScope(
      navigatorState: this,
      child: const _NavigatorScopeBootstrapper(),
    );
  }

  @override
  dispose() => Router.unRegister(context);

  /*
  |--------------------------------------------------------------------------
  | Methods available on Navigator's state
  |--------------------------------------------------------------------------
  */

  /// Open a page on Navigator's stack.
  ///
  /// Please note that if a Page with same name already exists, it'll bring that to top
  /// rather than creating new one.
  ///
  /// Will throw exception if Navigator doesn't have a route with the provided name.
  ///
  /// If [name] is prefixed with a forward slash '/', and if current navigator doesn't have
  /// a matching named route, then it'll delegate open call to a parent navigator(if exists).
  /// If there are no navigator in ancestors, it'll throw an exception.
  ///
  void open({
    String? values,
    required String name,
    bool updateHistory = true,
  }) {
    var traverseAncestors = name.startsWith("../");

    // clean traversal flag

    var cleanedName = traverseAncestors ? name.substring(3) : name;

    // if already on same page
    if (currentRouteName == cleanedName) {
      return;
    }

    // if current navigator doesn't have a matching '$name' route

    if (!nameToPathMap.containsKey(cleanedName)) {
      if (!traverseAncestors) {
        throw "Navigator: '$cleanedName' is not declared."
            "Named routes that are not registered in Navigator's routes are not allowed."
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

        parent.open(name: name, values: values);

        return;
      }
    }

    // callbacks

    _updateCurrentName(cleanedName);

    // update global state

    if (updateHistory) {
      if (Debug.routerLogs) {
        print("${context.key}: Push entry: $name");
      }

      Router.pushEntry(
        name: name,
        values: values ?? '',
        navigatorKey: context.key,
        updateHistory: updateHistory,
      );
    }

    _historyStack.add(cleanedName);

    // if route is already in stack, bring it to the top of stack

    if (isPageStacked(name: cleanedName)) {
      Framework.manageChildren(
        parentContext: scopeContext,
        flagIterateInReverseOrder: true,
        updateTypeWhenNecessary: UpdateType.setState,
        widgetActionCallback: (WidgetObject widgetObject) {
          var routeName =
              widgetObject.element.dataset[System.attrRouteName] ?? "";

          if (name == routeName) {
            return [WidgetAction.showWidget];
          }

          return [WidgetAction.hideWidget];
        },
      );

      // calling setState will rebuild Navigator's scope.
      // scope being an inherited widget, will notify all widgets
      // that are dependent on current Navigator state.

      setState(() {});
    } else {
      //
      // else build the route

      var page = pathToRouteMap[nameToPathMap[cleanedName]];

      if (null == page) throw System.coreError;

      _activeStack.add(name);

      Framework.buildChildren(
        widgets: [page],
        parentContext: scopeContext,
        flagCleanParentContents: _historyStack.isEmpty,
      );
    }
  }

  /// Go back.
  ///
  void back() {
    var previousPage = _historyStack.removeLast();

    _updateCurrentName(_historyStack.last);

    Framework.manageChildren(
      parentContext: context,
      flagIterateInReverseOrder: true,
      widgetActionCallback: (WidgetObject widgetObject) {
        var name = widgetObject.element.dataset[System.attrRouteName] ?? "";

        if (previousPage == name) {
          return [WidgetAction.showWidget];
        }

        return [WidgetAction.hideWidget];
      },
    );

    setState(() {});
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

  /// Whether current active stack contains a route with matching [name].
  ///
  bool isPageStacked({required String name}) => _activeStack.contains(name);

  /// Whether navigator can go back to a page.
  ///
  bool canGoBack() => _historyStack.length > 1;

  /*
  |--------------------------------------------------------------------------
  | internals
  |--------------------------------------------------------------------------
  */

  /// Bootstrapper provides its parent context(which effectively is scope of current
  /// navigator).
  ///
  void frameworkBindScopeContext(BuildContext scopeContext) {
    _scopeContext = scopeContext;
  }

  /// Bootstrapper fires this when it wants the initial render of Navigator.
  ///
  void frameworkBootstrapRender() {
    var name = Router.getPath(context.key);

    var needsReplacement = name.isEmpty;

    if (name.isEmpty) {
      name = widget.routes.first.name;
    }

    var onInitCallback = widget.onInit;
    if (null != onInitCallback) {
      onInitCallback(this);
    }

    if (needsReplacement && name.isNotEmpty) {
      if (Debug.routerLogs) {
        print("${context.key}: Push replacement: $name");
      }

      Router.pushReplacement(
        name: name,
        values: '',
        navigatorKey: context.key,
      );
    }

    open(name: name, updateHistory: false);
  }

  /// Framework fires this when parent route changes.
  ///
  void frameworkOnParentRouteChange(String name) {
    var routeName = Router.getPath(context.key);

    if (routeName != currentRouteName) {
      if (Debug.routerLogs) {
        print("${context.key}: Push replacement: $routeName");
      }

      Router.pushReplacement(
        name: currentRouteName,
        values: '',
        navigatorKey: context.key,
      );
    }
  }

  void _updateCurrentName(String name) {
    _currentName = name;

    var onRouteChangeCallback = widget.onRouteChange;

    if (null != onRouteChangeCallback) {
      onRouteChangeCallback(_currentName);
    }
  }
}
