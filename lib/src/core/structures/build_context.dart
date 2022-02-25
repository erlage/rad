import '/src/core/enums.dart';

class BuildContext {
  final String key;
  final String parentKey;
  final String widgetType;
  final DomTag widgetDomTag;

  BuildContext({
    required this.key,
    required this.parentKey,
    required this.widgetType,
    required this.widgetDomTag,
  });
}

class BuildableContext {
  String? key;
  final String parentKey;

  BuildableContext({
    this.key,
    required this.parentKey,
  });

  mergeKey(String? key) {
    this.key = key;
  }
}
