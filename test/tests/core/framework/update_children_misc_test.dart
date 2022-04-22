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
|
| These are some important test that should be kept in separate as
| original file(update_children_test.dart) is already grown very large.
|--------------------------------------------------------------------------
*/

void main() {
  /*
  |--------------------------------------------------------------------------
  | updateChildren tests
  |--------------------------------------------------------------------------
  */

  group(
    'updateChildren() misc tests:',
    () {
      RT_AppRunner? app;

      setUp(() => app = createTestApp()..startWithAppWidget());

      tearDown(() => app!.stop());

      test(
        'should not create new configuration if configuration has not changed',
        () {
          var testStack = RT_TestStack();

          app!.framework.buildChildren(
            widgets: [
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 1a'),
                roEventHookUpdate: () => testStack.push('update 1a'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1a'),
                wEventHookIsConfigurationChanged: () => testStack.push(
                  'is changed 1a',
                ),
                wEventHookCreateWidgetConfiguration: () => testStack.push(
                  'create config 1a',
                ),
                wOverrideIsConfigurationChanged: () => false,
              ),
            ],
            parentContext: RT_TestBed.rootContext,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 2a'),
                roEventHookUpdate: () => testStack.push('update 2a'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2a'),
                wEventHookIsConfigurationChanged: () => testStack.push(
                  'is changed 2a',
                ),
                wEventHookCreateWidgetConfiguration: () => testStack.push(
                  'create config 2a',
                ),
                wOverrideIsConfigurationChanged: () => false,
              ),
            ],
            parentContext: RT_TestBed.rootContext,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('create config 1a'));
          expect(testStack.popFromStart(), equals('render 1a'));

          expect(testStack.popFromStart(), equals('is changed 2a'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test(
        'should create new configuration if configuration has changed',
        () {
          var testStack = RT_TestStack();

          app!.framework.buildChildren(
            widgets: [
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 1a'),
                roEventHookUpdate: () => testStack.push('update 1a'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1a'),
                wEventHookIsConfigurationChanged: () => testStack.push(
                  'is changed 1a',
                ),
                wEventHookCreateWidgetConfiguration: () => testStack.push(
                  'create config 1a',
                ),
                wOverrideIsConfigurationChanged: () => true,
              ),
            ],
            parentContext: RT_TestBed.rootContext,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 2a'),
                roEventHookUpdate: () => testStack.push('update 2a'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2a'),
                wEventHookIsConfigurationChanged: () => testStack.push(
                  'is changed 2a',
                ),
                wEventHookCreateWidgetConfiguration: () => testStack.push(
                  'create config 2a',
                ),
                wOverrideIsConfigurationChanged: () => true,
              ),
            ],
            parentContext: RT_TestBed.rootContext,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('create config 1a'));
          expect(testStack.popFromStart(), equals('render 1a'));
          expect(testStack.popFromStart(), equals('is changed 2a'));
          expect(testStack.popFromStart(), equals('create config 2a'));
          expect(testStack.popFromStart(), equals('update 1a'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test(
        'should never re create a render object',
        () {
          var testStack = RT_TestStack();

          app!.framework.buildChildren(
            widgets: [
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 1a'),
                roEventHookUpdate: () => testStack.push('update 1a'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1a'),
                wEventHookIsConfigurationChanged: () => testStack.push(
                  'is changed 1a',
                ),
                wEventHookCreateWidgetConfiguration: () => testStack.push(
                  'create config 1a',
                ),
                wOverrideIsConfigurationChanged: () => true,
              ),
            ],
            parentContext: RT_TestBed.rootContext,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 2a'),
                roEventHookUpdate: () => testStack.push('update 2a'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2a'),
                wEventHookIsConfigurationChanged: () => testStack.push(
                  'is changed 2a',
                ),
                wEventHookCreateWidgetConfiguration: () => testStack.push(
                  'create config 2a',
                ),
                wOverrideIsConfigurationChanged: () => true,
              ),
            ],
            parentContext: RT_TestBed.rootContext,
            updateType: UpdateType.undefined,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 3a'),
                roEventHookUpdate: () => testStack.push('update 3a'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 3a'),
                wEventHookIsConfigurationChanged: () => testStack.push(
                  'is changed 3a',
                ),
                wEventHookCreateWidgetConfiguration: () => testStack.push(
                  'create config 3a',
                ),
                wOverrideIsConfigurationChanged: () => true,
              ),
            ],
            parentContext: RT_TestBed.rootContext,
            updateType: UpdateType.undefined,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 4a'),
                roEventHookUpdate: () => testStack.push('update 4a'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 4a'),
                wEventHookIsConfigurationChanged: () => testStack.push(
                  'is changed 4a',
                ),
                wEventHookCreateWidgetConfiguration: () => testStack.push(
                  'create config 4a',
                ),
                wOverrideIsConfigurationChanged: () => false,
              ),
            ],
            parentContext: RT_TestBed.rootContext,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('create config 1a'));
          expect(testStack.popFromStart(), equals('render 1a'));

          expect(testStack.popFromStart(), equals('is changed 2a'));
          expect(testStack.popFromStart(), equals('create config 2a'));
          expect(testStack.popFromStart(), equals('update 1a'));

          expect(testStack.popFromStart(), equals('is changed 3a'));
          expect(testStack.popFromStart(), equals('create config 3a'));
          expect(testStack.popFromStart(), equals('update 1a'));

          expect(testStack.popFromStart(), equals('is changed 4a'));

          expect(testStack.canPop(), equals(false));
        },
      );

      //
    },
  );
}
