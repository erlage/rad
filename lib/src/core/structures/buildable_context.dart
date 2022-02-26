class BuildableContext {
  String? key;
  final String parentKey;

  BuildableContext({
    this.key,
    required this.parentKey,
  });

  BuildableContext mergeKey(String? key) {
    this.key = key;

    return this;
  }
}
