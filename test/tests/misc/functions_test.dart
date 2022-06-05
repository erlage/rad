import '../../test_imports.dart';

void main() {
  /*
  |--------------------------------------------------------------------------
  | Enum | DomEventType mappings
  |--------------------------------------------------------------------------
  */

  group('mapDomEventType() :', () {
    test('mapped dom events should be available', () {
      for (final eventType in DomEventType.values) {
        expect(
          eventType.nativeName,
          RT_IsInKnownItems<String>(RT_DomEvents.available),
        );
      }
    });

    test('mapped dom events should be implemented', () {
      for (final eventType in DomEventType.values) {
        expect(
          eventType.nativeName,
          RT_IsInKnownItems<String>(RT_DomEvents.implemented),
        );
      }
    });

    test('mapped dom events should be lowercase', () {
      for (final eventType in DomEventType.values) {
        expect(eventType.nativeName, RT_IsLowerCase());
      }
    });
  });

  /*
  |--------------------------------------------------------------------------
  | Enum | InputType mappings
  |--------------------------------------------------------------------------
  */

  group('mapInputType() :', () {
    test('mapped input types should be available', () {
      for (final inputType in InputType.values) {
        expect(
          inputType.nativeName,
          RT_IsInKnownItems<String>(RT_InputTypes.available),
        );
      }
    });

    test('mapped input types should be implemented', () {
      for (final inputType in InputType.values) {
        expect(
          inputType.nativeName,
          RT_IsInKnownItems<String>(RT_InputTypes.implemented),
        );
      }
    });

    test('mapped input types should be lowercase', () {
      for (final inputType in InputType.values) {
        expect(inputType.nativeName, RT_IsLowerCase());
      }
    });
  });

  /*
  |--------------------------------------------------------------------------
  | Enum | ButtonType mappings
  |--------------------------------------------------------------------------
  */

  group('mapButtonType() :', () {
    test('mapped button types should be available', () {
      for (final buttonType in ButtonType.values) {
        expect(
          buttonType.nativeName,
          RT_IsInKnownItems<String>(RT_ButtonTypes.available),
        );
      }
    });

    test('mapped button types should be implemented', () {
      for (final buttonType in ButtonType.values) {
        expect(
          buttonType.nativeName,
          RT_IsInKnownItems<String>(RT_ButtonTypes.implemented),
        );
      }
    });

    test('mapped button types should be lowercase', () {
      for (final buttonType in ButtonType.values) {
        expect(buttonType.nativeName, RT_IsLowerCase());
      }
    });
  });

  /*
  |--------------------------------------------------------------------------
  | Enum | FormEncType mappings
  |--------------------------------------------------------------------------
  */

  group('mapFormEncType() :', () {
    test('mapped form types should be available', () {
      for (final enctype in FormEncType.values) {
        expect(
          enctype.nativeName,
          RT_IsInKnownItems<String>(RT_FormTypes.available),
        );
      }
    });

    test('mapped form types should be implemented', () {
      for (final enctype in FormEncType.values) {
        expect(
          enctype.nativeName,
          RT_IsInKnownItems<String>(RT_FormTypes.implemented),
        );
      }
    });

    test('mapped form types should be lowercase', () {
      for (final enctype in FormEncType.values) {
        expect(enctype.nativeName, RT_IsLowerCase());
      }
    });
  });

  /*
  |--------------------------------------------------------------------------
  | Enum | FormMethod mappings
  |--------------------------------------------------------------------------
  */

  group('formMethod enum :', () {
    test('mapped form methods should be available', () {
      for (final method in FormMethod.values) {
        expect(
          method.nativeName,
          RT_IsInKnownItems<String>(RT_FormMethods.available),
        );
      }
    });

    test('mapped form methods should be implemented', () {
      for (final method in FormMethod.values) {
        expect(
          method.nativeName,
          RT_IsInKnownItems<String>(RT_FormMethods.implemented),
        );
      }
    });

    test('mapped form methods should be lowercase', () {
      for (final method in FormMethod.values) {
        expect(method.nativeName, RT_IsLowerCase());
      }
    });
  });

  /*
  |--------------------------------------------------------------------------
  | Enum | DomTag mappings
  |--------------------------------------------------------------------------
  */

  group('mapDomTag() :', () {
    test('mapped dom tags should be available', () {
      for (final domTag in DomTag.values) {
        expect(
          domTag.nativeName,
          RT_IsInKnownItems<String>(RT_DomTags.available),
        );
      }
    });

    test('mapped dom tags should be implemented', () {
      for (final domNodeType in DomTag.values) {
        expect(
          domNodeType.nativeName,
          RT_IsInKnownItems<String>(RT_DomTags.implemented),
        );
      }
    });

    test('mapped dom tags should be lowercase', () {
      for (final domTag in DomTag.values) {
        expect(domTag.nativeName, RT_IsLowerCase());
      }
    });

    test('mapped dom tags should be without space', () {
      for (final domNodeType in DomTag.values) {
        expect(domNodeType.nativeName, RT_IsWithoutSpace());
      }
    });
  });

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
