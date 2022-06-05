import 'package:meta/meta.dart';

/// Description patch for a dom node in DOM.
///
@immutable
class DomNodeDescription {
  final Map<String, String?> dataset;
  final Map<String, String?> attributes;
  final Map<String, String?> styleProperties;

  final String? textContents;
  final String? rawContents;

  const DomNodeDescription({
    this.dataset = const {},
    this.attributes = const {},
    this.styleProperties = const {},
    this.textContents,
    this.rawContents,
  });
}
