/// Router request.
///
class RouterRequest {
  final String name;
  final String navigatorKey;
  final Map<String, String> values;
  final bool updateHistory;

  final bool isReplacement;

  RouterRequest({
    required this.name,
    required this.values,
    required this.navigatorKey,
    required this.updateHistory,
    required this.isReplacement,
  });
}
