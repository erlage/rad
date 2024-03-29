// Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '../../test_imports.dart';

void main() {
  /*
  |--------------------------------------------------------------------------
  | fnIsKeyValueMapEqual() | equality comparison for key/value string maps
  |--------------------------------------------------------------------------
  */

  group('isKeyValueMapEqual() :', () {
    test('should be equal if both keys & values are 1-1', () {
      expect(
        fnIsKeyValueMapEqual(
          {'a': '1'},
          {'a': '1'},
        ),
        equals(true),
      );
    });

    test('should be equal if order is different but both keys & values are 1-1',
        () {
      expect(
        fnIsKeyValueMapEqual(
          {'a': '1', 'b': '1'},
          {'b': '1', 'a': '1'},
        ),
        equals(true),
      );
    });

    test('should be unequal if map has different lengths', () {
      expect(
        fnIsKeyValueMapEqual(
          {'a': '1', 'b': '1'},
          {'a': '1'},
        ),
        equals(false),
      );

      expect(
        fnIsKeyValueMapEqual(
          {'a': '1'},
          {'a': '1', 'b': '1'},
        ),
        equals(false),
      );
    });

    test('should be unequal if a key is different', () {
      expect(
        fnIsKeyValueMapEqual(
          {'b': '1'},
          {'a': '1'},
        ),
        equals(false),
      );

      expect(
        fnIsKeyValueMapEqual(
          {'a': '1'},
          {'b': '1'},
        ),
        equals(false),
      );
    });

    test('should be unequal if a key is missing', () {
      expect(
        fnIsKeyValueMapEqual(
          {'a': '1'},
          {},
        ),
        equals(false),
      );
    });

    // value

    test('should be unequal if a value is different', () {
      expect(
        fnIsKeyValueMapEqual(
          {'a': '2'},
          {'a': '1'},
        ),
        equals(false),
      );

      expect(
        fnIsKeyValueMapEqual(
          {'a': '1'},
          {'a': '2'},
        ),
        equals(false),
      );
    });

    test('should be equal if both are null', () {
      expect(fnIsKeyValueMapEqual(null, null), equals(true));
    });

    test('should be unequal if one of them is null', () {
      expect(fnIsKeyValueMapEqual(null, {}), equals(false));
      expect(fnIsKeyValueMapEqual({}, null), equals(false));
    });
  });

  /*
  |--------------------------------------------------------------------------
  | fnEncodeValue() | uri encoding
  |--------------------------------------------------------------------------
  */

  group('encodeValue() :', () {
    test('should encode empty value to empty string literal', () {
      expect(fnEncodeValue(''), equals(''));
    });

    test('should encode special characters', () {
      expect(fnEncodeValue('a/b'), equals('a%2Fb'));
      expect(fnEncodeValue('a///b'), equals('a%2F%2F%2Fb'));
      expect(fnEncodeValue('a + b'), equals('a%20%2B%20b'));
      expect(fnEncodeValue('\uFFFE'), equals('%EF%BF%BE'));
      expect(fnEncodeValue('\uFFFE'), equals('%EF%BF%BE'));
    });
  });

  /*
  |--------------------------------------------------------------------------
  | fnDecodeValue() | uri encoding
  |--------------------------------------------------------------------------
  */

  group('decodeValue() :', () {
    test('should decode empty value to empty string literal', () {
      expect(fnDecodeValue(''), equals(''));
    });

    test('should decode special characters', () {
      expect(fnDecodeValue('a%2Fb'), equals('a/b'));
      expect(fnDecodeValue('a%2F%2F%2Fb'), equals('a///b'));
      expect(fnDecodeValue('a%20%2B%20b'), equals('a + b'));
      expect(fnDecodeValue('%EF%BF%BE'), equals('\uFFFE'));
      expect(fnDecodeValue('%EF%BF%BE'), equals('\uFFFE'));
    });
  });

  /*
  |--------------------------------------------------------------------------
  | fnEncodeKeyValueMap() | uri encoding
  |--------------------------------------------------------------------------
  */

  group('encodeKeyValueMap() :', () {
    test('should encode empty map to empty string literal', () {
      expect(fnEncodeKeyValueMap({}), equals(''));
    });

    test('should encode key value map to slash joined string literal', () {
      expect(fnEncodeKeyValueMap({'a': 'b'}), equals('a/b'));
    });

    test('should skip empty keys', () {
      expect(fnEncodeKeyValueMap({'': 'b', 'c': 'd'}), equals('b/c/d'));
    });

    test('should skip empty value', () {
      expect(fnEncodeKeyValueMap({'a': '', 'c': 'd'}), equals('a/c/d'));
    });

    test('should escape special characters', () {
      expect(fnEncodeKeyValueMap({'a/b': 'c/d'}), equals('a%2Fb/c%2Fd'));
      expect(fnEncodeKeyValueMap({'a///b': ''}), equals('a%2F%2F%2Fb'));

      expect(
        fnEncodeKeyValueMap({'a + b': 'c + d'}),
        equals('a%20%2B%20b/c%20%2B%20d'),
      );

      expect(fnEncodeKeyValueMap({'\uFFFE': ''}), equals('%EF%BF%BE'));

      expect(
        fnEncodeKeyValueMap({'\uFFFE': '\uFFFE'}),
        equals('%EF%BF%BE/%EF%BF%BE'),
      );
    });
  });
}
