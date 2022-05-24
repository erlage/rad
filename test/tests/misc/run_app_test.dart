import 'package:rad/rad.dart';
import 'package:test/scaffolding.dart';
import 'package:test/expect.dart';

import '../../fixers/test_bed.dart';
import '../../matchers/has_contents.dart';

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
  });
}
