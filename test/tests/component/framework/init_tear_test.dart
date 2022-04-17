import 'package:rad/rad.dart';
import 'package:test/scaffolding.dart';
import 'package:test/expect.dart';

import 'package:rad/src/core/objects/framework.dart';

import '../../../fixers/test_bed.dart';
import '../../../matchers/has_contents.dart';

/*
|--------------------------------------------------------------------------
| Component tests for core/objects/framework.dart
|
| Methods to test in this file: init() and tearDown()
|--------------------------------------------------------------------------
*/

void main() {
  group('Framework state tests:', () {
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

    test('tearDown() should dispose widgets from document', () {
      Framework.init(routingPath: '');

      // build widgets to test

      Framework.buildChildren(
        widgets: [
          Text('some text from widget', key: 'test-widget'),
        ],
        parentContext: RT_TestBed.rootContext,
      );

      // test widget should be built by now

      expect(null == Framework.getWidgetObject('test-widget'), equals(false));

      expect(RT_TestBed.rootElement, RT_hasContents('some text from widget'));

      Framework.tearDown();

      // test widget built above should be disposed by now

      expect(null == Framework.getWidgetObject('test-widget'), equals(true));

      expect(RT_TestBed.rootElement, RT_hasContents(''));
    });

    test('buildChildren() should throw if not initialized', () {
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
