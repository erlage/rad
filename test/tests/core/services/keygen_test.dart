import 'package:rad/widgets_internals.dart';
import 'package:test/scaffolding.dart';
import 'package:test/expect.dart';
import 'package:rad/src/core/common/objects/key.dart';

import '../../../fixers/test_bed.dart';

void main() {
  /*
  |--------------------------------------------------------------------------
  | keyGenService.generateGlobalKey() | Key generator test (a very basic test)
  |--------------------------------------------------------------------------
  */

  group('generateGlobalKey() :', () {
    var keyGenService = KeyGen(RT_TestBed.rootContext);

    var iterations = 100;
    var generatedWidgetKeys = <Key>[];

    while (iterations-- > 0) {
      generatedWidgetKeys.add(keyGenService.generateGlobalKey());
    }

    test('should generate unique keys', () {
      expect(
        generatedWidgetKeys.length,
        equals({...generatedWidgetKeys}.length),
      );
    });

    test('should generate keys that starts with system a identifier', () {
      for (var key in generatedWidgetKeys) {
        expect(key.hasSystemPrefix, equals(true));
      }
    });
  });

  /*
  |--------------------------------------------------------------------------
  | keyGenService.generateGlobalKey() | Key generator test (a very basic test)
  |--------------------------------------------------------------------------
  */

  group('generateGlobalKey() :', () {
    var keyGenService = KeyGen(RT_TestBed.rootContext);

    var iterations = 100;
    var generatedWidgetKeys = <Key>[];

    while (iterations-- > 0) {
      var key = Key("$iterations");

      generatedWidgetKeys.add(
        keyGenService.getGlobalKeyUsingKey(
          key,
          RT_TestBed.rootContext,
        ),
      );
    }

    test('should generate unique keys', () {
      expect(
        generatedWidgetKeys.length,
        equals({...generatedWidgetKeys}.length),
      );
    });

    test('should generate keys that starts with app target id', () {
      for (var key in generatedWidgetKeys) {
        expect(
          key.value.startsWith(RT_TestBed.rootContext.appTargetId),
          equals(true),
        );
      }
    });
  });

  /*
  |--------------------------------------------------------------------------
  | keyGenService.generateRandomKey() | a very basic test
  |--------------------------------------------------------------------------
  */

  group('generateRandomKey() :', () {
    var keyGenService = KeyGen(RT_TestBed.rootContext);

    var iterations = 100;
    var generatedRandomKeys = <String>[];

    while (iterations-- > 0) {
      generatedRandomKeys.add(keyGenService.generateRandomKey());
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
  | keyGenService.random() | a very basic test
  |--------------------------------------------------------------------------
  */

  group('random() :', () {
    var keyGenService = KeyGen(RT_TestBed.rootContext);

    var iterations = 100;
    var generatedRandomItems = <String>[];

    while (iterations-- > 0) {
      generatedRandomItems.add(keyGenService.random());
    }

    test('should generate unqiue values', () {
      expect(
        generatedRandomItems.length,
        equals({...generatedRandomItems}.length),
      );
    });
  });
}
