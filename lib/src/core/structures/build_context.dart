import '/src/core/enums.dart';

class BuildContext {
  String key;
  String parentKey;
  String widgetType;
  DomTag widgetDomTag;

  BuildContext({
    required this.key,
    required this.parentKey,
    required this.widgetType,
    required this.widgetDomTag,
  });
}

class BuildableContext {
  String? key;
  String parentKey;

  BuildableContext({
    this.key,
    required this.parentKey,
  });
}
