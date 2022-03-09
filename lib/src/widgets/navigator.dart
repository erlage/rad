import 'package:rad/src/core/classes/framework.dart';
import 'package:rad/src/core/enums.dart';
import 'package:rad/src/core/classes/router.dart';
import 'package:rad/src/core/objects/render_object.dart';
import 'package:rad/src/core/objects/build_context.dart';
import 'package:rad/src/widgets/abstract/widget.dart';
import 'package:rad/src/core/types.dart';
import 'package:rad/src/widgets/navigator/navigator_state.dart';
import 'package:rad/src/widgets/route.dart';

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
class Navigator extends Widget {
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
  }) : super(id);

  @override
  DomTag get tag => DomTag.div;

  @override
  String get type => "$Navigator";

  @override
  onContextCreate(context) => Router.registerRoutes(context, routes);

  @override
  createRenderObject(context) => NavigatorRenderObject(context);

  @override
  onRenderObjectCreate(covariant NavigatorRenderObject renderObject) {
    //
    // If we create state in RenderObject then state will be created
    // multiple times because framework can create RenderObject anytime
    // it wants a up-to-date interface. Creating state here is more
    // appropriate for performance reasons as this hook gets called
    // only when first RenderObject of this widget is created.
    //

    renderObject.state = NavigatorState();
  }

  /// The state from the closest instance of this class that encloses the given context.
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// NavigatorState navigator = Navigator.of(context);
  /// ```
  static NavigatorState of(BuildContext context) {
    var widgetObject = Framework.findAncestorOfType<Navigator>(context);

    if (null == widgetObject) {
      throw "Navigator.of(context) called with the context that doesn't contains Navigator";
    }

    return (widgetObject.renderObject as NavigatorRenderObject).state;
  }
}

class NavigatorRenderObject extends RenderObject {
  /// State of navigator.
  ///
  late final NavigatorState state;

  NavigatorRenderObject(BuildContext context) : super(context);

  // delegate everything to state object

  @override
  render(widgetObject) => state.render(widgetObject);

  @override
  void beforeUnMount() => state.dispose();
}
