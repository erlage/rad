// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '../../test_imports.dart';

void main() {
  test('should set framework value', () {
    expect(Key('value').frameworkValue, equals('value'));
  });

  test('should stringify value', () {
    var key = Key('some-value');

    expect('$key', contains('some-value'));
    expect(Key('some-value').toString(), contains('some-value'));
  });

  test('should use underlying values hash code', () {
    var value = 'some-value';
    var key = Key(value);

    expect(key.hashCode, equals(value.hashCode));
  });

  test('should be equal to a key generated with same value', () {
    var generated = Key('some-value');

    expect(Key('some-value') == generated, equals(true));
    expect(Key('some-value') == Key('some-value'), equals(true));
  });

  test(
    'should be equal to a key generated with same value '
    'even if runtime types are different',
    () {
      var generated = _KeySubType('some-value');

      expect(Key('some-value') == generated, equals(true));
      expect(Key('some-value') == Key('some-value'), equals(true));
    },
  );
}

class _KeySubType extends Key {
  _KeySubType(super.value);
}
