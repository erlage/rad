import 'package:rad/src/core/enums.dart';

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
