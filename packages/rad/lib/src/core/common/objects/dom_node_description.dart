import 'package:meta/meta.dart';

/// Description patch for a dom node in DOM.
///
@immutable
class DomNodeDescription {
  final Map<String, String?>? dataset;
  final Map<String, String?>? attributes;

  final String? textContents;
  final String? rawContents;

  const DomNodeDescription({
    this.dataset,
    this.attributes,
    this.textContents,
    this.rawContents,
  });
}
