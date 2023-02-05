// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:rad_test/rad_test.dart';

import '../../test_imports.dart';

/*
|--------------------------------------------------------------------------
| Component tests for core/framework
|--------------------------------------------------------------------------
*/

void main() {
  // we're testing framework at a high-level rather than unit testing everything
  // each test case below verifies multiple aspects of widget's behavior and can
  // fail because of slightest change that test itself is not even meant to test
  group('update widgets basic tests:', () {
    // build tests

    testWidgets('should build new widget if runtime type are different',
        (tester) async {
      await tester.pumpWidget(
        RT_TestWidget(
          roEventRender: () => tester.push('render 1a'),
          roEventUpdate: () => tester.push('update 1a'),
          roEventAfterUnMount: () => tester.push('dispose 1a'),
        ),
      );

      await tester.rePumpWidget(
        RT_AnotherTestWidget(
          roEventRender: () => tester.push('render 1b'),
          roEventUpdate: () => tester.push('update 1b'),
          roEventAfterUnMount: () => tester.push('dispose 1b'),
        ),
      );

      // one more pass

      await tester.rePumpWidget(
        RT_TestWidget(
          roEventRender: () => tester.push('render 1c'),
          roEventUpdate: () => tester.push('update 1c'),
          roEventAfterUnMount: () => tester.push('dispose 1c'),
        ),
      );

      tester.assertMatchStack([
        'render 1a',
        'dispose 1a',
        'render 1b',
        'dispose 1b',
        'render 1c',
      ]);
    });

    testWidgets(
      'should build new widget when runtime types of widgets are different',
      (tester) async {
        await tester.pumpWidget(
          RT_TestWidget(
            roEventRender: () => tester.push('render 1a'),
            roEventUpdate: () => tester.push('update 1a'),
            roEventAfterUnMount: () => tester.push('dispose 1a'),
          ),
        );

        await tester.rePumpWidget(
          RT_AnotherTestWidget(
            roEventRender: () => tester.push('render 1b'),
            roEventUpdate: () => tester.push('update 1b'),
            roEventAfterUnMount: () => tester.push('dispose 1b'),
          ),
        );

        // on more pass

        await tester.rePumpWidget(
          RT_TestWidget(
            roEventRender: () => tester.push('render 1c'),
            roEventUpdate: () => tester.push('update 1c'),
            roEventAfterUnMount: () => tester.push('dispose 1c'),
          ),
        );

        tester.assertMatchStack([
          'render 1a',
          'dispose 1a',
          'render 1b',
          'dispose 1b',
          'render 1c',
        ]);
      },
    );

    testWidgets(
      'should build new widget when runtime types of widgets are different '
      'even if widget keys are matched',
      (tester) async {
        await tester.pumpWidget(
          RT_TestWidget(
            key: Key('key-original'),
            roEventRender: () => tester.push('render 1a'),
            roEventUpdate: () => tester.push('update 1a'),
            roEventAfterUnMount: () => tester.push('dispose 1a'),
          ),
        );

        await tester.rePumpWidget(
          RT_AnotherTestWidget(
            key: Key('key-original'),
            roEventRender: () => tester.push('render 1b'),
            roEventUpdate: () => tester.push('update 1b'),
            roEventAfterUnMount: () => tester.push('dispose 1b'),
          ),
        );

        // on more pass

        await tester.rePumpWidget(
          RT_TestWidget(
            key: Key('key-original'),
            roEventRender: () => tester.push('render 1c'),
            roEventUpdate: () => tester.push('update 1c'),
            roEventAfterUnMount: () => tester.push('dispose 1c'),
          ),
        );

        tester.assertMatchStack([
          'render 1a',
          'dispose 1a',
          'render 1b',
          'dispose 1b',
          'render 1c',
        ]);
      },
    );

    testWidgets(
      'should build new widget when runtime types of widgets are different '
      'even if widget local keys are matched',
      (tester) async {
        await tester.pumpWidget(
          RT_TestWidget(
            key: Key('key-original'),
            roEventRender: () => tester.push('render 1a'),
            roEventUpdate: () => tester.push('update 1a'),
            roEventAfterUnMount: () => tester.push('dispose 1a'),
          ),
        );

        await tester.rePumpWidget(
          RT_AnotherTestWidget(
            key: Key('key-original'),
            roEventRender: () => tester.push('render 1b'),
            roEventUpdate: () => tester.push('update 1b'),
            roEventAfterUnMount: () => tester.push('dispose 1b'),
          ),
        );

        // on more pass

        await tester.rePumpWidget(
          RT_TestWidget(
            key: Key('key-original'),
            roEventRender: () => tester.push('render 1c'),
            roEventUpdate: () => tester.push('update 1c'),
            roEventAfterUnMount: () => tester.push('dispose 1c'),
          ),
        );

        tester.assertMatchStack([
          'render 1a',
          'dispose 1a',
          'render 1b',
          'dispose 1b',
          'render 1c',
        ]);
      },
    );

    testWidgets(
      'should build new widget when runtime types of widgets are different '
      'even if widget global keys are matched',
      (tester) async {
        await tester.pumpWidget(
          RT_TestWidget(
            key: Key('key-original'),
            roEventRender: () => tester.push('render 1a'),
            roEventUpdate: () => tester.push('update 1a'),
            roEventAfterUnMount: () => tester.push('dispose 1a'),
          ),
        );

        await tester.rePumpWidget(
          RT_AnotherTestWidget(
            key: Key('key-original'),
            roEventRender: () => tester.push('render 1b'),
            roEventUpdate: () => tester.push('update 1b'),
            roEventAfterUnMount: () => tester.push('dispose 1b'),
          ),
        );

        // one more pass

        await tester.rePumpWidget(
          RT_TestWidget(
            key: Key('key-original'),
            roEventRender: () => tester.push('render 1c'),
            roEventUpdate: () => tester.push('update 1c'),
            roEventAfterUnMount: () => tester.push('dispose 1c'),
          ),
        );

        tester.assertMatchStack([
          'render 1a',
          'dispose 1a',
          'render 1b',
          'dispose 1b',
          'render 1c',
        ]);
      },
    );

    testWidgets(
      'should rebuild widget when runtime types of widgets are matched '
      'but keys are not matched',
      (tester) async {
        await tester.pumpWidget(
          RT_TestWidget(
            key: Key('key-original'),
            roEventRender: () => tester.push('render 1a'),
            roEventUpdate: () => tester.push('update 1a'),
            roEventAfterUnMount: () => tester.push('dispose 1a'),
          ),
        );

        await tester.rePumpWidget(
          RT_TestWidget(
            key: Key('key-changed'),
            roEventRender: () => tester.push('render 1b'),
            roEventUpdate: () => tester.push('update 1b'),
            roEventAfterUnMount: () => tester.push('dispose 1b'),
          ),
        );

        // one more pass

        await tester.rePumpWidget(
          RT_TestWidget(
            key: Key('key-original'),
            roEventRender: () => tester.push('render 1c'),
            roEventUpdate: () => tester.push('update 1c'),
            roEventAfterUnMount: () => tester.push('dispose 1c'),
          ),
        );

        tester.assertMatchStack([
          'render 1a',
          'dispose 1a',
          'render 1b',
          'dispose 1b',
          'render 1c',
        ]);
      },
    );

    testWidgets(
        'should build new widget when runtime types of widgets are matched '
        'and keys are matched as well but keys have different runtime type',
        (tester) async {
      await tester.pumpWidget(
        RT_TestWidget(
          key: Key('key-original'),
          roEventRender: () => tester.push('render 1a'),
          roEventUpdate: () => tester.push('update 1a'),
          roEventAfterUnMount: () => tester.push('dispose 1a'),
        ),
      );

      await tester.rePumpWidget(
        RT_TestWidget(
          key: Key('key-original'),
          roEventRender: () => tester.push('render 1b'),
          roEventUpdate: () => tester.push('update 1b'),
          roEventAfterUnMount: () => tester.push('dispose 1b'),
        ),
      );

      await tester.rePumpWidget(
        RT_TestWidget(
          key: Key('key-original'),
          roEventRender: () => tester.push('render 1c'),
          roEventUpdate: () => tester.push('update 1c'),
          roEventAfterUnMount: () => tester.push('dispose 1c'),
        ),
      );

      tester.assertMatchStack([
        'render 1a',
        'dispose 1a',
        'render 1b',
        'update 1b',
      ]);

      // Definition of global key has changed

      // we can get the desired behaviour by internally adding a K/GKs prefix
      // to values of keys. For now I've decided to make no distinction between
      // global and normal keys other than that elements with global keys are registered
      // and can be fetched from walker service
    }, skip: true);

    // update tests

    testWidgets(
      'should update existing widget when runtime types are matched '
      'and keys are not set',
      (tester) async {
        await tester.pumpWidget(
          RT_TestWidget(
            roEventRender: () => tester.push('render 1a'),
            roEventUpdate: () => tester.push('update 1a'),
            roEventAfterUnMount: () => tester.push('dispose 1a'),
          ),
        );

        await tester.rePumpWidget(
          RT_TestWidget(
            roEventRender: () => tester.push('render 2a'),
            roEventUpdate: () => tester.push('update 2a'),
            roEventAfterUnMount: () => tester.push('dispose 2a'),
          ),
        );

        // one more pass

        await tester.rePumpWidget(
          RT_TestWidget(
            roEventRender: () => tester.push('render 3a'),
            roEventUpdate: () => tester.push('update 3a'),
            roEventAfterUnMount: () => tester.push('dispose 3a'),
          ),
        );

        tester.assertMatchStack([
          'render 1a',
          'update 1a',
          'update 1a',
        ]);
      },
    );

    testWidgets(
      'should update existing widget when both runtime types and keys are matched ',
      (tester) async {
        await tester.pumpWidget(
          RT_TestWidget(
            key: Key('key-original'),
            roEventRender: () => tester.push('render 1a'),
            roEventUpdate: () => tester.push('update 1a'),
            roEventAfterUnMount: () => tester.push('dispose 1a'),
          ),
        );

        await tester.rePumpWidget(
          RT_TestWidget(
            key: Key('key-original'),
            roEventRender: () => tester.push('render 2a'),
            roEventUpdate: () => tester.push('update 2a'),
            roEventAfterUnMount: () => tester.push('dispose 2a'),
          ),
        );

        // one more pass

        await tester.rePumpWidget(
          RT_TestWidget(
            key: Key('key-original'),
            roEventRender: () => tester.push('render 3a'),
            roEventUpdate: () => tester.push('update 3a'),
            roEventAfterUnMount: () => tester.push('dispose 3a'),
          ),
        );

        tester.assertMatchStack([
          'render 1a',
          'update 1a',
          'update 1a',
        ]);
      },
    );

    testWidgets(
      'should update existing widget when bot runtime types and local keys are matched ',
      (tester) async {
        await tester.pumpWidget(
          RT_TestWidget(
            key: Key('key-original'),
            roEventRender: () => tester.push('render 1a'),
            roEventUpdate: () => tester.push('update 1a'),
            roEventAfterUnMount: () => tester.push('dispose 1a'),
          ),
        );

        await tester.rePumpWidget(
          RT_TestWidget(
            key: Key('key-original'),
            roEventRender: () => tester.push('render 2a'),
            roEventUpdate: () => tester.push('update 2a'),
            roEventAfterUnMount: () => tester.push('dispose 2a'),
          ),
        );

        // one more pass

        await tester.rePumpWidget(
          RT_TestWidget(
            key: Key('key-original'),
            roEventRender: () => tester.push('render 3a'),
            roEventUpdate: () => tester.push('update 3a'),
            roEventAfterUnMount: () => tester.push('dispose 3a'),
          ),
        );

        tester.assertMatchStack([
          'render 1a',
          'update 1a',
          'update 1a',
        ]);
      },
    );

    testWidgets(
      'should update existing widget when bot runtime types and global keys are matched ',
      (tester) async {
        await tester.pumpWidget(
          RT_TestWidget(
            key: Key('key-original'),
            roEventRender: () => tester.push('render 1a'),
            roEventUpdate: () => tester.push('update 1a'),
            roEventAfterUnMount: () => tester.push('dispose 1a'),
          ),
        );

        await tester.rePumpWidget(
          RT_TestWidget(
            key: Key('key-original'),
            roEventRender: () => tester.push('render 2a'),
            roEventUpdate: () => tester.push('update 2a'),
            roEventAfterUnMount: () => tester.push('dispose 2a'),
          ),
        );

        // one more pass

        await tester.rePumpWidget(
          RT_TestWidget(
            key: Key('key-original'),
            roEventRender: () => tester.push('render 3a'),
            roEventUpdate: () => tester.push('update 3a'),
            roEventAfterUnMount: () => tester.push('dispose 3a'),
          ),
        );

        tester.assertMatchStack([
          'render 1a',
          'update 1a',
          'update 1a',
        ]);
      },
    );

    // flag tests under multiple child widgets

    testWidgets(
      'should not add new widget if flagAddIfNotFound: false',
      (tester) async {
        await tester.pumpMultipleWidgets([
          RT_TestWidget(
            roEventRender: () => tester.push('render 1a-1'),
            roEventUpdate: () => tester.push('update 1a-1'),
            roEventAfterUnMount: () => tester.push('dispose 1a-1'),
          ),
          RT_TestWidget(
            roEventRender: () => tester.push('render 1a-2'),
            roEventUpdate: () => tester.push('update 1a-2'),
            roEventAfterUnMount: () => tester.push('dispose 1a-2'),
          ),
        ]);

        await tester.rePumpMultipleWidgets([
          RT_AnotherTestWidget(
            roEventRender: () => tester.push('render 1b-1'),
            roEventUpdate: () => tester.push('update 1b-1'),
            roEventAfterUnMount: () => tester.push('dispose 1b-1'),
          ),
          RT_AnotherTestWidget(
            roEventRender: () => tester.push('render 1b-2'),
            roEventUpdate: () => tester.push('update 1b-2'),
            roEventAfterUnMount: () => tester.push('dispose 1b-2'),
          ),
        ], flagAddIfNotFound: false);

        await tester.rePumpMultipleWidgets([
          RT_TestWidget(
            roEventRender: () => tester.push('render 1c-1'),
            roEventUpdate: () => tester.push('update 1c-1'),
            roEventAfterUnMount: () => tester.push('dispose 1c-1'),
          ),
          RT_TestWidget(
            roEventRender: () => tester.push('render 1c-2'),
            roEventUpdate: () => tester.push('update 1c-2'),
            roEventAfterUnMount: () => tester.push('dispose 1c-2'),
          ),
        ], flagAddIfNotFound: false);

        tester.assertMatchStack([
          'render 1a-1',
          'render 1a-2',
          'dispose 1a-1',
          'dispose 1a-2',
        ]);
      },
    );

    testWidgets(
      'should add new widget if flagAddIfNotFound: true',
      (tester) async {
        await tester.pumpMultipleWidgets([
          RT_TestWidget(
            roEventRender: () => tester.push('render 1a-1'),
            roEventUpdate: () => tester.push('update 1a-1'),
            roEventAfterUnMount: () => tester.push('dispose 1a-1'),
          ),
          RT_TestWidget(
            roEventRender: () => tester.push('render 1a-2'),
            roEventUpdate: () => tester.push('update 1a-2'),
            roEventAfterUnMount: () => tester.push('dispose 1a-2'),
          ),
        ]);

        await tester.rePumpMultipleWidgets([
          RT_AnotherTestWidget(
            roEventRender: () => tester.push('render 1b-1'),
            roEventUpdate: () => tester.push('update 1b-1'),
            roEventAfterUnMount: () => tester.push('dispose 1b-1'),
          ),
          RT_AnotherTestWidget(
            roEventRender: () => tester.push('render 1b-2'),
            roEventUpdate: () => tester.push('update 1b-2'),
            roEventAfterUnMount: () => tester.push('dispose 1b-2'),
          ),
        ], flagAddIfNotFound: true);

        await tester.rePumpMultipleWidgets([
          RT_TestWidget(
            roEventRender: () => tester.push('render 1c-1'),
            roEventUpdate: () => tester.push('update 1c-1'),
            roEventAfterUnMount: () => tester.push('dispose 1c-1'),
          ),
          RT_TestWidget(
            roEventRender: () => tester.push('render 1c-2'),
            roEventUpdate: () => tester.push('update 1c-2'),
            roEventAfterUnMount: () => tester.push('dispose 1c-2'),
          ),
        ], flagAddIfNotFound: true);

        tester.assertMatchStack([
          'render 1a-1',
          'render 1a-2',
          'dispose 1a-1',
          'dispose 1a-2',
          'render 1b-1',
          'render 1b-2',
          'dispose 1b-1',
          'dispose 1b-2',
          'render 1c-1',
          'render 1c-2',
        ]);
      },
    );
  });
}
