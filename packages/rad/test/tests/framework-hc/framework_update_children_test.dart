// Copyright (c) 2022, the Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '../../test_imports.dart';

/*
|--------------------------------------------------------------------------
| Component tests for core/framework
|--------------------------------------------------------------------------
*/

void main() {
  /*
  |--------------------------------------------------------------------------
  | update children tests
  |--------------------------------------------------------------------------
  */

  group(
    'updateChildren() tests: under root(now app) context:',
    () {
      // todo: merge this group of tests with the below one.

      RT_AppRunner? app;

      setUp(() => app = createTestApp()..start());

      tearDown(() => app!.stop());

      test(
        'should build widget when runtime types of widgets are different',
        () async {
          var testStack = RT_TestStack();

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventRender: () => testStack.push('render 1'),
                roEventUpdate: () => testStack.push('update 1'),
                roEventAfterUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentRenderElement: app!.appRenderElement,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                roEventRender: () => testStack.push('render 2'),
                roEventUpdate: () => testStack.push('update 2'),
                roEventAfterUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          // do one more swap

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventRender: () => testStack.push('render 1'),
                roEventUpdate: () => testStack.push('update 1'),
                roEventAfterUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventRender: () => testStack.push('render 1'),
                roEventUpdate: () => testStack.push('update 1'),
                roEventAfterUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('render 1'));
          expect(testStack.popFromStart(), equals('dispose 1'));
          expect(testStack.popFromStart(), equals('render 2'));
          expect(testStack.popFromStart(), equals('dispose 2'));
          expect(testStack.popFromStart(), equals('render 1'));
          expect(testStack.popFromStart(), equals('update 1'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test(
        'should build widget when runtime types of widgets are different, '
        'even if widget keys are matched',
        () async {
          var testStack = RT_TestStack();

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('key-original'),
                roEventRender: () => testStack.push('render 1'),
                roEventUpdate: () => testStack.push('update 1'),
                roEventAfterUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentRenderElement: app!.appRenderElement,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                key: Key('key-original'),
                roEventRender: () => testStack.push('render 2'),
                roEventUpdate: () => testStack.push('update 2'),
                roEventAfterUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                key: Key('key-original'),
                roEventRender: () => testStack.push('render 2'),
                roEventUpdate: () => testStack.push('update 2'),
                roEventAfterUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('render 1'));
          expect(testStack.popFromStart(), equals('dispose 1'));
          expect(testStack.popFromStart(), equals('render 2'));
          expect(testStack.popFromStart(), equals('update 2'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test(
        'should build widget when runtime types of widgets are different, '
        'even if widget local keys are matched',
        () async {
          var testStack = RT_TestStack();

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('key-original'),
                roEventRender: () => testStack.push('render 1'),
                roEventUpdate: () => testStack.push('update 1'),
                roEventAfterUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentRenderElement: app!.appRenderElement,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                key: GlobalKey('key-original'),
                roEventRender: () => testStack.push('render 2'),
                roEventUpdate: () => testStack.push('update 2'),
                roEventAfterUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                key: GlobalKey('key-original'),
                roEventRender: () => testStack.push('render 2'),
                roEventUpdate: () => testStack.push('update 2'),
                roEventAfterUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('render 1'));
          expect(testStack.popFromStart(), equals('dispose 1'));
          expect(testStack.popFromStart(), equals('render 2'));
          expect(testStack.popFromStart(), equals('update 2'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test(
        'should build widget when runtime types of widgets are different, '
        'even if widget global keys are matched',
        () async {
          var testStack = RT_TestStack();

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('key-original'),
                roEventRender: () => testStack.push('render 1'),
                roEventUpdate: () => testStack.push('update 1'),
                roEventAfterUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentRenderElement: app!.appRenderElement,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                key: GlobalKey('key-original'),
                roEventRender: () => testStack.push('render 2'),
                roEventUpdate: () => testStack.push('update 2'),
                roEventAfterUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                key: GlobalKey('key-original'),
                roEventRender: () => testStack.push('render 2'),
                roEventUpdate: () => testStack.push('update 2'),
                roEventAfterUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('render 1'));
          expect(testStack.popFromStart(), equals('dispose 1'));
          expect(testStack.popFromStart(), equals('render 2'));
          expect(testStack.popFromStart(), equals('update 2'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test(
        'should build widget when runtime types of widgets are matched, '
        'but keys are not matched',
        () async {
          var testStack = RT_TestStack();

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('key-original'),
                roEventRender: () => testStack.push('render 1'),
                roEventUpdate: () => testStack.push('update 1'),
                roEventAfterUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentRenderElement: app!.appRenderElement,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('key-new'),
                roEventRender: () => testStack.push('render 2'),
                roEventUpdate: () => testStack.push('update 2'),
                roEventAfterUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('key-new'),
                roEventRender: () => testStack.push('render 2'),
                roEventUpdate: () => testStack.push('update 2'),
                roEventAfterUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('render 1'));
          expect(testStack.popFromStart(), equals('dispose 1'));
          expect(testStack.popFromStart(), equals('render 2'));
          expect(testStack.popFromStart(), equals('update 2'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test(
          'should build widget when runtime types of widgets are matched, '
          'and keys are matched as well but keys have different runtime type',
          () async {
        var testStack = RT_TestStack();

        await app!.updateChildren(
          widgets: [
            RT_TestWidget(
              key: Key('key-original'),
              roEventRender: () => testStack.push('render 1'),
              roEventUpdate: () => testStack.push('update 1'),
              roEventAfterUnMount: () => testStack.push('dispose 1'),
            ),
          ],
          updateType: UpdateType.undefined,
          parentRenderElement: app!.appRenderElement,
        );

        await app!.updateChildren(
          widgets: [
            RT_TestWidget(
              key: GlobalKey('key-original'),
              roEventRender: () => testStack.push('render 2'),
              roEventUpdate: () => testStack.push('update 2'),
              roEventAfterUnMount: () => testStack.push('dispose 2'),
            ),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        await app!.updateChildren(
          widgets: [
            RT_TestWidget(
              key: GlobalKey('key-original'),
              roEventRender: () => testStack.push('render 3'),
              roEventUpdate: () => testStack.push('update 3'),
              roEventAfterUnMount: () => testStack.push('dispose 3'),
            ),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        await app!.updateChildren(
          widgets: [
            RT_TestWidget(
              key: Key('key-original'),
              roEventRender: () => testStack.push('render 3'),
              roEventUpdate: () => testStack.push('update 3'),
              roEventAfterUnMount: () => testStack.push('dispose 3'),
            ),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        expect(testStack.popFromStart(), equals('render 1'));
        expect(testStack.popFromStart(), equals('dispose 1'));
        expect(testStack.popFromStart(), equals('render 2'));
        expect(testStack.popFromStart(), equals('update 2'));
        expect(testStack.popFromStart(), equals('dispose 2'));
        expect(testStack.popFromStart(), equals('render 3'));

        expect(testStack.canPop(), equals(false));

        // we can get the desired behaviour by internally adding a K/GKs prefix
        // to values of keys. For now I've decided to make no distinction between
        // global and normal keys other than that elements with global keys are registered
        // and can be fetched from walker service
      }, skip: 'Definition of global key has changed');

      // update tests

      test(
        'should update widget when runtime types are matched and keys not set',
        () async {
          var testStack = RT_TestStack();

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventRender: () => testStack.push('render 1'),
                roEventUpdate: () => testStack.push('update 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentRenderElement: app!.appRenderElement,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventRender: () => testStack.push('render 2'),
                roEventUpdate: () => testStack.push('update 2'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventRender: () => testStack.push('render 2'),
                roEventUpdate: () => testStack.push('update 2'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('render 1'));
          expect(testStack.popFromStart(), equals('update 1'));
          expect(testStack.popFromStart(), equals('update 1'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test(
        'should update widget when both runtime types and keys are matched',
        () async {
          var testStack = RT_TestStack();

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('key-original'),
                roEventRender: () => testStack.push('render 1'),
                roEventUpdate: () => testStack.push('update 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentRenderElement: app!.appRenderElement,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('key-original'),
                roEventRender: () => testStack.push('render 2'),
                roEventUpdate: () => testStack.push('update 2'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('key-original'),
                roEventRender: () => testStack.push('render 2'),
                roEventUpdate: () => testStack.push('update 2'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('render 1'));
          expect(testStack.popFromStart(), equals('update 1'));
          expect(testStack.popFromStart(), equals('update 1'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test(
        'should update widget when both runtime types and local keys are matched',
        () async {
          var testStack = RT_TestStack();

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('key-original'),
                roEventRender: () => testStack.push('render 1'),
                roEventUpdate: () => testStack.push('update 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentRenderElement: app!.appRenderElement,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('key-original'),
                roEventRender: () => testStack.push('render 2'),
                roEventUpdate: () => testStack.push('update 2'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('key-original'),
                roEventRender: () => testStack.push('render 2'),
                roEventUpdate: () => testStack.push('update 2'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('render 1'));
          expect(testStack.popFromStart(), equals('update 1'));
          expect(testStack.popFromStart(), equals('update 1'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test(
        'should update widget when both runtime types and global keys are matched',
        () async {
          var testStack = RT_TestStack();

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('key-original'),
                roEventRender: () => testStack.push('render 1'),
                roEventUpdate: () => testStack.push('update 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentRenderElement: app!.appRenderElement,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('key-original'),
                roEventRender: () => testStack.push('render 2'),
                roEventUpdate: () => testStack.push('update 2'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('key-original'),
                roEventRender: () => testStack.push('render 2'),
                roEventUpdate: () => testStack.push('update 2'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('render 1'));
          expect(testStack.popFromStart(), equals('update 1'));
          expect(testStack.popFromStart(), equals('update 1'));

          expect(testStack.canPop(), equals(false));
        },
      );

      // test flags

      test(
        'should dispose obsolute widgets',
        () async {
          var testStack = RT_TestStack();

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventRender: () => testStack.push('render 1'),
                roEventUpdate: () => testStack.push('update 1'),
                roEventAfterUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                roEventRender: () => testStack.push('render 2'),
                roEventUpdate: () => testStack.push('update 2'),
                roEventAfterUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventRender: () => testStack.push('render 1'),
                roEventUpdate: () => testStack.push('update 1'),
                roEventAfterUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('render 1'));
          expect(testStack.popFromStart(), equals('dispose 1'));
          expect(testStack.popFromStart(), equals('render 2'));
          expect(testStack.popFromStart(), equals('dispose 2'));
          expect(testStack.popFromStart(), equals('render 1'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test(
        'should not add new widget if '
        ': flagAddIfNotFound: false',
        () async {
          var testStack = RT_TestStack();

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventRender: () => testStack.push('render 1a'),
                roEventUpdate: () => testStack.push('update 1a'),
                roEventAfterUnMount: () => testStack.push('dispose 1a'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                roEventRender: () => testStack.push('render 1b'),
                roEventUpdate: () => testStack.push('update 1b'),
                roEventAfterUnMount: () => testStack.push('dispose 1b'),
              ),
            ],
            flagAddIfNotFound: false,
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventRender: () => testStack.push('render 2a'),
                roEventUpdate: () => testStack.push('update 2a'),
                roEventAfterUnMount: () => testStack.push('dispose 2a'),
              ),
            ],
            flagAddIfNotFound: false,
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('render 1a'));
          expect(testStack.popFromStart(), equals('dispose 1a'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test(
        'should not add new widget if '
        ': flagAddIfNotFound: true',
        () async {
          var testStack = RT_TestStack();

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventRender: () => testStack.push('render 1a'),
                roEventUpdate: () => testStack.push('update 1a'),
                roEventAfterUnMount: () => testStack.push('dispose 1a'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                roEventRender: () => testStack.push('render 1b'),
                roEventUpdate: () => testStack.push('update 1b'),
                roEventAfterUnMount: () => testStack.push('dispose 1b'),
              ),
            ],
            flagAddIfNotFound: true,
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                key: Key('another widget'),
                roEventRender: () => testStack.push('render 1c'),
                roEventUpdate: () => testStack.push('update 1c'),
                roEventAfterUnMount: () => testStack.push('dispose 1c'),
              ),
            ],
            flagAddIfNotFound: true,
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('render 1a'));
          expect(testStack.popFromStart(), equals('dispose 1a'));
          expect(testStack.popFromStart(), equals('render 1b'));
          expect(testStack.popFromStart(), equals('dispose 1b'));
          expect(testStack.popFromStart(), equals('render 1c'));

          expect(testStack.canPop(), equals(false));
        },
      );
    },
  );

  group(
    'updateChildren() tests: under app context:',
    () {
      RT_AppRunner? app;

      setUp(() => app = createTestApp()..start());

      tearDown(() => app!.stop());

      test(
        'should build widget when runtime types of widgets are different',
        () async {
          var testStack = RT_TestStack();

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventRender: () => testStack.push('render 1'),
                roEventUpdate: () => testStack.push('update 1'),
                roEventAfterUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentRenderElement: app!.appRenderElement,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                roEventRender: () => testStack.push('render 2'),
                roEventUpdate: () => testStack.push('update 2'),
                roEventAfterUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          // do one more swap

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventRender: () => testStack.push('render 1'),
                roEventUpdate: () => testStack.push('update 1'),
                roEventAfterUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventRender: () => testStack.push('render 1'),
                roEventUpdate: () => testStack.push('update 1'),
                roEventAfterUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('render 1'));
          expect(testStack.popFromStart(), equals('dispose 1'));
          expect(testStack.popFromStart(), equals('render 2'));
          expect(testStack.popFromStart(), equals('dispose 2'));
          expect(testStack.popFromStart(), equals('render 1'));
          expect(testStack.popFromStart(), equals('update 1'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test(
        'should build widget when runtime types of widgets are different, '
        'even if widget keys are matched',
        () async {
          var testStack = RT_TestStack();

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('key-original'),
                roEventRender: () => testStack.push('render 1'),
                roEventUpdate: () => testStack.push('update 1'),
                roEventAfterUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentRenderElement: app!.appRenderElement,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                key: Key('key-original'),
                roEventRender: () => testStack.push('render 2'),
                roEventUpdate: () => testStack.push('update 2'),
                roEventAfterUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                key: Key('key-original'),
                roEventRender: () => testStack.push('render 2'),
                roEventUpdate: () => testStack.push('update 2'),
                roEventAfterUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('render 1'));
          expect(testStack.popFromStart(), equals('dispose 1'));
          expect(testStack.popFromStart(), equals('render 2'));
          expect(testStack.popFromStart(), equals('update 2'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test(
        'should build widget when runtime types of widgets are different, '
        'even if widget local keys are matched',
        () async {
          var testStack = RT_TestStack();

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('key-original'),
                roEventRender: () => testStack.push('render 1'),
                roEventUpdate: () => testStack.push('update 1'),
                roEventAfterUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentRenderElement: app!.appRenderElement,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                key: GlobalKey('key-original'),
                roEventRender: () => testStack.push('render 2'),
                roEventUpdate: () => testStack.push('update 2'),
                roEventAfterUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                key: GlobalKey('key-original'),
                roEventRender: () => testStack.push('render 2'),
                roEventUpdate: () => testStack.push('update 2'),
                roEventAfterUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('render 1'));
          expect(testStack.popFromStart(), equals('dispose 1'));
          expect(testStack.popFromStart(), equals('render 2'));
          expect(testStack.popFromStart(), equals('update 2'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test(
        'should build widget when runtime types of widgets are different, '
        'even if widget global keys are matched',
        () async {
          var testStack = RT_TestStack();

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('key-original'),
                roEventRender: () => testStack.push('render 1'),
                roEventUpdate: () => testStack.push('update 1'),
                roEventAfterUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentRenderElement: app!.appRenderElement,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                key: GlobalKey('key-original'),
                roEventRender: () => testStack.push('render 2'),
                roEventUpdate: () => testStack.push('update 2'),
                roEventAfterUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                key: GlobalKey('key-original'),
                roEventRender: () => testStack.push('render 2'),
                roEventUpdate: () => testStack.push('update 2'),
                roEventAfterUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('render 1'));
          expect(testStack.popFromStart(), equals('dispose 1'));
          expect(testStack.popFromStart(), equals('render 2'));
          expect(testStack.popFromStart(), equals('update 2'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test(
        'should build widget when runtime types of widgets are matched, '
        'but keys are not matched',
        () async {
          var testStack = RT_TestStack();

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('key-original'),
                roEventRender: () => testStack.push('render 1'),
                roEventUpdate: () => testStack.push('update 1'),
                roEventAfterUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentRenderElement: app!.appRenderElement,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('key-new'),
                roEventRender: () => testStack.push('render 2'),
                roEventUpdate: () => testStack.push('update 2'),
                roEventAfterUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('key-new'),
                roEventRender: () => testStack.push('render 2'),
                roEventUpdate: () => testStack.push('update 2'),
                roEventAfterUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('render 1'));
          expect(testStack.popFromStart(), equals('dispose 1'));
          expect(testStack.popFromStart(), equals('render 2'));
          expect(testStack.popFromStart(), equals('update 2'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test(
          'should build widget when runtime types of widgets are matched, '
          'and keys are matched as well but keys have different runtime type',
          () async {
        var testStack = RT_TestStack();

        await app!.updateChildren(
          widgets: [
            RT_TestWidget(
              key: Key('key-original'),
              roEventRender: () => testStack.push('render 1'),
              roEventUpdate: () => testStack.push('update 1'),
              roEventAfterUnMount: () => testStack.push('dispose 1'),
            ),
          ],
          updateType: UpdateType.undefined,
          parentRenderElement: app!.appRenderElement,
        );

        await app!.updateChildren(
          widgets: [
            RT_TestWidget(
              key: GlobalKey('key-original'),
              roEventRender: () => testStack.push('render 2'),
              roEventUpdate: () => testStack.push('update 2'),
              roEventAfterUnMount: () => testStack.push('dispose 2'),
            ),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        await app!.updateChildren(
          widgets: [
            RT_TestWidget(
              key: GlobalKey('key-original'),
              roEventRender: () => testStack.push('render 3'),
              roEventUpdate: () => testStack.push('update 3'),
              roEventAfterUnMount: () => testStack.push('dispose 3'),
            ),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        await app!.updateChildren(
          widgets: [
            RT_TestWidget(
              key: Key('key-original'),
              roEventRender: () => testStack.push('render 3'),
              roEventUpdate: () => testStack.push('update 3'),
              roEventAfterUnMount: () => testStack.push('dispose 3'),
            ),
          ],
          parentRenderElement: app!.appRenderElement,
          updateType: UpdateType.undefined,
        );

        expect(testStack.popFromStart(), equals('render 1'));
        expect(testStack.popFromStart(), equals('dispose 1'));
        expect(testStack.popFromStart(), equals('render 2'));
        expect(testStack.popFromStart(), equals('update 2'));
        expect(testStack.popFromStart(), equals('dispose 2'));
        expect(testStack.popFromStart(), equals('render 3'));

        expect(testStack.canPop(), equals(false));

        // we can get the desired behaviour by internally adding a K/GKs prefix
        // to values of keys. For now I've decided to make no distinction between
        // global and normal keys other than that elements with global keys are
        // registered and can be fetched from walker service
      }, skip: 'Definition of global key has changed');

      // update tests

      test(
        'should update widget when runtime types are matched and keys not set',
        () async {
          var testStack = RT_TestStack();

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventRender: () => testStack.push('render 1'),
                roEventUpdate: () => testStack.push('update 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentRenderElement: app!.appRenderElement,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventRender: () => testStack.push('render 2'),
                roEventUpdate: () => testStack.push('update 2'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventRender: () => testStack.push('render 2'),
                roEventUpdate: () => testStack.push('update 2'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('render 1'));
          expect(testStack.popFromStart(), equals('update 1'));
          expect(testStack.popFromStart(), equals('update 1'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test(
        'should update widget when both runtime types and keys are matched',
        () async {
          var testStack = RT_TestStack();

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('key-original'),
                roEventRender: () => testStack.push('render 1'),
                roEventUpdate: () => testStack.push('update 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentRenderElement: app!.appRenderElement,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('key-original'),
                roEventRender: () => testStack.push('render 2'),
                roEventUpdate: () => testStack.push('update 2'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('key-original'),
                roEventRender: () => testStack.push('render 2'),
                roEventUpdate: () => testStack.push('update 2'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('render 1'));
          expect(testStack.popFromStart(), equals('update 1'));
          expect(testStack.popFromStart(), equals('update 1'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test(
        'should update widget when both runtime types and local keys are matched',
        () async {
          var testStack = RT_TestStack();

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('key-original'),
                roEventRender: () => testStack.push('render 1'),
                roEventUpdate: () => testStack.push('update 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentRenderElement: app!.appRenderElement,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('key-original'),
                roEventRender: () => testStack.push('render 2'),
                roEventUpdate: () => testStack.push('update 2'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('key-original'),
                roEventRender: () => testStack.push('render 2'),
                roEventUpdate: () => testStack.push('update 2'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('render 1'));
          expect(testStack.popFromStart(), equals('update 1'));
          expect(testStack.popFromStart(), equals('update 1'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test(
        'should update widget when both runtime types and global keys are matched',
        () async {
          var testStack = RT_TestStack();

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('key-original'),
                roEventRender: () => testStack.push('render 1'),
                roEventUpdate: () => testStack.push('update 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentRenderElement: app!.appRenderElement,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('key-original'),
                roEventRender: () => testStack.push('render 2'),
                roEventUpdate: () => testStack.push('update 2'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('key-original'),
                roEventRender: () => testStack.push('render 2'),
                roEventUpdate: () => testStack.push('update 2'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('render 1'));
          expect(testStack.popFromStart(), equals('update 1'));
          expect(testStack.popFromStart(), equals('update 1'));

          expect(testStack.canPop(), equals(false));
        },
      );

      // test flags

      test(
        'should dispose obsolute widgets',
        () async {
          var testStack = RT_TestStack();

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventRender: () => testStack.push('render 1'),
                roEventUpdate: () => testStack.push('update 1'),
                roEventAfterUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                roEventRender: () => testStack.push('render 2'),
                roEventUpdate: () => testStack.push('update 2'),
                roEventAfterUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventRender: () => testStack.push('render 1'),
                roEventUpdate: () => testStack.push('update 1'),
                roEventAfterUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('render 1'));
          expect(testStack.popFromStart(), equals('dispose 1'));
          expect(testStack.popFromStart(), equals('render 2'));
          expect(testStack.popFromStart(), equals('dispose 2'));
          expect(testStack.popFromStart(), equals('render 1'));

          expect(testStack.canPop(), equals(false));
        },
      );

      // flag tests under multiple childs

      test(
        'should dispose obsolute widgets',
        () async {
          var testStack = RT_TestStack();

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventRender: () => testStack.push('render 1'),
                roEventUpdate: () => testStack.push('update 1'),
                roEventAfterUnMount: () => testStack.push('dispose 1'),
              ),
              RT_TestWidget(
                roEventRender: () => testStack.push('render 11'),
                roEventUpdate: () => testStack.push('update 11'),
                roEventAfterUnMount: () => testStack.push('dispose 11'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                roEventRender: () => testStack.push('render 2'),
                roEventUpdate: () => testStack.push('update 2'),
                roEventAfterUnMount: () => testStack.push('dispose 2'),
              ),
              RT_AnotherTestWidget(
                roEventRender: () => testStack.push('render 22'),
                roEventUpdate: () => testStack.push('update 22'),
                roEventAfterUnMount: () => testStack.push('dispose 22'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventRender: () => testStack.push('render 1'),
                roEventUpdate: () => testStack.push('update 1'),
                roEventAfterUnMount: () => testStack.push('dispose 1'),
              ),
              RT_TestWidget(
                roEventRender: () => testStack.push('render 11'),
                roEventUpdate: () => testStack.push('update 11'),
                roEventAfterUnMount: () => testStack.push('dispose 11'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('render 1'));
          expect(testStack.popFromStart(), equals('render 11'));
          expect(testStack.popFromStart(), equals('dispose 1'));
          expect(testStack.popFromStart(), equals('dispose 11'));
          expect(testStack.popFromStart(), equals('render 2'));
          expect(testStack.popFromStart(), equals('render 22'));
          expect(testStack.popFromStart(), equals('dispose 2'));
          expect(testStack.popFromStart(), equals('dispose 22'));
          expect(testStack.popFromStart(), equals('render 1'));
          expect(testStack.popFromStart(), equals('render 11'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test(
        '(multiple) should not add new widget if '
        ': flagAddIfNotFound: false',
        () async {
          var testStack = RT_TestStack();

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventRender: () => testStack.push('render 1a-1'),
                roEventUpdate: () => testStack.push('update 1a-1'),
                roEventAfterUnMount: () => testStack.push('dispose 1a-1'),
              ),
              RT_TestWidget(
                roEventRender: () => testStack.push('render 1a-2'),
                roEventUpdate: () => testStack.push('update 1a-2'),
                roEventAfterUnMount: () => testStack.push('dispose 1a-2'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                roEventRender: () => testStack.push('render 1b-1'),
                roEventUpdate: () => testStack.push('update 1b-1'),
                roEventAfterUnMount: () => testStack.push('dispose 1b-1'),
              ),
              RT_AnotherTestWidget(
                roEventRender: () => testStack.push('render 1b-2'),
                roEventUpdate: () => testStack.push('update 1b-2'),
                roEventAfterUnMount: () => testStack.push('dispose 1b-2'),
              ),
            ],
            flagAddIfNotFound: false,
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventRender: () => testStack.push('render 2a-1'),
                roEventUpdate: () => testStack.push('update 2a-1'),
                roEventAfterUnMount: () => testStack.push('dispose 2a-1'),
              ),
              RT_TestWidget(
                roEventRender: () => testStack.push('render 2a-2'),
                roEventUpdate: () => testStack.push('update 2a-2'),
                roEventAfterUnMount: () => testStack.push('dispose 2a-2'),
              ),
            ],
            flagAddIfNotFound: false,
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('render 1a-1'));
          expect(testStack.popFromStart(), equals('render 1a-2'));
          expect(testStack.popFromStart(), equals('dispose 1a-1'));
          expect(testStack.popFromStart(), equals('dispose 1a-2'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test(
        '(multiple) should add new widget if '
        ': flagAddIfNotFound: true',
        () async {
          var testStack = RT_TestStack();

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventRender: () => testStack.push('render 1a-1'),
                roEventUpdate: () => testStack.push('update 1a-1'),
                roEventAfterUnMount: () => testStack.push('dispose 1a-1'),
              ),
              RT_TestWidget(
                roEventRender: () => testStack.push('render 1a-2'),
                roEventUpdate: () => testStack.push('update 1a-2'),
                roEventAfterUnMount: () => testStack.push('dispose 1a-2'),
              ),
              RT_TestWidget(
                roEventRender: () => testStack.push('render 1a-3'),
                roEventUpdate: () => testStack.push('update 1a-3'),
                roEventAfterUnMount: () => testStack.push('dispose 1a-3'),
              ),
            ],
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                roEventRender: () => testStack.push('render 1b-1'),
                roEventUpdate: () => testStack.push('update 1b-1'),
                roEventAfterUnMount: () => testStack.push('dispose 1b-1'),
              ),
              RT_AnotherTestWidget(
                roEventRender: () => testStack.push('render 1b-2'),
                roEventUpdate: () => testStack.push('update 1b-2'),
                roEventAfterUnMount: () => testStack.push('dispose 1b-2'),
              ),
              RT_AnotherTestWidget(
                roEventRender: () => testStack.push('render 1b-3'),
                roEventUpdate: () => testStack.push('update 1b-3'),
                roEventAfterUnMount: () => testStack.push('dispose 1b-3'),
              ),
            ],
            flagAddIfNotFound: true,
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                key: Key('another widget'),
                roEventRender: () => testStack.push('render 1c-1'),
                roEventUpdate: () => testStack.push('update 1c-1'),
                roEventAfterUnMount: () => testStack.push('dispose 1c-1'),
              ),
              RT_AnotherTestWidget(
                key: Key('another widget 2'),
                roEventRender: () => testStack.push('render 1c-2'),
                roEventUpdate: () => testStack.push('update 1c-2'),
                roEventAfterUnMount: () => testStack.push('dispose 1c-2'),
              ),
              RT_AnotherTestWidget(
                key: Key('another widget 3'),
                roEventRender: () => testStack.push('render 1c-3'),
                roEventUpdate: () => testStack.push('update 1c-3'),
                roEventAfterUnMount: () => testStack.push('dispose 1c-3'),
              ),
            ],
            flagAddIfNotFound: true,
            parentRenderElement: app!.appRenderElement,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('render 1a-1'));
          expect(testStack.popFromStart(), equals('render 1a-2'));
          expect(testStack.popFromStart(), equals('render 1a-3'));

          expect(testStack.popFromStart(), equals('dispose 1a-1'));
          expect(testStack.popFromStart(), equals('dispose 1a-2'));
          expect(testStack.popFromStart(), equals('dispose 1a-3'));
          expect(testStack.popFromStart(), equals('render 1b-1'));
          expect(testStack.popFromStart(), equals('render 1b-2'));
          expect(testStack.popFromStart(), equals('render 1b-3'));

          expect(testStack.popFromStart(), equals('dispose 1b-1'));
          expect(testStack.popFromStart(), equals('dispose 1b-2'));
          expect(testStack.popFromStart(), equals('dispose 1b-3'));
          expect(testStack.popFromStart(), equals('render 1c-1'));
          expect(testStack.popFromStart(), equals('render 1c-2'));
          expect(testStack.popFromStart(), equals('render 1c-3'));

          expect(testStack.canPop(), equals(false));
        },
      );
    },
  );
}
