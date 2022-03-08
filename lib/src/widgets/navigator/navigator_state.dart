import 'package:rad/src/core/constants.dart';
import 'package:rad/src/core/classes/debug.dart';
import 'package:rad/src/core/classes/framework.dart';
import 'package:rad/src/core/classes/router.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/core/objects/widget_object.dart';
import 'package:rad/src/widgets/navigator.dart';
import 'package:rad/src/widgets/route.dart';

/// Navigator's state object.
///
/// Handles the delegated functionality of a [Navigator] widget.
///
class NavigatorState {
  var _currentName = '_';

  // Name of the active route. Route, that's currently on top of
  /// Navigator stack.
  ///
  String get currentRouteName => _currentName;

  late final Navigator widget;
  late final BuildContext context;
  late final WidgetObject widgetObject;

  final _activeStack = <String>[];
  final _historyStack = <String>[];

  /// Route name to route path map.
  ///
  final nameToPathMap = <String, String>{};

  /// Route path to Route instance map.
  ///
  final pathToRouteMap = <String, Route>{};

  /*
  |--------------------------------------------------------------------------
  | api
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
    _initState(widgetObject);

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
  void onParentRouteChange(String name) {
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

  /// Dispose handle.
  ///
  /// Framework will call this when required.
  /// Calling this mannually will results in undesired behaviour.
  ///
  void dispose() => Router.unRegister(context);

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
    context = widgetObject.context;
    widget = widgetObject.widget as Navigator;

    for (var route in widget.routes) {
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
    // so that router can use above jump tables and speed up route selection.

    Router.registerState(context, this);
  }

  void _updateCurrentName(String name) {
    _currentName = name;

    var onRouteChangeCallback = widget.onRouteChange;

    if (null != onRouteChangeCallback) {
      onRouteChangeCallback(_currentName);
    }
  }
}
