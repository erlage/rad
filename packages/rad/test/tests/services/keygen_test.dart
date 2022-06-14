import '../../test_imports.dart';

void main() {
  /*
  |--------------------------------------------------------------------------
  | keyGenService.generateStringKey() | a very basic test
  |--------------------------------------------------------------------------
  */

  group('generateStringKey() :', () {
    var keyGenService = KeyGenService(
      RT_TestBed.rootRenderElement,
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
      RT_TestBed.rootRenderElement,
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
