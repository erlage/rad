import 'package:rad/src/core/classes/debug.dart';
import 'package:rad/src/core/classes/framework.dart';
import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/classes/router.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/objects/widget_object.dart';
import 'package:rad/src/core/types.dart';
import 'package:rad/src/widgets/route.dart';
import 'package:rad/src/widgets/stateful_widget.dart';

/// Navigator widget including Router.
///
/// Rad framework comes with a in-built Router that offers
///
/// - Auto Routing
/// - Auto Deep linking
/// - Auto Single page experience (no page reloads when user hit forward/back buttons)
///
/// Syntax
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
/// This property takes list of Routes. A Route is more like an isolated Page that Navigator can manage. To define a Route, there's actually a Route widget:
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
/// Above, we've defined two routes, home and edit. A Route widget simply wraps a another widget. Route widget has a `name` property, that is used to give Route a name. Route's name is helpful in finding route, and navigating to it when needed, from application side.
///
/// ### NavigatorState
///
/// Navigator widget creates a state object. State object provides methods which you can use to jump between routes, pop routes and things like that. To access a Navigator's state object, there are two methods:
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
/// Navigator in Rad won't stack duplicate pages on top of each other, instead it'll create a route page only once. To go to a route, use `open` method of Navigator state. We could've named it `push` but `open` conveys what Navigator actually do when you jump to a route. When you call `open`, Navigator will create route page if it's not already created. Once ready, it'll bring it tp the top.
///
/// ```dart
/// Navigator.of(context).open(name: "home");
/// ```
///
/// ### Going back
///
/// To go to previously visited route, use `Navigator.of(context).back()`. Make sure to check whether you can actually go back by calling `canGoBack()` on state.
///
/// ### Passing values between routes
///
/// Values can be passed to a route through `open` method.
///
/// ```dart
/// Navigator.of(context).open(name: "home", values: "/somevalue");
/// // leading slash is important
/// ```
///
/// Then on homepage, value can be accessed on home page using:
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
/// Route(name: "profile", page: Profile(id: 123));
///
/// // do this
/// Route(name: "profile", page: Profile());
///
/// // and when opening profile route
/// Navigator.of(context).open(name: "profile", value: "/123");
///
/// // on profile page
/// var id = Navigator.of(context).getValue("profile");
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
    String? id,
    this.onInit,
    this.onRouteChange,
    required this.routes,
  }) : super(id: id);

  @override
  State<Navigator> createState() => NavigatorState();

  /// The state from the closest instance of Navigator state that encloses the given context.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// NavigatorState navigator = Navigator.of(context);
  /// ```
  static NavigatorState of(BuildContext context) {
    var navigatorState = context.findAncestorStateOfType<NavigatorState>();

    if (null == navigatorState) {
      throw "Navigator.of(context) called with the context that doesn't contains Navigator";
    }

    return navigatorState;
  }
}

// since Navigator widget is part of framework, it has access
// to Router and Framework core classes.

class NavigatorState extends State<Navigator> {
  final routes = <Route>[];

  final _activeStack = <String>[];
  final _historyStack = <String>[];

  /// Route name to route path map.
  ///
  final nameToPathMap = <String, String>{};

  /// Route path to Route instance map.
  ///
  final pathToRouteMap = <String, Route>{};

  var _currentName = '_';

  // Name of the active route. Route, that's currently on top of
  /// Navigator stack.
  ///
  String get currentRouteName => _currentName;

  @override
  initState() {
    routes.addAll(widget.routes);

    for (var route in routes) {
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

    Router.register(context, this);
  }

  @override
  dispose() => Router.unRegister(context);

  @override
  bool get frameworkIsBuildEnabled => false;

  @override
  build(context) => throw "Navigator uses Framework API for widget building.";

  void render() {
    var name = Router.getPath(context.id);

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
        print("${context.id}: Push replacement: $name");
      }

      Router.pushReplacement(
        name: name,
        values: '',
        navigatorId: context.id,
      );
    }

    open(name: name, updateHistory: false);
  }

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

    /*
    |--------------------------------------------------------------------------
    | callbacks
    |--------------------------------------------------------------------------
    */

    _updateCurrentName(cleanedName);

    /*
    |--------------------------------------------------------------------------
    | update global state
    |--------------------------------------------------------------------------
    */

    if (updateHistory) {
      if (Debug.routerLogs) {
        print("${context.id}: Push entry: $name");
      }

      Router.pushEntry(
        name: name,
        values: values ?? '',
        navigatorId: context.id,
        updateHistory: updateHistory,
      );
    }

    _historyStack.add(cleanedName);

    /*
    |--------------------------------------------------------------------------
    | if route is already in stack, bring it to the top of stack
    |--------------------------------------------------------------------------
    */

    if (isPageStacked(name: cleanedName)) {
      Framework.manageChildren(
        parentContext: context,
        flagIterateInReverseOrder: true,
        updateTypeWhenNecessary: UpdateType.navigatorOpen,
        widgetActionCallback: (WidgetObject widgetObject) {
          var routeName =
              widgetObject.element.dataset[System.attrRouteName] ?? "";

          if (name == routeName) {
            return [
              WidgetAction.showWidget,
              WidgetAction.updateWidget,
            ];
          }

          return [WidgetAction.hideWidget];
        },
      );
    } else {
      /*
      |--------------------------------------------------------------------------
      | else build the route
      |--------------------------------------------------------------------------
      */

      var page = pathToRouteMap[nameToPathMap[cleanedName]];

      if (null == page) throw System.coreError;

      _activeStack.add(name);

      Framework.buildChildren(
        widgets: [page],
        parentContext: context,
        flagCleanParentContents: false,
      );
    }
  }

  /// Whether current active stack contains a route with matching [name].
  ///
  bool isPageStacked({required String name}) => _activeStack.contains(name);

  /// Whether navigator can go back to a page.
  ///
  bool canGoBack() => _historyStack.length > 1;

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
  }

  /// Framework fires this when parent route changes.
  ///
  void onParentRouteChange(String name) {
    var routeName = Router.getPath(context.id);

    if (routeName != currentRouteName) {
      if (Debug.routerLogs) {
        print("${context.id}: Push replacement: $routeName");
      }

      Router.pushReplacement(
        name: currentRouteName,
        values: '',
        navigatorId: context.id,
      );
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
  String getValue(String segment) => Router.getValue(context.id, segment);

  void _updateCurrentName(String name) {
    _currentName = name;

    var onRouteChangeCallback = widget.onRouteChange;

    if (null != onRouteChangeCallback) {
      onRouteChangeCallback(_currentName);
    }
  }
}
