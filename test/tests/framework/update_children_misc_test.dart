import '../../test_imports.dart';

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

      setUp(() => app = createTestApp()..start());

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
            parentContext: app!.appContext,
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
            parentContext: app!.appContext,
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
            parentContext: app!.appContext,
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
            parentContext: app!.appContext,
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
            parentContext: app!.appContext,
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
            parentContext: app!.appContext,
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
            parentContext: app!.appContext,
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
            parentContext: app!.appContext,
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

      test(
        'should not rebind a widget instance '
        'if widget configuration has not changed',
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
                roEventHookAfterWidgetRebind: () => testStack.push(
                  'rebind widget 1a',
                ),
                wOverrideIsConfigurationChanged: () => true,
              ),
            ],
            parentContext: app!.appContext,
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
                roEventHookAfterWidgetRebind: () => testStack.push(
                  'rebind widget 2a',
                ),
                wOverrideIsConfigurationChanged: () => false,
              ),
            ],
            updateType: UpdateType.undefined,
            parentContext: app!.appContext,
          );

          expect(testStack.popFromStart(), equals('create config 1a'));
          expect(testStack.popFromStart(), equals('render 1a'));

          expect(testStack.popFromStart(), equals('is changed 2a'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test(
        'should  rebind a widget instance '
        'if widget configuration has changed',
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
                roEventHookAfterWidgetRebind: () => testStack.push(
                  'rebind widget 1a',
                ),
                wOverrideIsConfigurationChanged: () => true,
              ),
            ],
            parentContext: app!.appContext,
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
                roEventHookAfterWidgetRebind: () => testStack.push(
                  'rebind widget 2a',
                ),
                wOverrideIsConfigurationChanged: () => true,
              ),
            ],
            updateType: UpdateType.undefined,
            parentContext: app!.appContext,
          );

          expect(testStack.popFromStart(), equals('create config 1a'));
          expect(testStack.popFromStart(), equals('render 1a'));

          expect(testStack.popFromStart(), equals('is changed 2a'));
          expect(testStack.popFromStart(), equals('create config 2a'));

          expect(testStack.popFromStart(), equals('rebind widget 1a'));
          expect(testStack.popFromStart(), equals('update 1a'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test(
        'should  rebind a widget instance (instance test)'
        'if widget configuration has changed',
        () {
          var testStack = RT_TestStack();

          app!.framework.buildChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('widget'),
                customHash: 'original-instance',
                roEventHookRender: () => testStack.push('render 1a'),
                roEventHookUpdate: () => testStack.push('update 1a'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1a'),
                wEventHookIsConfigurationChanged: () => testStack.push(
                  'is changed 1a',
                ),
                wEventHookCreateWidgetConfiguration: () => testStack.push(
                  'create config 1a',
                ),
                roEventHookAfterWidgetRebind: () {
                  testStack.push(
                    'rebind widget 1a',
                  );

                  var widgetObject =
                      app!.services.walker.getWidgetObjectUsingKey(
                    'widget',
                  )!;

                  var hash = (widgetObject.widget as RT_TestWidget).hash;

                  expect(hash, equals('new-instance'));
                },
                wOverrideIsConfigurationChanged: () => true,
              ),
            ],
            parentContext: app!.appContext,
          );

          var widgetObject = app!.services.walker.getWidgetObjectUsingKey(
            'widget',
          )!;

          var hash = (widgetObject.widget as RT_TestWidget).hash;

          expect(hash, equals('original-instance'));

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('widget'),
                customHash: 'new-instance',
                roEventHookRender: () => testStack.push('render 2a'),
                roEventHookUpdate: () => testStack.push('update 2a'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2a'),
                wEventHookIsConfigurationChanged: () => testStack.push(
                  'is changed 2a',
                ),
                wEventHookCreateWidgetConfiguration: () => testStack.push(
                  'create config 2a',
                ),
                roEventHookAfterWidgetRebind: () => testStack.push(
                  'rebind widget 2a',
                ),
                wOverrideIsConfigurationChanged: () => true,
              ),
            ],
            updateType: UpdateType.undefined,
            parentContext: app!.appContext,
          );

          expect(testStack.popFromStart(), equals('create config 1a'));
          expect(testStack.popFromStart(), equals('render 1a'));

          expect(testStack.popFromStart(), equals('is changed 2a'));
          expect(testStack.popFromStart(), equals('create config 2a'));

          expect(testStack.popFromStart(), equals('rebind widget 1a'));
          expect(testStack.popFromStart(), equals('update 1a'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test('should check childs if parent configuration is changed', () {
        var testStack = RT_TestStack();

        app!.framework.buildChildren(
          widgets: [
            RT_TestWidget(
              roEventHookRender: () => testStack.push('render parent'),
              roEventHookUpdate: () => testStack.push('update parent'),
              wOverrideIsConfigurationChanged: () => true,
              children: [
                RT_TestWidget(
                  roEventHookRender: () => testStack.push('render child'),
                  roEventHookUpdate: () => testStack.push('update child'),
                )
              ],
            ),
          ],
          parentContext: app!.appContext,
        );

        app!.framework.updateChildren(
          widgets: [
            RT_TestWidget(
              roEventHookRender: () => testStack.push('render parent'),
              roEventHookUpdate: () => testStack.push('update parent'),
              wOverrideIsConfigurationChanged: () => true,
              children: [
                RT_TestWidget(
                  roEventHookRender: () => testStack.push('render child'),
                  roEventHookUpdate: () => testStack.push('update child'),
                )
              ],
            ),
          ],
          updateType: UpdateType.setState,
          parentContext: app!.appContext,
        );

        expect(testStack.popFromStart(), equals('render parent'));
        expect(testStack.popFromStart(), equals('render child'));
        expect(testStack.popFromStart(), equals('update parent'));
        expect(testStack.popFromStart(), equals('update child'));

        expect(testStack.canPop(), equals(false));
      });

      test(
        'should check childs even if parent configuration is not changed',
        () {
          var testStack = RT_TestStack();

          app!.framework.buildChildren(
            widgets: [
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render parent'),
                roEventHookUpdate: () => testStack.push('update parent'),
                wOverrideIsConfigurationChanged: () => false,
                children: [
                  RT_TestWidget(
                    roEventHookRender: () => testStack.push('render child'),
                    roEventHookUpdate: () => testStack.push('update child'),
                  )
                ],
              ),
            ],
            parentContext: app!.appContext,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render parent'),
                roEventHookUpdate: () => testStack.push('update parent'),
                wOverrideIsConfigurationChanged: () => false,
                children: [
                  RT_TestWidget(
                    roEventHookRender: () => testStack.push('render child'),
                    roEventHookUpdate: () => testStack.push('update child'),
                  )
                ],
              ),
            ],
            updateType: UpdateType.setState,
            parentContext: app!.appContext,
          );

          expect(testStack.popFromStart(), equals('render parent'));
          expect(testStack.popFromStart(), equals('render child'));
          expect(testStack.popFromStart(), equals('update child'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test('should skip childs on short-circuit', () {
        var testStack = RT_TestStack();

        var constantWidget = RT_TestWidget(
          roEventHookRender: () => testStack.push('render parent'),
          roEventHookUpdate: () => testStack.push('update parent'),
          wOverrideIsConfigurationChanged: () => false,
          children: [
            RT_TestWidget(
              roEventHookRender: () => testStack.push('render child'),
              roEventHookUpdate: () => testStack.push('update child'),
            )
          ],
        );

        app!.framework.buildChildren(
          widgets: [constantWidget],
          parentContext: app!.appContext,
        );

        app!.framework.updateChildren(
          widgets: [constantWidget],
          updateType: UpdateType.setState,
          parentContext: app!.appContext,
        );

        expect(testStack.popFromStart(), equals('render parent'));
        expect(testStack.popFromStart(), equals('render child'));

        expect(testStack.canPop(), equals(false));
      });

      // widgets matching tests

      test(
        'should dispose and match immediate if mismatched without keys',
        () {
          var testStack = RT_TestStack();

          app!.framework.updateChildren(
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

          app!.framework.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                roEventHookRender: () => testStack.push('render 1b-1'),
                roEventHookUpdate: () => testStack.push('update 1b-1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1b-1'),
              ),
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 2a-2'),
                roEventHookUpdate: () => testStack.push('update 2a-2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2a-2'),
              ),
              RT_TestWidget(
                roEventHookRender: () => testStack.push('render 2a-3'),
                roEventHookUpdate: () => testStack.push('update 2a-3'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2a-3'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('render 1a-1'));
          expect(testStack.popFromStart(), equals('render 1a-2'));
          expect(testStack.popFromStart(), equals('render 1a-3'));

          expect(testStack.popFromStart(), equals('dispose 1a-3'));
          expect(testStack.popFromStart(), equals('render 1b-1'));
          expect(testStack.popFromStart(), equals('update 1a-1'));
          expect(testStack.popFromStart(), equals('update 1a-2'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test(
        'should dispose correct mismatch in the start',
        () {
          var testStack = RT_TestStack();

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('widget-1'),
                roEventHookRender: () => testStack.push('render 1a-1'),
                roEventHookUpdate: () => testStack.push('update 1a-1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1a-1'),
              ),
              RT_TestWidget(
                key: GlobalKey('widget-2'),
                roEventHookRender: () => testStack.push('render 1a-2'),
                roEventHookUpdate: () => testStack.push('update 1a-2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1a-2'),
              ),
              RT_TestWidget(
                key: GlobalKey('widget-3'),
                roEventHookRender: () => testStack.push('render 1a-3'),
                roEventHookUpdate: () => testStack.push('update 1a-3'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1a-3'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                key: GlobalKey('widget-1'),
                roEventHookRender: () => testStack.push('render 1b-1'),
                roEventHookUpdate: () => testStack.push('update 1b-1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1b-1'),
              ),
              RT_TestWidget(
                key: GlobalKey('widget-2'),
                roEventHookRender: () => testStack.push('render 2a-2'),
                roEventHookUpdate: () => testStack.push('update 2a-2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2a-2'),
              ),
              RT_TestWidget(
                key: GlobalKey('widget-3'),
                roEventHookRender: () => testStack.push('render 2a-3'),
                roEventHookUpdate: () => testStack.push('update 2a-3'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2a-3'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('render 1a-1'));
          expect(testStack.popFromStart(), equals('render 1a-2'));
          expect(testStack.popFromStart(), equals('render 1a-3'));

          expect(testStack.popFromStart(), equals('dispose 1a-1'));
          expect(testStack.popFromStart(), equals('render 1b-1'));
          expect(testStack.popFromStart(), equals('update 1a-2'));
          expect(testStack.popFromStart(), equals('update 1a-3'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test(
        'should dispose correct mismatch in the middle',
        () {
          var testStack = RT_TestStack();

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('widget-1'),
                roEventHookRender: () => testStack.push('render 1a-1'),
                roEventHookUpdate: () => testStack.push('update 1a-1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1a-1'),
              ),
              RT_TestWidget(
                key: GlobalKey('widget-2'),
                roEventHookRender: () => testStack.push('render 1a-2'),
                roEventHookUpdate: () => testStack.push('update 1a-2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1a-2'),
              ),
              RT_TestWidget(
                key: GlobalKey('widget-3'),
                roEventHookRender: () => testStack.push('render 1a-3'),
                roEventHookUpdate: () => testStack.push('update 1a-3'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1a-3'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('widget-1'),
                roEventHookRender: () => testStack.push('render 2a-1'),
                roEventHookUpdate: () => testStack.push('update 2a-1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2a-1'),
              ),
              RT_AnotherTestWidget(
                key: GlobalKey('widget-2'),
                roEventHookRender: () => testStack.push('render 1b-2'),
                roEventHookUpdate: () => testStack.push('update 1b-2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1b-2'),
              ),
              RT_TestWidget(
                key: GlobalKey('widget-3'),
                roEventHookRender: () => testStack.push('render 2a-3'),
                roEventHookUpdate: () => testStack.push('update 2a-3'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2a-3'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('render 1a-1'));
          expect(testStack.popFromStart(), equals('render 1a-2'));
          expect(testStack.popFromStart(), equals('render 1a-3'));

          expect(testStack.popFromStart(), equals('dispose 1a-2'));
          expect(testStack.popFromStart(), equals('update 1a-1'));
          expect(testStack.popFromStart(), equals('render 1b-2'));
          expect(testStack.popFromStart(), equals('update 1a-3'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test(
        'should dispose correct mismatch in the end',
        () {
          var testStack = RT_TestStack();

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('widget-1'),
                roEventHookRender: () => testStack.push('render 1a-1'),
                roEventHookUpdate: () => testStack.push('update 1a-1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1a-1'),
              ),
              RT_TestWidget(
                key: GlobalKey('widget-2'),
                roEventHookRender: () => testStack.push('render 1a-2'),
                roEventHookUpdate: () => testStack.push('update 1a-2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1a-2'),
              ),
              RT_TestWidget(
                key: GlobalKey('widget-3'),
                roEventHookRender: () => testStack.push('render 1a-3'),
                roEventHookUpdate: () => testStack.push('update 1a-3'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1a-3'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('widget-1'),
                roEventHookRender: () => testStack.push('render 2a-1'),
                roEventHookUpdate: () => testStack.push('update 2a-1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2a-1'),
              ),
              RT_TestWidget(
                key: GlobalKey('widget-2'),
                roEventHookRender: () => testStack.push('render 2a-2'),
                roEventHookUpdate: () => testStack.push('update 2a-2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2a-2'),
              ),
              RT_AnotherTestWidget(
                key: GlobalKey('widget-3'),
                roEventHookRender: () => testStack.push('render 1b-3'),
                roEventHookUpdate: () => testStack.push('update 1b-3'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1b-3'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('render 1a-1'));
          expect(testStack.popFromStart(), equals('render 1a-2'));
          expect(testStack.popFromStart(), equals('render 1a-3'));

          expect(testStack.popFromStart(), equals('dispose 1a-3'));
          expect(testStack.popFromStart(), equals('update 1a-1'));
          expect(testStack.popFromStart(), equals('update 1a-2'));
          expect(testStack.popFromStart(), equals('render 1b-3'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test(
        'should dispose mismatch and append new childs in the end',
        () {
          var testStack = RT_TestStack();

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('widget-1'),
                roEventHookRender: () => testStack.push('render 1a-1'),
                roEventHookUpdate: () => testStack.push('update 1a-1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1a-1'),
              ),
              RT_TestWidget(
                key: GlobalKey('widget-2'),
                roEventHookRender: () => testStack.push('render 1a-2'),
                roEventHookUpdate: () => testStack.push('update 1a-2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1a-2'),
              ),
              RT_TestWidget(
                key: GlobalKey('widget-3'),
                roEventHookRender: () => testStack.push('render 1a-3'),
                roEventHookUpdate: () => testStack.push('update 1a-3'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1a-3'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('widget-1'),
                roEventHookRender: () => testStack.push('render 2a-1'),
                roEventHookUpdate: () => testStack.push('update 2a-1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2a-1'),
              ),
              RT_TestWidget(
                key: GlobalKey('widget-2'),
                roEventHookRender: () => testStack.push('render 2a-2'),
                roEventHookUpdate: () => testStack.push('update 2a-2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2a-2'),
              ),
              RT_AnotherTestWidget(
                key: GlobalKey('widget-3'),
                roEventHookRender: () => testStack.push('render 1b-3'),
                roEventHookUpdate: () => testStack.push('update 1b-3'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1b-3'),
              ),
              RT_AnotherTestWidget(
                key: GlobalKey('widget-4'),
                roEventHookRender: () => testStack.push('render 1b-4'),
                roEventHookUpdate: () => testStack.push('update 1b-4'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1b-4'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('render 1a-1'));
          expect(testStack.popFromStart(), equals('render 1a-2'));
          expect(testStack.popFromStart(), equals('render 1a-3'));

          expect(testStack.popFromStart(), equals('dispose 1a-3'));
          expect(testStack.popFromStart(), equals('update 1a-1'));
          expect(testStack.popFromStart(), equals('update 1a-2'));
          expect(testStack.popFromStart(), equals('render 1b-3'));
          expect(testStack.popFromStart(), equals('render 1b-4'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test(
        'should skip mismatch and reuse existing widget(prevent loosing state when childs are added optionally)',
        () {
          var testStack = RT_TestStack();

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('widget-1'),
                roEventHookRender: () => testStack.push('render 1a-1'),
                roEventHookUpdate: () => testStack.push('update 1a-1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1a-1'),
              ),
              RT_TestWidget(
                key: GlobalKey('widget-2'),
                roEventHookRender: () => testStack.push('render 1a-2'),
                roEventHookUpdate: () => testStack.push('update 1a-2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1a-2'),
              ),
              RT_TestWidget(
                key: GlobalKey('widget-3'),
                roEventHookRender: () => testStack.push('render 1a-3'),
                roEventHookUpdate: () => testStack.push('update 1a-3'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1a-3'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('widget-1'),
                roEventHookRender: () => testStack.push('render 2a-1'),
                roEventHookUpdate: () => testStack.push('update 2a-1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2a-1'),
              ),
              RT_TestWidget(
                key: GlobalKey('widget-2'),
                roEventHookRender: () => testStack.push('render 2a-2'),
                roEventHookUpdate: () => testStack.push('update 2a-2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2a-2'),
              ),
              RT_AnotherTestWidget(
                roEventHookRender: () => testStack.push('render 1b-3'),
                roEventHookUpdate: () => testStack.push('update 1b-3'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1b-3'),
              ),
              RT_TestWidget(
                key: GlobalKey('widget-3'),
                roEventHookRender: () => testStack.push('render 2a-4'),
                roEventHookUpdate: () => testStack.push('update 2a-4'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2a-4'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );
          // render 1a-1, render 1a-2, render 1a-3,

          // dispose 1a-3,

          // update 1a-1, update 1a-2, render 1b-3, render 2a-3

          expect(testStack.popFromStart(), equals('render 1a-1'));
          expect(testStack.popFromStart(), equals('render 1a-2'));
          expect(testStack.popFromStart(), equals('render 1a-3'));

          expect(testStack.popFromStart(), equals('update 1a-1'));
          expect(testStack.popFromStart(), equals('update 1a-2'));
          expect(testStack.popFromStart(), equals('render 1b-3'));
          expect(testStack.popFromStart(), equals('update 1a-3'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test(
        'should dispose correct mis matches, mixed hardcoded version',
        () {
          var testStack = RT_TestStack();

          // render childs
          // ----------------expected
          // render 1a-1, render 1a-2, render 1a-3, render 1a-4

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('widget-1'),
                roEventHookRender: () => testStack.push('render 1a-1'),
                roEventHookUpdate: () => testStack.push('update 1a-1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1a-1'),
              ),
              RT_TestWidget(
                key: GlobalKey('widget-2'),
                roEventHookRender: () => testStack.push('render 1a-2'),
                roEventHookUpdate: () => testStack.push('update 1a-2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1a-2'),
              ),
              RT_TestWidget(
                key: GlobalKey('widget-3'),
                roEventHookRender: () => testStack.push('render 1a-3'),
                roEventHookUpdate: () => testStack.push('update 1a-3'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1a-3'),
              ),
              RT_TestWidget(
                key: GlobalKey('widget-4'),
                roEventHookRender: () => testStack.push('render 1a-4'),
                roEventHookUpdate: () => testStack.push('update 1a-4'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1a-4'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          // change 2nd child
          // ----------------expected
          // dispose 1a-2
          // update 1a-1, render 1b-2, update 1a-3, update 1a-4
          //

          app!.framework.updateChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('widget-1'),
                roEventHookRender: () => testStack.push('render 2a-1'),
                roEventHookUpdate: () => testStack.push('update 2a-1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1b-1'),
              ),
              RT_AnotherTestWidget(
                key: GlobalKey('widget-2'),
                roEventHookRender: () => testStack.push('render 1b-2'),
                roEventHookUpdate: () => testStack.push('update 1b-2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1b-2'),
              ),
              RT_TestWidget(
                key: GlobalKey('widget-3'),
                roEventHookRender: () => testStack.push('render 2a-3'),
                roEventHookUpdate: () => testStack.push('update 2a-3'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2a-3'),
              ),
              RT_TestWidget(
                key: GlobalKey('widget-4'),
                roEventHookRender: () => testStack.push('render 2a-4'),
                roEventHookUpdate: () => testStack.push('update 2a-4'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2a-4'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          // change 1st child
          // ----------------expected
          // dispose 1a-1
          // render 1b-1, update 1b-2, update 1a-3, update 1a-4
          //

          app!.framework.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                key: GlobalKey('widget-1'),
                roEventHookRender: () => testStack.push('render 1b-1'),
                roEventHookUpdate: () => testStack.push('update 1b-1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1b-1'),
              ),
              RT_AnotherTestWidget(
                key: GlobalKey('widget-2'),
                roEventHookRender: () => testStack.push('render 2b-2'),
                roEventHookUpdate: () => testStack.push('update 2b-2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2b-2'),
              ),
              RT_TestWidget(
                key: GlobalKey('widget-3'),
                roEventHookRender: () => testStack.push('render 3a-3'),
                roEventHookUpdate: () => testStack.push('update 3a-3'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 3a-3'),
              ),
              RT_TestWidget(
                key: GlobalKey('widget-4'),
                roEventHookRender: () => testStack.push('render 3a-4'),
                roEventHookUpdate: () => testStack.push('update 3a-4'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 3a-4'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          // change last two childs
          // ----------------expected
          // dispose 1a-3, dispose 1a-4
          // update 1b-1, update 1b-2, render 1b-3, render 1b-4

          app!.framework.updateChildren(
            widgets: [
              RT_AnotherTestWidget(
                key: GlobalKey('widget-1'),
                roEventHookRender: () => testStack.push('render 2b-1'),
                roEventHookUpdate: () => testStack.push('update 2b-1'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2b-1'),
              ),
              RT_AnotherTestWidget(
                key: GlobalKey('widget-2'),
                roEventHookRender: () => testStack.push('render 2b-2'),
                roEventHookUpdate: () => testStack.push('update 2b-2'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 2b-2'),
              ),
              RT_AnotherTestWidget(
                key: GlobalKey('widget-3'),
                roEventHookRender: () => testStack.push('render 1b-3'),
                roEventHookUpdate: () => testStack.push('update 1b-3'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1b-3'),
              ),
              RT_AnotherTestWidget(
                key: GlobalKey('widget-4'),
                roEventHookRender: () => testStack.push('render 1b-4'),
                roEventHookUpdate: () => testStack.push('update 1b-4'),
                roEventHookBeforeUnMount: () => testStack.push('dispose 1b-4'),
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.undefined,
          );

          expect(testStack.popFromStart(), equals('render 1a-1'));
          expect(testStack.popFromStart(), equals('render 1a-2'));
          expect(testStack.popFromStart(), equals('render 1a-3'));
          expect(testStack.popFromStart(), equals('render 1a-4'));

          expect(testStack.popFromStart(), equals('dispose 1a-2'));
          expect(testStack.popFromStart(), equals('update 1a-1'));
          expect(testStack.popFromStart(), equals('render 1b-2'));
          expect(testStack.popFromStart(), equals('update 1a-3'));
          expect(testStack.popFromStart(), equals('update 1a-4'));

          expect(testStack.popFromStart(), equals('dispose 1a-1'));
          expect(testStack.popFromStart(), equals('render 1b-1'));
          expect(testStack.popFromStart(), equals('update 1b-2'));
          expect(testStack.popFromStart(), equals('update 1a-3'));
          expect(testStack.popFromStart(), equals('update 1a-4'));

          expect(testStack.popFromStart(), equals('dispose 1a-3'));
          expect(testStack.popFromStart(), equals('dispose 1a-4'));
          expect(testStack.popFromStart(), equals('update 1b-1'));
          expect(testStack.popFromStart(), equals('update 1b-2'));
          expect(testStack.popFromStart(), equals('render 1b-3'));
          expect(testStack.popFromStart(), equals('render 1b-4'));

          expect(testStack.canPop(), equals(false));
        },
      );

      //
    },
  );
}
