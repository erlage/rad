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
      startApp(
        app: Text('hello world'),
        targetId: RT_TestBed.rootKey.value,
      );

      await Future.delayed(Duration(seconds: 1), () {
        expect(RT_TestBed.rootElement, RT_hasContents('hello world'));
      });
    });
  });
}
