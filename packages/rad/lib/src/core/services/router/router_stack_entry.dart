import 'package:rad/src/widgets/navigator.dart';

/// A entry on Router stack.
///
class RouterStackEntry {
  /// Route name.
  ///
  final String name;

  /// Values pushed.
  ///
  final Map<String, String> values;

  /// Entry location.
  ///
  final String location;

  /// Navigator that pushed the entry.
  ///
  final NavigatorRenderElement navigator;

  RouterStackEntry({
    required this.name,
    required this.values,
    required this.navigator,
    required this.location,
  });
}
