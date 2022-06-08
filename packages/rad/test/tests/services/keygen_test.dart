import '../../test_imports.dart';

void main() {
  /*
  |--------------------------------------------------------------------------
  | keyGenService.generateGlobalKey() | Key generator test (a very basic test)
  |--------------------------------------------------------------------------
  */

  group('generateGlobalKey() :', () {
    var keyGenService = KeyGenService(
      RT_TestBed.rootContext,
      KeyGenOptions.defaultMode,
    )..startService();

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

    test('should generate keys with framework-generated flag on', () {
      for (final key in generatedWidgetKeys) {
        expect(key.isFrameworkGenerated, equals(true));
      }
    });
  });

  /*
  |--------------------------------------------------------------------------
  | keyGenService.generateGlobalKey() | Key generator test (a very basic test)
  |--------------------------------------------------------------------------
  */

  group('generateGlobalKey() :', () {
    var keyGenService = KeyGenService(
      RT_TestBed.rootContext,
      KeyGenOptions.defaultMode,
    )..startService();

    var iterations = 100;
    var generatedWidgetKeys = <Key>[];

    while (iterations-- > 0) {
      var key = Key('$iterations');

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
      for (final key in generatedWidgetKeys) {
        expect(
          key.value.startsWith(RT_TestBed.rootContext.appTargetId),
          equals(true),
        );
      }
    });

    test('should generate keys with framework-generated flag off', () {
      for (final key in generatedWidgetKeys) {
        expect(
          key.isFrameworkGenerated,
          equals(false),
        );
      }
    });
  });

  /*
  |--------------------------------------------------------------------------
  | keyGenService.getGlobalKeyUsingKey() 
  |--------------------------------------------------------------------------
  */

  group('getGlobalKeyUsingKey() :', () {
    var keyGenService = KeyGenService(
      RT_TestBed.rootContext,
      KeyGenOptions.defaultMode,
    )..startService();

    test('should be able to generate key from root context', () {
      var key = keyGenService.getGlobalKeyUsingKey(
        Key('key'),
        RT_TestBed.rootContext,
      );

      // depends on impl of KeyGen.getGlobalKeyUsingKey.
      expect(key.value, equals('${RT_TestBed.rootKey.value}__key'));
    });

    test('should be able to generate local key from root context', () {
      var key = keyGenService.getGlobalKeyUsingKey(
        LocalKey('key'),
        RT_TestBed.rootContext,
      );

      expect(key.value, equals('${RT_TestBed.rootKey.value}_key'));
    });

    test('should be able to generate global key from root context', () {
      var key = keyGenService.getGlobalKeyUsingKey(
        GlobalKey('global-key'),
        RT_TestBed.rootContext,
      );

      expect(key.value, equals('global-key'));
    });

    test('should generate different local and global key under root context',
        () {
      var fromLocal = keyGenService.getGlobalKeyUsingKey(
        LocalKey('key'),
        RT_TestBed.rootContext,
      );
      var fromGlobal = keyGenService.getGlobalKeyUsingKey(
        GlobalKey('key'),
        RT_TestBed.rootContext,
      );

      expect(fromLocal.value == fromGlobal.value, equals(false));
    });

    test(
      'should generate different non global and global key under root context',
      () {
        var fromLocal = keyGenService.getGlobalKeyUsingKey(
          Key('key'),
          RT_TestBed.rootContext,
        );
        var fromGlobal = keyGenService.getGlobalKeyUsingKey(
          GlobalKey('key'),
          RT_TestBed.rootContext,
        );

        expect(fromLocal.value == fromGlobal.value, equals(false));
      },
    );

    test(
      'should generate different local and non local key under root context',
      () {
        var fromLocal = keyGenService.getGlobalKeyUsingKey(
          Key('key'),
          RT_TestBed.rootContext,
        );
        var fromGlobal = keyGenService.getGlobalKeyUsingKey(
          LocalKey('key'),
          RT_TestBed.rootContext,
        );

        expect(fromLocal.value == fromGlobal.value, equals(false));
      },
    );
  });

  /*
  |--------------------------------------------------------------------------
  | keyGenService.generateRandomKey() | a very basic test
  |--------------------------------------------------------------------------
  */

  group('generateRandomKey() :', () {
    var keyGenService = KeyGenService(
      RT_TestBed.rootContext,
      KeyGenOptions.defaultMode,
    )..startService();

    var iterations = 100;
    var generatedRandomKeys = <String>[];

    while (iterations-- > 0) {
      generatedRandomKeys.add(keyGenService.generateStringKey());
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
    var keyGenService = KeyGenService(
      RT_TestBed.rootContext,
      KeyGenOptions.defaultMode,
    )..startService();

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