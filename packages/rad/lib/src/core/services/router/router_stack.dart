import 'package:rad/src/core/services/router/router_stack_entry.dart';
import 'package:rad/src/widgets/navigator.dart';

/// Router stack.
///
/// For managing page history.
///
class RouterStack {
  /// Entries on router stack.
  ///
  /// window's location => entry
  ///
  final entries = <String, RouterStackEntry>{};

  void push(RouterStackEntry entry) => entries[entry.location] = entry;

  RouterStackEntry? get(String location) => entries[location];

  /// Clean all entries of a specific Navigator.
  ///
  void remove(NavigatorRenderElement navigator) {
    entries.removeWhere((pageId, entry) => entry.navigator == navigator);
  }

  void clear() => entries.clear();
}
