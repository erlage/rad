class RouterStackEntry {
  final String name;
  final Map<String, String> values;
  final String navigatorKey;
  final String location;

  RouterStackEntry({
    required this.name,
    required this.values,
    required this.navigatorKey,
    required this.location,
  });
}
