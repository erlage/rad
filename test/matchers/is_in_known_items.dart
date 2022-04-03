// ignore_for_file: camel_case_types

import 'package:test/expect.dart';

class RT_IsInKnownItems<T> extends Matcher {
  final List<T> _knownItems;

  RT_IsInKnownItems(this._knownItems);

  @override
  bool matches(covariant T item, void _) => _knownItems.contains(item);

  @override
  Description describe(Description description) {
    description.add('item part of expected list');

    return description;
  }

  @override
  Description describeMismatch(
    item,
    Description mismatchDescription,
    void _,
    void __,
  ) {
    mismatchDescription.add("'$item' not in '${_knownItems.toString()}'");

    return mismatchDescription;
  }
}
