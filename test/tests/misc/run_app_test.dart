import '../../test_imports.dart';

/*
|--------------------------------------------------------------------------
| start app tests
|--------------------------------------------------------------------------
*/

void main() {
  group('start app tests :', () {
    test('should run app', () async {
      runApp(
        app: Text('hello world'),
        targetId: RT_TestBed.rootKey.value,
      );

      await Future.delayed(Duration.zero, () {
        expect(RT_TestBed.rootElement, RT_hasContents('hello world'));
      });
    });

    test('should throw if target not found', () async {
      expect(
        () => runApp(
          app: Text('hello world'),
          targetId: 'some-non-existent-target',
        ),
        throwsA(
          predicate(
            (e) => '$e'.startsWith('Exception: Unable to locate target'),
          ),
        ),
      );
    });

    test('should start app in non-test mode', () async {
      var app = runApp(
        app: Text('hello world'),
        targetId: RT_TestBed.rootContext.key.value,
      );

      await Future.delayed(Duration(milliseconds: 100));

      expect(
        () => app.framework.renderer,
        throwsA(
          predicate(
            (e) => '$e'.startsWith('Exception: Start app in test-mode'),
          ),
        ),
      );
    });
  });
}
