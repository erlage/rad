import 'package:rad/rad.dart';
import 'package:rad/widgets.dart';

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

  NavigatorRouteObject({
    this.parent,
    required this.context,
    required this.routes,
    required this.segments,
  });
}
