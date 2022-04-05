// ignore_for_file: camel_case_types

import 'dart:html';

import 'package:test/expect.dart';

class RT_hasContents extends Matcher {
  final String expected;

  const RT_hasContents(this.expected);

  @override
  matches(Object? item, void _) => _elementText(item) == expected;

  @override
  describe(description) {
    description.add(expected);

    return description;
  }

  @override
  describeMismatch(
    item,
    mismatchDescription,
    void _,
    void __,
  ) {
    mismatchDescription.add("Serialized contents: '${_elementText(item)}'");

    return mismatchDescription;
  }
}

// Taken from Angular Dart.

String? _elementText(Object? n) {
  if (n is Iterable) {
    return n.map(_elementText).join('|');
  } else if (n is Node) {
    if (n is ContentElement) {
      return _elementText(n.getDistributedNodes());
    }

    if (n is Element && n.shadowRoot != null) {
      return _elementText(n.shadowRoot!.nodes);
    }

    if (n.nodes.isNotEmpty) {
      return _elementText(n.nodes);
    }

    return n.text;
  } else {
    return '$n';
  }
}
