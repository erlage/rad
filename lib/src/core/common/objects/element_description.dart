import 'package:meta/meta.dart';

/// Description patch for a element in DOM.
///
@immutable
class ElementDescription {
  final String? classAttribute;
  final Map<String, String?> dataset;
  final Map<String, String?> attributes;
  final Map<String, String?> styleProperties;

  final String? textContents;
  final String? rawContents;

  const ElementDescription({
    this.classAttribute,
    this.dataset = const {},
    this.attributes = const {},
    this.styleProperties = const {},
    this.textContents,
    this.rawContents,
  });
}
