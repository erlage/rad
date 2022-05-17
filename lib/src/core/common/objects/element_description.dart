import 'package:meta/meta.dart';

import 'package:rad/src/core/common/enums.dart';
import 'package:rad/src/core/common/types.dart';

/// Description patch for a element in DOM.
///
@immutable
class ElementDescription {
  final Map<String, bool> classes;
  final Map<String, String?> dataset;
  final Map<String, String?> attributes;
  final Map<String, String?> styleProperties;

  final Map<DomEventType, EventCallback?> eventListenersToAdd;
  final Map<DomEventType, EventCallback?> eventListenersToRemove;

  final String? textContents;
  final String? rawContents;

  const ElementDescription({
    this.classes = const {},
    this.dataset = const {},
    this.attributes = const {},
    this.styleProperties = const {},
    this.eventListenersToAdd = const {},
    this.eventListenersToRemove = const {},
    this.textContents,
    this.rawContents,
  });
}
