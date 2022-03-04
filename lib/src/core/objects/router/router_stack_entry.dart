import 'package:rad/src/core/enums.dart';

class RouteStackEntry {
  final String navigatorKey;
  final RouteEntryType type;

  RouteStackEntry(this.navigatorKey, this.type);
}
