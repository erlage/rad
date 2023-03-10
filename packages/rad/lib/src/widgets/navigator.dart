// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:meta/meta.dart';

import 'package:rad/src/core/common/abstract/build_context.dart';
import 'package:rad/src/core/common/abstract/render_element.dart';
import 'package:rad/src/core/common/abstract/router_render_element.dart';
import 'package:rad/src/core/common/constants.dart';
import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/objects/key.dart';
import 'package:rad/src/core/common/types.dart';
import 'package:rad/src/core/services/services_registry.dart';
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
///     // optional callbacks
///
///     onInit: (NavigatorState state) {
///
///     }
///
///     onDispose: (NavigatorState state) {
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
/// Span can have its child widgets. Difference being, Navigator's child
/// widgets(Route widgets) are built in a lazy fashion(only when requested).
/// This also means that Navigator do not stack duplicate pages. All Route
/// widgets are built only once. That is when you open a route, if route widget
/// doesn't exists, it'll create it else it'll use the Route widget that's
/// already built.
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
/// ```dart
/// class SomeWidget extends StatelessWidget
/// {
///   @override
///   build(context) {
///     return Navigator(
///     onInit: _onInit,
///       ...
///     )
///   }
///
///   _onInit(NavigatorState state) {
///       // do something with state
///   }
/// }
/// ```
/// For accessing state of a specific navigator in ancestors:
/// ```dart
/// // 1. Give Navigator instance a key while creating it
///
/// Navigator(key: Key('my-navigator'), routes: [...])
///
/// // 2. Use of(context, byKey: key) anywhere in the subtree of Navigator,
///
/// Navigator.of(context, byKey: Key('my-navigator');
///
/// ```
/// ### onDispose hook:
///
/// This hooks gets called when Navigator state is disposed off. This hook
/// can be used to do perform clean up operations in case you've set up
/// some resources in the onInit callback.
///
/// ```dart
/// Navigator(
///     onDispose: (state) => print("do clean-up");
///     ...
/// );
/// ```
/// Please note that the `state` object passed to the `onDispose` callback is
/// not meant for consumption. It is provided only for reference purposes and
/// should not be used in the same way as the state object in the `onInit`
/// callback. Attempting to call any methods on state within the `onDispose`
/// callback, such as `state.open()`, will result in an error being thrown.
/// The purpose of the `onDispose` callback is to provide a cleanup mechanism
/// for resources created during the `onInit` callback, not to manipulate the
/// `state` object in any way.
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
///   name: "home", values: {"id": "123", "username" : "adam back"}
/// );
/// ```
///
/// On homepage,
///
/// ```dart
/// var id = Navigator.of(context).getValue("id"); // -> "123"
/// var username = Navigator.of(context).getValue("username"); // -> "adam back"
/// ```
///
/// Cool thing about Navigator is that values passed to a route will persist
/// during browser reloads. If you've pushed some values while opening a route,
/// those will persist in browser history too.
///
/// ## Managing state in Routes:
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
///     // initialize here, all things that don't depend on Navigator
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

  /// Called when Navigator state is disposed.
  ///
  /// Please note that the `state` object passed to the `onDispose` callback is
  /// not meant for consumption. It is provided only for reference purposes and
  /// should not be used in the same way as the state object in the `onInit`
  /// callback. Attempting to call any methods on state within the `onDispose`
  /// callback, such as `state.open()`, will result in an error being thrown.
  /// The purpose of the `onDispose` callback is to provide a cleanup mechanism
  /// for resources created during the `onInit` callback, not to manipulate the
  /// `state` object in any way.
  ///
  final NavigatorStateCallback? onDispose;

  /// Called when Navigator's route changes.
  ///
  final NavigatorRouteChangeCallback? onRouteChange;

  const Navigator({
    required this.routes,
    this.onInit,
    this.onDispose,
    this.onRouteChange,
    Key? key,
  }) : super(key: key);

  /// Navigator's state from the closest instance of this class
  /// that encloses the given context.
  ///
  static NavigatorState of(BuildContext context, {Key? byKey}) {
    NavigatorRenderElement? parent;

    context.visitAncestorElements((element) {
      // match type
      if (element is NavigatorRenderElement) {
        // match key
        if (null == byKey || element.key == byKey) {
          parent = element;

          return false;
        }
      }

      return true;
    });

    var parentNavigator = parent;

    if (null == parentNavigator) {
      if (DEBUG_BUILD) {
        var debugService = ServicesRegistry.instance.getDebug(context);

        debugService.exception(
          'Navigator operation requested with a context that does not include '
          'a Navigator.\n'
          'The context used to push or pop routes from the Navigator must be '
          'that of a widget that is a descendant of a Navigator widget.',
        );
      }

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
  /// behavior as [Navigator] build its child widgets from its state. If you
  /// don't want the [Navigator] to update its child widgets, override
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
| render object
|--------------------------------------------------------------------------
*/

@internal
class NavigatorRenderElement extends RouterRenderElement {
  final NavigatorState state;

  NavigatorRenderElement(
    Navigator widget,
    RenderElement parent,
  )   : state = NavigatorState(widget),
        super(widget: widget, parent: parent, routes: widget.routes);

  /*
  |--------------------------------------------------------------------------
  | Router Render Element's APIs
  |--------------------------------------------------------------------------
  */

  @override
  void willInit() {
    state.frameworkBindRenderElement(this);
  }

  @override
  void didInit() {
    var onInitCallback = (widget as Navigator).onInit;
    if (null != onInitCallback) {
      onInitCallback(state);
    }
  }

  @override
  void didChangedPath({
    required String previousPath,
    required String currentPath,
  }) {
    var routeChangeCallback = (widget as Navigator).onRouteChange;
    if (null != routeChangeCallback) {
      var routeName = getNameFromPath(path: currentPath);

      routeChangeCallback(routeName);
    }
  }

  @override
  void didDispose() {
    state.frameworkMarkDisposed();

    var onDisposeCallback = (widget as Navigator).onDispose;
    if (null != onDisposeCallback) {
      onDisposeCallback(state);
    }
  }
}

/*
|--------------------------------------------------------------------------
| Navigator's state
|--------------------------------------------------------------------------
*/

class NavigatorState {
  /// Navigator widget's instance.
  ///
  final Navigator widget;

  /// Navigator's render element
  ///
  NavigatorRenderElement? _renderElement;

  /// Routes that this Navigator instance handles.
  ///
  final List<Route> routes;

  /// Navigator's context.
  ///
  BuildContext get context => _renderElement!;

  /// Name of the active route. Route, that's currently on top of
  /// Navigator stack.
  ///
  String get currentRouteName => _renderElement!.getCurrentRouteName();

  /// Whether Navigator's state is disposed.
  ///
  bool _isDisposed = false;

  NavigatorState(this.widget) : routes = widget.routes;

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
    if (_isDisposed) {
      throw Exception('Cannot call open() after state is disposed off.');
    }

    var path = _renderElement!.getPathFromName(name: name);

    _renderElement!.openPath(
      path: path,
      values: values,
      updateHistory: updateHistory,
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
  String getValue(String segment) {
    if (_isDisposed) {
      throw Exception('Cannot call getValue() after state is disposed off.');
    }

    return _renderElement!.getValue(segment);
  }

  /// Go back.
  ///
  void back() {
    if (_isDisposed) {
      throw Exception('Cannot call back() after state is disposed off.');
    }

    _renderElement!.openPreviousPath();
  }

  /// Whether navigator can go back to a page.
  ///
  bool canGoBack() {
    if (_isDisposed) {
      throw Exception('Cannot call canGoBack() after state is disposed off.');
    }

    return _renderElement!.canOpenPreviousPath();
  }

  /// @nodoc
  @nonVirtual
  @internal
  @protected
  void frameworkBindRenderElement(NavigatorRenderElement element) {
    _renderElement = element;
  }

  /// @nodoc
  @nonVirtual
  @internal
  @protected
  void frameworkMarkDisposed() {
    _isDisposed = true;
  }
}
