import '../../test_imports.dart';

/*
|--------------------------------------------------------------------------
| Component tests for core/framework.dart
|
| Methods to test in this file: updateChildren()
|
| This is some hard coded stuff. Name of stack entries are kind of confusing
| because of the evolution in this part of framework but we're trying to 
| be more consisten with every new update.
|--------------------------------------------------------------------------
*/

void main() {
  /*
  |--------------------------------------------------------------------------
  | updateChildren tests
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
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentContext: app!.appContext,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          // do one more swap

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            parentContext: app!.appContext,
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
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentContext: app!.appContext,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                key: Key('key-original'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                key: Key('key-original'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentContext: app!.appContext,
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
                key: LocalKey('key-original'),
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentContext: app!.appContext,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                key: LocalKey('key-original'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                key: LocalKey('key-original'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentContext: app!.appContext,
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
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentContext: app!.appContext,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                key: GlobalKey('key-original'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                key: GlobalKey('key-original'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentContext: app!.appContext,
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
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentContext: app!.appContext,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('key-new'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('key-new'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentContext: app!.appContext,
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
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentContext: app!.appContext,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: LocalKey('key-original'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('key-original'),
                roEventHookRender: () => testStack.push('render 3'),
                roEventHookUpdate: () => testStack.push('update 3'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 3'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('key-original'),
                roEventHookRender: () => testStack.push('render 3'),
                roEventHookUpdate: () => testStack.push('update 3'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 3'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('key-original'),
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentContext: app!.appContext,
          );

          expect(testStack.popFromStart(), equals('render 1'));
          expect(testStack.popFromStart(), equals('dispose 1'));
          expect(testStack.popFromStart(), equals('render 2'));
          expect(testStack.popFromStart(), equals('dispose 2'));
          expect(testStack.popFromStart(), equals('render 3'));
          expect(testStack.popFromStart(), equals('update 3'));
          expect(testStack.popFromStart(), equals('dispose 3'));
          expect(testStack.popFromStart(), equals('render 1'));

          expect(testStack.canPop(), equals(false));
        },
      );

      // update tests

      test(
        'should update widget when runtime types are matched and keys not set',
        () async {
          var testStack = RT_TestStack();

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentContext: app!.appContext,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
              ),
            ],
            parentContext: app!.appContext,
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
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentContext: app!.appContext,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('key-original'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('key-original'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
              ),
            ],
            parentContext: app!.appContext,
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
                key: LocalKey('key-original'),
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentContext: app!.appContext,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: LocalKey('key-original'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: LocalKey('key-original'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
              ),
            ],
            parentContext: app!.appContext,
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
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentContext: app!.appContext,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('key-original'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('key-original'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
              ),
            ],
            parentContext: app!.appContext,
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
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            parentContext: app!.appContext,
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
                roEventHookRender: () => testStack.push('render 1a'),
                roEventHookUpdate: () => testStack.push('update 1a'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1a'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                roEventHookRender: () => testStack.push('render 1b'),
                roEventHookUpdate: () => testStack.push('update 1b'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1b'),
              ),
            ],
            flagAddIfNotFound: false,
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 2a'),
                roEventHookUpdate: () => testStack.push('update 2a'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2a'),
              ),
            ],
            flagAddIfNotFound: false,
            parentContext: app!.appContext,
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
                roEventHookRender: () => testStack.push('render 1a'),
                roEventHookUpdate: () => testStack.push('update 1a'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1a'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                roEventHookRender: () => testStack.push('render 1b'),
                roEventHookUpdate: () => testStack.push('update 1b'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1b'),
              ),
            ],
            flagAddIfNotFound: true,
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                key: Key('another widget'),
                roEventHookRender: () => testStack.push('render 1c'),
                roEventHookUpdate: () => testStack.push('update 1c'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1c'),
              ),
            ],
            flagAddIfNotFound: true,
            parentContext: app!.appContext,
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
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentContext: app!.appContext,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          // do one more swap

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            parentContext: app!.appContext,
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
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentContext: app!.appContext,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                key: Key('key-original'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                key: Key('key-original'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentContext: app!.appContext,
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
                key: LocalKey('key-original'),
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentContext: app!.appContext,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                key: LocalKey('key-original'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                key: LocalKey('key-original'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentContext: app!.appContext,
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
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentContext: app!.appContext,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                key: GlobalKey('key-original'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                key: GlobalKey('key-original'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentContext: app!.appContext,
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
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentContext: app!.appContext,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('key-new'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('key-new'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentContext: app!.appContext,
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
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentContext: app!.appContext,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: LocalKey('key-original'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('key-original'),
                roEventHookRender: () => testStack.push('render 3'),
                roEventHookUpdate: () => testStack.push('update 3'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 3'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('key-original'),
                roEventHookRender: () => testStack.push('render 3'),
                roEventHookUpdate: () => testStack.push('update 3'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 3'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('key-original'),
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentContext: app!.appContext,
          );

          expect(testStack.popFromStart(), equals('render 1'));
          expect(testStack.popFromStart(), equals('dispose 1'));
          expect(testStack.popFromStart(), equals('render 2'));
          expect(testStack.popFromStart(), equals('dispose 2'));
          expect(testStack.popFromStart(), equals('render 3'));
          expect(testStack.popFromStart(), equals('update 3'));
          expect(testStack.popFromStart(), equals('dispose 3'));
          expect(testStack.popFromStart(), equals('render 1'));

          expect(testStack.canPop(), equals(false));
        },
      );

      // update tests

      test(
        'should update widget when runtime types are matched and keys not set',
        () async {
          var testStack = RT_TestStack();

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentContext: app!.appContext,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
              ),
            ],
            parentContext: app!.appContext,
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
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentContext: app!.appContext,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('key-original'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('key-original'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
              ),
            ],
            parentContext: app!.appContext,
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
                key: LocalKey('key-original'),
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentContext: app!.appContext,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: LocalKey('key-original'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: LocalKey('key-original'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
              ),
            ],
            parentContext: app!.appContext,
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
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentContext: app!.appContext,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('key-original'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('key-original'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
              ),
            ],
            parentContext: app!.appContext,
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
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            parentContext: app!.appContext,
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
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1'),
              ),
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 11'),
                roEventHookUpdate: () => testStack.push('update 11'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 11'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2'),
              ),
              RT_AnotherTestWidget(
                roEventHookRender: () => testStack.push('render 22'),
                roEventHookUpdate: () => testStack.push('update 22'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 22'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1'),
              ),
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 11'),
                roEventHookUpdate: () => testStack.push('update 11'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 11'),
              ),
            ],
            parentContext: app!.appContext,
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
                roEventHookRender: () => testStack.push('render 1a-1'),
                roEventHookUpdate: () => testStack.push('update 1a-1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1a-1'),
              ),
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 1a-2'),
                roEventHookUpdate: () => testStack.push('update 1a-2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1a-2'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                roEventHookRender: () => testStack.push('render 1b-1'),
                roEventHookUpdate: () => testStack.push('update 1b-1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1b-1'),
              ),
              RT_AnotherTestWidget(
                roEventHookRender: () => testStack.push('render 1b-2'),
                roEventHookUpdate: () => testStack.push('update 1b-2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1b-2'),
              ),
            ],
            flagAddIfNotFound: false,
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 2a-1'),
                roEventHookUpdate: () => testStack.push('update 2a-1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2a-1'),
              ),
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 2a-2'),
                roEventHookUpdate: () => testStack.push('update 2a-2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2a-2'),
              ),
            ],
            flagAddIfNotFound: false,
            parentContext: app!.appContext,
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
                roEventHookRender: () => testStack.push('render 1a-1'),
                roEventHookUpdate: () => testStack.push('update 1a-1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1a-1'),
              ),
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 1a-2'),
                roEventHookUpdate: () => testStack.push('update 1a-2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1a-2'),
              ),
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 1a-3'),
                roEventHookUpdate: () => testStack.push('update 1a-3'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1a-3'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                roEventHookRender: () => testStack.push('render 1b-1'),
                roEventHookUpdate: () => testStack.push('update 1b-1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1b-1'),
              ),
              RT_AnotherTestWidget(
                roEventHookRender: () => testStack.push('render 1b-2'),
                roEventHookUpdate: () => testStack.push('update 1b-2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1b-2'),
              ),
              RT_AnotherTestWidget(
                roEventHookRender: () => testStack.push('render 1b-3'),
                roEventHookUpdate: () => testStack.push('update 1b-3'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1b-3'),
              ),
            ],
            flagAddIfNotFound: true,
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          await app!.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                key: Key('another widget'),
                roEventHookRender: () => testStack.push('render 1c-1'),
                roEventHookUpdate: () => testStack.push('update 1c-1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1c-1'),
              ),
              RT_AnotherTestWidget(
                key: Key('another widget 2'),
                roEventHookRender: () => testStack.push('render 1c-2'),
                roEventHookUpdate: () => testStack.push('update 1c-2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1c-2'),
              ),
              RT_AnotherTestWidget(
                key: Key('another widget 3'),
                roEventHookRender: () => testStack.push('render 1c-3'),
                roEventHookUpdate: () => testStack.push('update 1c-3'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1c-3'),
              ),
            ],
            flagAddIfNotFound: true,
            parentContext: app!.appContext,
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
