import 'package:rad/src/core/classes/utils.dart';
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
| Unit tests for core/classes/utils.dart
|--------------------------------------------------------------------------
*/

void main() {
  /*
  |--------------------------------------------------------------------------
  | Utils.mapDomEventType() | Dom event type mappings
  |--------------------------------------------------------------------------
  */

  group(' Utils.mapDomEventType()', () {
    for (var element in DomEventType.values) {
      test(':: mapped dom event is available', () {
        expect(
          Utils.mapDomEventType(element),
          RT_IsInKnownItems<String>(RT_DomEvents.available),
        );
      });

      test(':: mapped dom event is implemented', () {
        expect(
          Utils.mapDomEventType(element),
          RT_IsInKnownItems<String>(RT_DomEvents.implemented),
        );
      });

      test(':: mapped dom event is lowercase', () {
        expect(Utils.mapDomEventType(element), RT_IsLowerCase());
      });
    }
  });

  /*
  |--------------------------------------------------------------------------
  | Utils.mapInputType() | Input type mappings
  |--------------------------------------------------------------------------
  */

  group('Utils.mapInputType()', () {
    for (var element in InputType.values) {
      test(':: mapped input type is available', () {
        expect(
          Utils.mapInputType(element),
          RT_IsInKnownItems<String>(RT_InputTypes.available),
        );
      });

      test(':: mapped input type is implemented', () {
        expect(
          Utils.mapInputType(element),
          RT_IsInKnownItems<String>(RT_InputTypes.implemented),
        );
      });

      test(':: mapped input type is lowercase', () {
        expect(Utils.mapInputType(element), RT_IsLowerCase());
      });
    }
  });

  /*
  |--------------------------------------------------------------------------
  | Utils.mapButtonType() | Button type mappings
  |--------------------------------------------------------------------------
  */

  group('Utils.mapButtonType()', () {
    for (var element in ButtonType.values) {
      test(':: mapped button type is available', () {
        expect(
          Utils.mapButtonType(element),
          RT_IsInKnownItems<String>(RT_ButtonTypes.available),
        );
      });

      test(':: mapped button type is implemented', () {
        expect(
          Utils.mapButtonType(element),
          RT_IsInKnownItems<String>(RT_ButtonTypes.implemented),
        );
      });

      test(':: mapped button type is lowercase', () {
        expect(Utils.mapButtonType(element), RT_IsLowerCase());
      });
    }
  });

  /*
  |--------------------------------------------------------------------------
  | Utils.mapFormEncType() | Form encoding type mappings
  |--------------------------------------------------------------------------
  */

  group('Utils.mapFormEncType()', () {
    for (var element in FormEncType.values) {
      test(':: mapped form type is available', () {
        expect(
          Utils.mapFormEncType(element),
          RT_IsInKnownItems<String>(RT_FormTypes.available),
        );
      });

      test(':: mapped form type is implemented', () {
        expect(
          Utils.mapFormEncType(element),
          RT_IsInKnownItems<String>(RT_FormTypes.implemented),
        );
      });

      test(':: mapped form type is lowercase', () {
        expect(Utils.mapFormEncType(element), RT_IsLowerCase());
      });
    }
  });

  /*
  |--------------------------------------------------------------------------
  | Utils.mapFormMethod() | Form method mappings
  |--------------------------------------------------------------------------
  */

  group('Utils.mapFormMethod()', () {
    for (var element in FormMethod.values) {
      test(':: mapped form method is available', () {
        expect(
          Utils.mapFormMethod(element),
          RT_IsInKnownItems<String>(RT_FormMethods.available),
        );
      });

      test(':: mapped form method is implemented', () {
        expect(
          Utils.mapFormMethod(element),
          RT_IsInKnownItems<String>(RT_FormMethods.implemented),
        );
      });

      test(':: mapped form method is lowercase', () {
        expect(Utils.mapFormMethod(element), RT_IsLowerCase());
      });
    }
  });

  /*
  |--------------------------------------------------------------------------
  | Utils.mapDomTag() | Dom tag mappings
  |--------------------------------------------------------------------------
  */

  group('Utils.mapDomTag()', () {
    for (var element in DomTag.values) {
      test(':: mapped dom tag is available', () {
        expect(
          Utils.mapDomTag(element),
          RT_IsInKnownItems<String>(RT_DomTags.available),
        );
      });

      test(':: mapped dom tag is implemented', () {
        expect(
          Utils.mapDomTag(element),
          RT_IsInKnownItems<String>(RT_DomTags.implemented),
        );
      });

      test(':: mapped dom tag is lowercase', () {
        expect(Utils.mapDomTag(element), RT_IsLowerCase());
      });

      test(':: mapped dom tag is without space', () {
        expect(Utils.mapDomTag(element), RT_IsWithoutSpace());
      });
    }
  });

  /*
  |--------------------------------------------------------------------------
  | Utils.generateWidgetKey() | Key generator test (a very basic test)
  |--------------------------------------------------------------------------
  */

  group('Utils.generateWidgetKey()', () {
    var iterations = 100;
    var generatedWidgetKeys = <String>[];

    while (iterations-- > 0) {
      generatedWidgetKeys.add(Utils.generateWidgetKey());
    }

    test('generated widget keys are unqiue', () {
      expect(
        generatedWidgetKeys.length,
        equals({...generatedWidgetKeys}.length),
      );
    });

    test('generated widget keys starts with system a identifier(_gen_)', () {
      for (var key in generatedWidgetKeys) {
        expect(key.startsWith('_gen_'), equals(true));
      }
    });
  });

  /*
  |--------------------------------------------------------------------------
  | Utils.generateRandomKey() | a very basic test
  |--------------------------------------------------------------------------
  */

  group('Utils.generateRandomKey()', () {
    var iterations = 100;
    var generatedRandomKeys = <String>[];

    while (iterations-- > 0) {
      generatedRandomKeys.add(Utils.generateRandomKey());
    }

    test('generated random keys are unqiue', () {
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

  group('Utils.random()', () {
    var iterations = 100;
    var generatedRandomItems = <String>[];

    while (iterations-- > 0) {
      generatedRandomItems.add(Utils.random());
    }

    test('generated random items are unqiue', () {
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

  group('Utils.isKeyValueMapEqual()', () {
    test('pass: if both keys & values has 1-1 relationship', () {
      expect(
        Utils.isKeyValueMapEqual(
          {'a': '1'},
          {'a': '1'},
        ),
        equals(true),
      );
    });

    test('pass: if both keys & values are 1-1, irrespective of the order', () {
      expect(
        Utils.isKeyValueMapEqual(
          {'a': '1', 'b': '1'},
          {'b': '1', 'a': '1'},
        ),
        equals(true),
      );
    });

    test('fail: if maps are of different length', () {
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

    test('fail: if a key is different', () {
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

    test('fail: if a key is missing', () {
      expect(
        Utils.isKeyValueMapEqual(
          {'a': '1'},
          {},
        ),
        equals(false),
      );
    });

    // value

    test('fail: if a value is different', () {
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

  group('Utils.encodeKeyValueMap()', () {
    test('encode empty map to empty string literal', () {
      expect(Utils.encodeKeyValueMap({}), equals(''));
    });

    test('encode key value map to slash joined string literal', () {
      expect(Utils.encodeKeyValueMap({'a': 'b'}), equals('/a/b'));
    });

    test('skip empty keys', () {
      expect(Utils.encodeKeyValueMap({'': 'b', 'c': 'd'}), equals('/b/c/d'));
    });

    test('skip empty value', () {
      expect(Utils.encodeKeyValueMap({'a': '', 'c': 'd'}), equals('/a/c/d'));
    });

    test('escape special characters', () {
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
