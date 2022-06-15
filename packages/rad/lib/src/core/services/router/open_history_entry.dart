/// A NavigatorState.open() call representation.
///
class OpenHistoryEntry {
  /// Name of the route opened.
  ///
  String name;

  /// Values passed during route open.
  ///
  Map<String, String> values;

  OpenHistoryEntry(this.name, this.values);
}
