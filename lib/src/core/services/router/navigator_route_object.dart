import 'package:rad/src/core/common/objects/build_context.dart';
import 'package:rad/src/widgets/route.dart';

/// Information about a navigator and its routing description.
///
/// Will contain reference of parent route object if there exists a ancestor of type
/// Navigator.
///
class NavigatorRouteObject {
  final BuildContext context;
  final List<Route> routes;
  final List<String> segments;
  final NavigatorRouteObject? parent;
  final NavigatorRouteObject? child;

  NavigatorRouteObject({
    this.parent,
    this.child,
    required this.context,
    required this.routes,
    required this.segments,
  });
}
