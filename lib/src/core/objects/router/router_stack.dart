import 'package:rad/src/core/objects/router/router_stack_entry.dart';

/// Router stack.
///
/// For managing page history.
///
class RouterStack {
  final _entries = <RouterStackEntry>[];

  /// Whether a dynamic pop is possible.
  ///
  bool canPop() => _entries.isNotEmpty;

  /// Returns the most recent stack entry.
  ///
  RouterStackEntry pop() => _entries.removeLast();

  /// Push a new entry on stack.
  ///
  /// This is to keep track of Navigators that are pushing state to browser history.
  /// When browser fires onPopState event, this allows framework to find the navigator
  /// that recently pushed a entry on stack.
  ///
  void push(RouterStackEntry entry) => _entries.add(entry);

  /// Clean all entries of Navigator.
  ///
  void remove(String navigatorKey) {
    _entries.removeWhere((entry) => entry.navigatorKey == navigatorKey);
  }
}
