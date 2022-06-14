import 'package:rad/src/widgets/navigator.dart';
import 'package:rad/src/widgets/route.dart';

/// Object containing information about a navigator.
///
class NavigatorRouteObject {
  final List<Route> routes;
  final List<String> segments;

  final NavigatorRouteObject? parent;
  final NavigatorRouteObject? child;

  final NavigatorRenderElement navigator;

  NavigatorRouteObject({
    this.parent,
    this.child,
    required this.routes,
    required this.segments,
    required this.navigator,
  });
}
