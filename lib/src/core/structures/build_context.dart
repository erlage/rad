import '/src/core/enums.dart';

class BuildContext {
  String id;
  String parentId;
  String widgetType;
  DomTag widgetDomTag;

  BuildContext({
    required this.id,
    required this.parentId,
    required this.widgetType,
    required this.widgetDomTag,
  });
}

class BuildableContext {
  String? id;
  String parentId;

  BuildableContext({
    this.id,
    required this.parentId,
  });
}
