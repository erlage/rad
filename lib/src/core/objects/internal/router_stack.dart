import 'package:rad/src/core/objects/internal/router_stack_entry.dart';

/// Router stack.
///
/// For managing page history.
///
class RouterStack {
  final _entries = <RouteStackEntry>[];

  /// Whether a dynamic pop is possible.
  ///
  bool canPop() => _entries.isNotEmpty;

  /// Returns navigator key that has the most recent push.
  ///
  RouteStackEntry pop() => _entries.removeLast();

  /// Push navigator's key.
  ///
  /// This is to keep track of Navigators that are pushing state to browser history.
  /// When browser fires onPopState event, this allows framework to find the navigator
  /// that recently pushed and call pop() on that navigator.
  ///
  void push(RouteStackEntry entry) => _entries.add(entry);

  /// Clean all entries of Navigator.
  ///
  void remove(String navigatorKey) {
    _entries.removeWhere((entry) => entry.navigatorKey == navigatorKey);
  }
}
