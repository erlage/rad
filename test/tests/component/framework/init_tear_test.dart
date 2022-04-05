import 'package:test/scaffolding.dart';
import 'package:test/expect.dart';

import 'package:rad/src/core/classes/framework.dart';

import '../../../fixers/test_bed.dart';

/*
|--------------------------------------------------------------------------
| Component test for core/classes/router.dart
|
| Initialization and Tear down tests.
|
|--------------------------------------------------------------------------
*/

void main() {
  group('Framework initialization/teardown', () {
    test('init() should throw if already initialized', () {
      Framework.init(routingPath: '');

      expect(
        () => Framework.init(routingPath: ''),
        throwsA(
          predicate(
            (e) => '$e'.startsWith('Exception: Framework aleady initialized.'),
          ),
        ),
      );

      Framework.tearDown();
    });

    test('tearDown() should throw if not initialized', () {
      expect(
        Framework.tearDown,
        throwsA(
          predicate(
            (e) => '$e'.startsWith('Exception: Framework is not initialized.'),
          ),
        ),
      );
    });

    test('framework buildChildren() should throw if not initialized', () {
      expect(
        () => Framework.buildChildren(
          widgets: [],
          parentContext: RT_TestBed.rootContext,
        ),
        throwsA(
          predicate(
            (e) => '$e'.startsWith('Exception: Framework not initialized.'),
          ),
        ),
      );
    });
  });
}
