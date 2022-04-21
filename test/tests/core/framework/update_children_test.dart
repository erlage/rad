import 'package:rad/rad.dart';
import 'package:test/scaffolding.dart';
import 'package:test/expect.dart';

import '../../../fixers/test_app.dart';
import '../../../fixers/test_bed.dart';
import '../../../fixers/test_stack.dart';
import '../../../fixers/test_widget.dart';

/*
|--------------------------------------------------------------------------
| Component tests for core/framework.dart
|
| Methods to test in this file: updateChildren()
|--------------------------------------------------------------------------
*/

void main() {
  /*
  |--------------------------------------------------------------------------
  | updateChildren tests
  |--------------------------------------------------------------------------
  */

  group(
    'updateChildren() tests:',
    () {
      RT_AppRunner? app;

      setUp(() => app = createTestApp()..start());

      tearDown(() => app!.stop());

      test(
        'should build widget when runtime types of widgets are different',
        () {
          var testStack = RT_TestStack();

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentContext: RT_TestBed.rootContext,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentContext: RT_TestBed.rootContext,
            updateType: UpdateType.undefined,
          );

          // do one more swap

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            parentContext: RT_TestBed.rootContext,
            updateType: UpdateType.undefined,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            parentContext: RT_TestBed.rootContext,
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
        'should build widget when runtime types of widgets are different,'
        'even if widget keys are matched',
        () {
          var testStack = RT_TestStack();

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('key-original'),
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentContext: RT_TestBed.rootContext,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                key: Key('key-original'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentContext: RT_TestBed.rootContext,
            updateType: UpdateType.undefined,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                key: Key('key-original'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentContext: RT_TestBed.rootContext,
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
        'should build widget when runtime types of widgets are different,'
        'even if widget local keys are matched',
        () {
          var testStack = RT_TestStack();

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                key: LocalKey('key-original'),
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentContext: RT_TestBed.rootContext,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                key: LocalKey('key-original'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentContext: RT_TestBed.rootContext,
            updateType: UpdateType.undefined,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                key: LocalKey('key-original'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentContext: RT_TestBed.rootContext,
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
        'should build widget when runtime types of widgets are different,'
        'even if widget global keys are matched',
        () {
          var testStack = RT_TestStack();

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('key-original'),
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentContext: RT_TestBed.rootContext,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                key: GlobalKey('key-original'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentContext: RT_TestBed.rootContext,
            updateType: UpdateType.undefined,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                key: GlobalKey('key-original'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentContext: RT_TestBed.rootContext,
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
        'should build widget when runtime types of widgets are matched,'
        'but keys are not matched',
        () {
          var testStack = RT_TestStack();

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('key-original'),
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentContext: RT_TestBed.rootContext,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('key-new'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentContext: RT_TestBed.rootContext,
            updateType: UpdateType.undefined,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('key-new'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentContext: RT_TestBed.rootContext,
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
        'should build widget when runtime types of widgets are matched,'
        'and keys are matched as well but keys have different runtime type',
        () {
          var testStack = RT_TestStack();

          // Failing to distinguish LocalKey and Key.
          // (see key gen tests)

          // app!.framework.updateChildren(
          //   widgets: [
          //     RT_TestWidget(
          //       key: Key('key-original'),
          //       roEventHookRender: () => testStack.push('render 1'),
          //       roEventHookUpdate: () => testStack.push('update 1'),
          //       roEventHookBeforeUnMount: () => testStack.push('dispose 1'),
          //     ),
          //   ],
          //   updateType: UpdateType.undefined,
          //   parentContext: RT_TestBed.rootContext,
          // );

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                key: LocalKey('key-original'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            parentContext: RT_TestBed.rootContext,
            updateType: UpdateType.undefined,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('key-original'),
                roEventHookRender: () => testStack.push('render 3'),
                roEventHookUpdate: () => testStack.push('update 3'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 3'),
              ),
            ],
            parentContext: RT_TestBed.rootContext,
            updateType: UpdateType.undefined,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('key-original'),
                roEventHookRender: () => testStack.push('render 3'),
                roEventHookUpdate: () => testStack.push('update 3'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 3'),
              ),
            ],
            parentContext: RT_TestBed.rootContext,
            updateType: UpdateType.undefined,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('key-original'),
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentContext: RT_TestBed.rootContext,
          );

          // expect(testStack.popFromStart(), equals('render 1'));
          // expect(testStack.popFromStart(), equals('dispose 1'));
          expect(testStack.popFromStart(), equals('render 2'));
          expect(testStack.popFromStart(), equals('dispose 2'));
          expect(testStack.popFromStart(), equals('render 3'));
          expect(testStack.popFromStart(), equals('update 3'));
          expect(testStack.popFromStart(), equals('dispose 3'));
          expect(testStack.popFromStart(), equals('render 1'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test(
        '(nested) should build widget when runtime types of widgets are matched,'
        'and keys are matched as well but keys have different runtime type',
        () {
          var testStack = RT_TestStack();

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(children: [
                RT_TestWidget(
                  key: Key('key-original'),
                  roEventHookRender: () => testStack.push('render 1'),
                  roEventHookUpdate: () => testStack.push('update 1'),
                  roEventHookBeforeUnMount: () => testStack.push('dispose 1'),
                ),
              ]),
            ],
            updateType: UpdateType.undefined,
            parentContext: RT_TestBed.rootContext,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(children: [
                RT_TestWidget(
                  key: LocalKey('key-original'),
                  roEventHookRender: () => testStack.push('render 2'),
                  roEventHookUpdate: () => testStack.push('update 2'),
                  roEventHookBeforeUnMount: () => testStack.push('dispose 2'),
                ),
              ]),
            ],
            parentContext: RT_TestBed.rootContext,
            updateType: UpdateType.undefined,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(children: [
                RT_TestWidget(
                  key: GlobalKey('key-original'),
                  roEventHookRender: () => testStack.push('render 3'),
                  roEventHookUpdate: () => testStack.push('update 3'),
                  roEventHookBeforeUnMount: () => testStack.push('dispose 3'),
                ),
              ]),
            ],
            parentContext: RT_TestBed.rootContext,
            updateType: UpdateType.undefined,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(children: [
                RT_TestWidget(
                  key: GlobalKey('key-original'),
                  roEventHookRender: () => testStack.push('render 3'),
                  roEventHookUpdate: () => testStack.push('update 3'),
                  roEventHookBeforeUnMount: () => testStack.push('dispose 3'),
                ),
              ]),
            ],
            parentContext: RT_TestBed.rootContext,
            updateType: UpdateType.undefined,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(children: [
                RT_TestWidget(
                  key: Key('key-original'),
                  roEventHookRender: () => testStack.push('render 1'),
                  roEventHookUpdate: () => testStack.push('update 1'),
                  roEventHookBeforeUnMount: () => testStack.push('dispose 1'),
                ),
              ]),
            ],
            updateType: UpdateType.undefined,
            parentContext: RT_TestBed.rootContext,
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
        () {
          var testStack = RT_TestStack();

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentContext: RT_TestBed.rootContext,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
              ),
            ],
            parentContext: RT_TestBed.rootContext,
            updateType: UpdateType.undefined,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
              ),
            ],
            parentContext: RT_TestBed.rootContext,
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
        () {
          var testStack = RT_TestStack();

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('key-original'),
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentContext: RT_TestBed.rootContext,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('key-original'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
              ),
            ],
            parentContext: RT_TestBed.rootContext,
            updateType: UpdateType.undefined,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                key: Key('key-original'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
              ),
            ],
            parentContext: RT_TestBed.rootContext,
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
        () {
          var testStack = RT_TestStack();

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                key: LocalKey('key-original'),
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentContext: RT_TestBed.rootContext,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                key: LocalKey('key-original'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
              ),
            ],
            parentContext: RT_TestBed.rootContext,
            updateType: UpdateType.undefined,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                key: LocalKey('key-original'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
              ),
            ],
            parentContext: RT_TestBed.rootContext,
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
        () {
          var testStack = RT_TestStack();

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('key-original'),
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
              ),
            ],
            updateType: UpdateType.undefined,
            parentContext: RT_TestBed.rootContext,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('key-original'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
              ),
            ],
            parentContext: RT_TestBed.rootContext,
            updateType: UpdateType.undefined,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('key-original'),
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
              ),
            ],
            parentContext: RT_TestBed.rootContext,
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
        'should not dispose obsolute widget if'
        ': flagDisposeObsoluteChildren: false',
        () {
          var testStack = RT_TestStack();

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            parentContext: RT_TestBed.rootContext,
            updateType: UpdateType.undefined,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            flagDisposeObsoluteChildren: false,
            parentContext: RT_TestBed.rootContext,
            updateType: UpdateType.undefined,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            flagDisposeObsoluteChildren: false,
            parentContext: RT_TestBed.rootContext,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('render 1'));
          expect(testStack.popFromStart(), equals('render 2'));
          expect(testStack.popFromStart(), equals('update 1'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test(
        'should dispose obsolute widget if'
        ': flagDisposeObsoluteChildren: true',
        () {
          var testStack = RT_TestStack();

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            parentContext: RT_TestBed.rootContext,
            updateType: UpdateType.undefined,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            flagDisposeObsoluteChildren: true,
            parentContext: RT_TestBed.rootContext,
            updateType: UpdateType.undefined,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            flagDisposeObsoluteChildren: true,
            parentContext: RT_TestBed.rootContext,
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
        'should not add new widget if'
        ': flagAddIfNotFound: false'
        ': flagDisposeObsoluteChildren: false',
        () {
          var testStack = RT_TestStack();

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            parentContext: RT_TestBed.rootContext,
            updateType: UpdateType.undefined,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            flagAddIfNotFound: false,
            flagDisposeObsoluteChildren: false,
            parentContext: RT_TestBed.rootContext,
            updateType: UpdateType.undefined,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            flagAddIfNotFound: false,
            flagDisposeObsoluteChildren: false,
            parentContext: RT_TestBed.rootContext,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('render 1'));
          expect(testStack.popFromStart(), equals('update 1'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test(
        'should not add new widget if'
        ': flagAddIfNotFound: true'
        ': flagDisposeObsoluteChildren: false',
        () {
          var testStack = RT_TestStack();

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 1'),
                roEventHookUpdate: () => testStack.push('update 1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1'),
              ),
            ],
            parentContext: RT_TestBed.rootContext,
            updateType: UpdateType.undefined,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                roEventHookRender: () => testStack.push('render 2'),
                roEventHookUpdate: () => testStack.push('update 2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2'),
              ),
            ],
            flagAddIfNotFound: true,
            flagDisposeObsoluteChildren: false,
            parentContext: RT_TestBed.rootContext,
            updateType: UpdateType.undefined,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                key: Key('another widget'),
                roEventHookRender: () => testStack.push('render 3'),
                roEventHookUpdate: () => testStack.push('update 3'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 3'),
              ),
            ],
            flagAddIfNotFound: true,
            flagDisposeObsoluteChildren: false,
            parentContext: RT_TestBed.rootContext,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('render 1'));
          expect(testStack.popFromStart(), equals('render 2'));
          expect(testStack.popFromStart(), equals('render 3'));

          expect(testStack.canPop(), equals(false));
        },
      );

      // flag tests under multiple childs

      test(
        'should not dispose obsolute widget if'
        ': flagDisposeObsoluteChildren: false',
        () {
          var testStack = RT_TestStack();

          app!.framework.updateChildren(
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
            parentContext: RT_TestBed.rootContext,
            updateType: UpdateType.undefined,
          );

          app!.framework.updateChildren(
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
            flagDisposeObsoluteChildren: false,
            parentContext: RT_TestBed.rootContext,
            updateType: UpdateType.undefined,
          );

          app!.framework.updateChildren(
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
            flagDisposeObsoluteChildren: false,
            parentContext: RT_TestBed.rootContext,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('render 1'));
          expect(testStack.popFromStart(), equals('render 11'));
          expect(testStack.popFromStart(), equals('render 2'));
          expect(testStack.popFromStart(), equals('render 22'));
          expect(testStack.popFromStart(), equals('update 1'));
          expect(testStack.popFromStart(), equals('update 11'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test(
        'should dispose obsolute widget if'
        ': flagDisposeObsoluteChildren: true',
        () {
          var testStack = RT_TestStack();

          app!.framework.updateChildren(
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
            parentContext: RT_TestBed.rootContext,
            updateType: UpdateType.undefined,
          );

          app!.framework.updateChildren(
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
            flagDisposeObsoluteChildren: true,
            parentContext: RT_TestBed.rootContext,
            updateType: UpdateType.undefined,
          );

          app!.framework.updateChildren(
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
            flagDisposeObsoluteChildren: true,
            parentContext: RT_TestBed.rootContext,
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
        '(multiple) should not add new widget if'
        ': flagAddIfNotFound: false'
        ': flagDisposeObsoluteChildren: false',
        () {
          var testStack = RT_TestStack();

          app!.framework.updateChildren(
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
            parentContext: RT_TestBed.rootContext,
            updateType: UpdateType.undefined,
          );

          app!.framework.updateChildren(
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
            flagAddIfNotFound: false,
            flagDisposeObsoluteChildren: false,
            parentContext: RT_TestBed.rootContext,
            updateType: UpdateType.undefined,
          );

          app!.framework.updateChildren(
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
            flagAddIfNotFound: false,
            flagDisposeObsoluteChildren: false,
            parentContext: RT_TestBed.rootContext,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('render 1'));
          expect(testStack.popFromStart(), equals('render 11'));
          expect(testStack.popFromStart(), equals('update 1'));
          expect(testStack.popFromStart(), equals('update 11'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test(
        '(multiple) should not add new widget if'
        ': flagAddIfNotFound: true'
        ': flagDisposeObsoluteChildren: false',
        () {
          var testStack = RT_TestStack();

          app!.framework.updateChildren(
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
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 111'),
                roEventHookUpdate: () => testStack.push('update 111'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 111'),
              ),
            ],
            parentContext: RT_TestBed.rootContext,
            updateType: UpdateType.undefined,
          );

          app!.framework.updateChildren(
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
              RT_AnotherTestWidget(
                roEventHookRender: () => testStack.push('render 222'),
                roEventHookUpdate: () => testStack.push('update 222'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 222'),
              ),
            ],
            flagAddIfNotFound: true,
            flagDisposeObsoluteChildren: false,
            parentContext: RT_TestBed.rootContext,
            updateType: UpdateType.undefined,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                key: Key('another widget'),
                roEventHookRender: () => testStack.push('render 3'),
                roEventHookUpdate: () => testStack.push('update 3'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 3'),
              ),
              RT_AnotherTestWidget(
                key: Key('another widget 2'),
                roEventHookRender: () => testStack.push('render 33'),
                roEventHookUpdate: () => testStack.push('update 33'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 33'),
              ),
              RT_AnotherTestWidget(
                key: Key('another widget 3'),
                roEventHookRender: () => testStack.push('render 333'),
                roEventHookUpdate: () => testStack.push('update 333'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 333'),
              ),
            ],
            flagAddIfNotFound: true,
            flagDisposeObsoluteChildren: false,
            parentContext: RT_TestBed.rootContext,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('render 1'));
          expect(testStack.popFromStart(), equals('render 11'));
          expect(testStack.popFromStart(), equals('render 111'));
          expect(testStack.popFromStart(), equals('render 2'));
          expect(testStack.popFromStart(), equals('render 22'));
          expect(testStack.popFromStart(), equals('render 222'));
          expect(testStack.popFromStart(), equals('render 3'));
          expect(testStack.popFromStart(), equals('render 33'));
          expect(testStack.popFromStart(), equals('render 333'));

          expect(testStack.canPop(), equals(false));
        },
      );
    },
  );
}
