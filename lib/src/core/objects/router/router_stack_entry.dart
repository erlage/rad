import 'package:rad/src/core/enums.dart';

class RouterStackEntry {
  final String navigatorKey;
  final RouterStackEntryType type;

  RouterStackEntry(this.navigatorKey, this.type);
}
