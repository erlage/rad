import 'package:rad/src/core/objects/utils.dart';
import 'package:rad/src/core/enums.dart';
import 'package:test/scaffolding.dart';
import 'package:test/expect.dart';

import '../../constants/button_types.dart';
import '../../constants/dom_events.dart';
import '../../constants/dom_tags.dart';
import '../../constants/form_methods.dart';
import '../../constants/form_types.dart';
import '../../constants/input_types.dart';
import '../../matchers/is_in_known_items.dart';
import '../../matchers/string_matchers.dart';

/*
|--------------------------------------------------------------------------
| Unit tests for core/objects/utils.dart
|--------------------------------------------------------------------------
*/

void main() {
  /*
  |--------------------------------------------------------------------------
  | Utils.mapDomEventType() | Dom event type mappings
  |--------------------------------------------------------------------------
  */

  group('mapDomEventType() :', () {
    test('mapped dom events should be available', () {
      for (var element in DomEventType.values) {
        expect(
          Utils.mapDomEventType(element),
          RT_IsInKnownItems<String>(RT_DomEvents.available),
        );
      }
    });

    test('mapped dom events should be implemented', () {
      for (var element in DomEventType.values) {
        expect(
          Utils.mapDomEventType(element),
          RT_IsInKnownItems<String>(RT_DomEvents.implemented),
        );
      }
    });

    test('mapped dom events should be lowercase', () {
      for (var element in DomEventType.values) {
        expect(Utils.mapDomEventType(element), RT_IsLowerCase());
      }
    });
  });

  /*
  |--------------------------------------------------------------------------
  | Utils.mapInputType() | Input type mappings
  |--------------------------------------------------------------------------
  */

  group('mapInputType() :', () {
    test('mapped input types should be available', () {
      for (var element in InputType.values) {
        expect(
          Utils.mapInputType(element),
          RT_IsInKnownItems<String>(RT_InputTypes.available),
        );
      }
    });

    test('mapped input types should be implemented', () {
      for (var element in InputType.values) {
        expect(
          Utils.mapInputType(element),
          RT_IsInKnownItems<String>(RT_InputTypes.implemented),
        );
      }
    });

    test('mapped input types should be lowercase', () {
      for (var element in InputType.values) {
        expect(Utils.mapInputType(element), RT_IsLowerCase());
      }
    });
  });

  /*
  |--------------------------------------------------------------------------
  | Utils.mapButtonType() | Button type mappings
  |--------------------------------------------------------------------------
  */

  group('mapButtonType() :', () {
    test('mapped button types should be available', () {
      for (var element in ButtonType.values) {
        expect(
          Utils.mapButtonType(element),
          RT_IsInKnownItems<String>(RT_ButtonTypes.available),
        );
      }
    });

    test('mapped button types should be implemented', () {
      for (var element in ButtonType.values) {
        expect(
          Utils.mapButtonType(element),
          RT_IsInKnownItems<String>(RT_ButtonTypes.implemented),
        );
      }
    });

    test('mapped button types should be lowercase', () {
      for (var element in ButtonType.values) {
        expect(Utils.mapButtonType(element), RT_IsLowerCase());
      }
    });
  });

  /*
  |--------------------------------------------------------------------------
  | Utils.mapFormEncType() | Form encoding type mappings
  |--------------------------------------------------------------------------
  */

  group('mapFormEncType() :', () {
    test('mapped form types should be available', () {
      for (var element in FormEncType.values) {
        expect(
          Utils.mapFormEncType(element),
          RT_IsInKnownItems<String>(RT_FormTypes.available),
        );
      }
    });

    test('mapped form types should be implemented', () {
      for (var element in FormEncType.values) {
        expect(
          Utils.mapFormEncType(element),
          RT_IsInKnownItems<String>(RT_FormTypes.implemented),
        );
      }
    });

    test('mapped form types should be lowercase', () {
      for (var element in FormEncType.values) {
        expect(Utils.mapFormEncType(element), RT_IsLowerCase());
      }
    });
  });

  /*
  |--------------------------------------------------------------------------
  | Utils.mapFormMethod() | Form method mappings
  |--------------------------------------------------------------------------
  */

  group('mapFormMethod() :', () {
    test('mapped form methods should be available', () {
      for (var element in FormMethod.values) {
        expect(
          Utils.mapFormMethod(element),
          RT_IsInKnownItems<String>(RT_FormMethods.available),
        );
      }
    });

    test('mapped form methods should be implemented', () {
      for (var element in FormMethod.values) {
        expect(
          Utils.mapFormMethod(element),
          RT_IsInKnownItems<String>(RT_FormMethods.implemented),
        );
      }
    });

    test('mapped form methods should be lowercase', () {
      for (var element in FormMethod.values) {
        expect(Utils.mapFormMethod(element), RT_IsLowerCase());
      }
    });
  });

  /*
  |--------------------------------------------------------------------------
  | Utils.mapDomTag() | Dom tag mappings
  |--------------------------------------------------------------------------
  */

  group('mapDomTag() :', () {
    test('mapped dom tags should be available', () {
      for (var element in DomTag.values) {
        expect(
          Utils.mapDomTag(element),
          RT_IsInKnownItems<String>(RT_DomTags.available),
        );
      }
    });

    test('mapped dom tags should be implemented', () {
      for (var element in DomTag.values) {
        expect(
          Utils.mapDomTag(element),
          RT_IsInKnownItems<String>(RT_DomTags.implemented),
        );
      }
    });

    test('mapped dom tags should be lowercase', () {
      for (var element in DomTag.values) {
        expect(Utils.mapDomTag(element), RT_IsLowerCase());
      }
    });

    test('mapped dom tags should be without space', () {
      for (var element in DomTag.values) {
        expect(Utils.mapDomTag(element), RT_IsWithoutSpace());
      }
    });
  });

  /*
  |--------------------------------------------------------------------------
  | Utils.generateWidgetKey() | Key generator test (a very basic test)
  |--------------------------------------------------------------------------
  */

  group('generateWidgetKey() :', () {
    var iterations = 100;
    var generatedWidgetKeys = <String>[];

    while (iterations-- > 0) {
      generatedWidgetKeys.add(Utils.generateWidgetKey());
    }

    test('should generate unique keys', () {
      expect(
        generatedWidgetKeys.length,
        equals({...generatedWidgetKeys}.length),
      );
    });

    test('should generate keys that starts with system a identifier', () {
      for (var key in generatedWidgetKeys) {
        expect(key.startsWith(System.contextGenKeyPrefix), equals(true));
      }
    });
  });

  /*
  |--------------------------------------------------------------------------
  | Utils.generateRandomKey() | a very basic test
  |--------------------------------------------------------------------------
  */

  group('generateRandomKey() :', () {
    var iterations = 100;
    var generatedRandomKeys = <String>[];

    while (iterations-- > 0) {
      generatedRandomKeys.add(Utils.generateRandomKey());
    }

    test('should generate unique keys', () {
      expect(
        generatedRandomKeys.length,
        equals({...generatedRandomKeys}.length),
      );
    });
  });

  /*
  |--------------------------------------------------------------------------
  | Utils.random() | a very basic test
  |--------------------------------------------------------------------------
  */

  group('random() :', () {
    var iterations = 100;
    var generatedRandomItems = <String>[];

    while (iterations-- > 0) {
      generatedRandomItems.add(Utils.random());
    }

    test('should generate unqiue values', () {
      expect(
        generatedRandomItems.length,
        equals({...generatedRandomItems}.length),
      );
    });
  });

  /*
  |--------------------------------------------------------------------------
  | Utils.isKeyValueMapEqual() | equality comparison for key/value string maps
  |--------------------------------------------------------------------------
  */

  group('isKeyValueMapEqual() :', () {
    test('should be equal if both keys & values are 1-1', () {
      expect(
        Utils.isKeyValueMapEqual(
          {'a': '1'},
          {'a': '1'},
        ),
        equals(true),
      );
    });

    test('should be equal if order is different but both keys & values are 1-1',
        () {
      expect(
        Utils.isKeyValueMapEqual(
          {'a': '1', 'b': '1'},
          {'b': '1', 'a': '1'},
        ),
        equals(true),
      );
    });

    test('should be unequal if map has different lengths', () {
      expect(
        Utils.isKeyValueMapEqual(
          {'a': '1', 'b': '1'},
          {'a': '1'},
        ),
        equals(false),
      );

      expect(
        Utils.isKeyValueMapEqual(
          {'a': '1'},
          {'a': '1', 'b': '1'},
        ),
        equals(false),
      );
    });

    test('should be unequal if a key is different', () {
      expect(
        Utils.isKeyValueMapEqual(
          {'b': '1'},
          {'a': '1'},
        ),
        equals(false),
      );

      expect(
        Utils.isKeyValueMapEqual(
          {'a': '1'},
          {'b': '1'},
        ),
        equals(false),
      );
    });

    test('should be unequal if a key is missing', () {
      expect(
        Utils.isKeyValueMapEqual(
          {'a': '1'},
          {},
        ),
        equals(false),
      );
    });

    // value

    test('should be unequal if a value is different', () {
      expect(
        Utils.isKeyValueMapEqual(
          {'a': '2'},
          {'a': '1'},
        ),
        equals(false),
      );

      expect(
        Utils.isKeyValueMapEqual(
          {'a': '1'},
          {'a': '2'},
        ),
        equals(false),
      );
    });
  });

  /*
  |--------------------------------------------------------------------------
  | Utils.encodeKeyValueMap() | uri encoding
  |--------------------------------------------------------------------------
  */

  group('encodeKeyValueMap() :', () {
    test('should encode empty map to empty string literal', () {
      expect(Utils.encodeKeyValueMap({}), equals(''));
    });

    test('should encode key value map to slash joined string literal', () {
      expect(Utils.encodeKeyValueMap({'a': 'b'}), equals('/a/b'));
    });

    test('should skip empty keys', () {
      expect(Utils.encodeKeyValueMap({'': 'b', 'c': 'd'}), equals('/b/c/d'));
    });

    test('should skip empty value', () {
      expect(Utils.encodeKeyValueMap({'a': '', 'c': 'd'}), equals('/a/c/d'));
    });

    test('should escape special characters', () {
      expect(Utils.encodeKeyValueMap({'a/b': 'c/d'}), equals('/a%2Fb/c%2Fd'));
      expect(Utils.encodeKeyValueMap({'a///b': ''}), equals('/a%2F%2F%2Fb'));

      expect(
        Utils.encodeKeyValueMap({'a + b': 'c + d'}),
        equals('/a%20%2B%20b/c%20%2B%20d'),
      );

      expect(Utils.encodeKeyValueMap({'\uFFFE': ''}), equals('/%EF%BF%BE'));

      expect(
        Utils.encodeKeyValueMap({'\uFFFE': '\uFFFE'}),
        equals('/%EF%BF%BE/%EF%BF%BE'),
      );
    });
  });
}
