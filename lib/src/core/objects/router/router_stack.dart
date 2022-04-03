import 'package:rad/src/core/objects/router/router_stack_entry.dart';

/// Router stack.
///
/// For managing page history.
///
class RouterStack {
  /// Entries on router stack.
  ///
  /// window.location.href => entry
  ///
  final entries = <String, RouterStackEntry>{};

  /// Push a new entry on stack.
  ///
  /// This is to keep track of Navigators that are pushing state to browser history.
  /// When browser fires onPopState event, this allows framework to find the navigator
  /// that recently pushed a entry on stack.
  ///
  void push(RouterStackEntry entry) => entries[entry.location] = entry;

  /// Get entry for a given location.
  ///
  RouterStackEntry? get(String location) => entries[location];

  /// Clean all entries of Navigator.
  ///
  void remove(String navigatorKey) {
    entries.removeWhere((pageId, entry) => entry.navigatorKey == navigatorKey);
  }

  /// Clear all entries in stack.
  ///
  void clear() => entries.clear();
}
