// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: camel_case_types

import 'package:test/expect.dart';

class RT_IsInKnownItems<T> extends Matcher {
  final List<T> _knownItems;

  RT_IsInKnownItems(this._knownItems);

  @override
  matches(covariant T item, void _) => _knownItems.contains(item);

  @override
  describe(description) {
    description.add('item part of expected list');

    return description;
  }

  @override
  describeMismatch(
    item,
    mismatchDescription,
    void _,
    void __,
  ) {
    mismatchDescription.add("'$item' not in '${_knownItems.toString()}'");

    return mismatchDescription;
  }
}
