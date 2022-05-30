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
        () async {
          var testStack = RT_TestStack();

          await app!.buildChildren(
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

          await app!.updateChildren(
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
        () async {
          var testStack = RT_TestStack();

          await app!.buildChildren(
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

          await app!.updateChildren(
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
        () async {
          var testStack = RT_TestStack();

          await app!.buildChildren(
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

          await app!.updateChildren(
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

          await app!.updateChildren(
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

          await app!.updateChildren(
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
        'should  rebind a widget instance '
        'if widget configuration has changed',
        () async {
          var testStack = RT_TestStack();

          await app!.buildChildren(
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

          await app!.updateChildren(
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

          expect(testStack.popFromStart(), equals('rebind widget 1a'));

          expect(testStack.popFromStart(), equals('is changed 2a'));
          expect(testStack.popFromStart(), equals('create config 2a'));

          expect(testStack.popFromStart(), equals('update 1a'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test(
        'should  rebind a widget instance (instance test) '
        'if widget configuration has changed',
        () async {
          var testStack = RT_TestStack();

          await app!.buildChildren(
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

          await app!.updateChildren(
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

          expect(testStack.popFromStart(), equals('rebind widget 1a'));

          expect(testStack.popFromStart(), equals('is changed 2a'));
          expect(testStack.popFromStart(), equals('create config 2a'));

          expect(testStack.popFromStart(), equals('update 1a'));

          expect(testStack.canPop(), equals(false));
        },
      );

      test('should check childs if parent configuration is changed', () async {
        var testStack = RT_TestStack();

        await app!.buildChildren(
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

        await app!.updateChildren(
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
        () async {
          var testStack = RT_TestStack();

          await app!.buildChildren(
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

          await app!.updateChildren(
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

      test('should skip childs on short-circuit', () async {
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

        await app!.buildChildren(
          widgets: [constantWidget],
          parentContext: app!.appContext,
        );

        await app!.updateChildren(
          widgets: [constantWidget],
          updateType: UpdateType.setState,
          parentContext: app!.appContext,
        );

        expect(testStack.popFromStart(), equals('render parent'));
        expect(testStack.popFromStart(), equals('render child'));

        expect(testStack.canPop(), equals(false));
      });

      test(
        'should add/dispose childs depending on updated children list',
        () async {
          await app!.buildChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('widget'),
                wOverrideIsConfigurationChanged: () => false,
                children: [],
              ),
            ],
            parentContext: app!.appContext,
          );

          expect(RT_TestBed.rootElement, RT_hasContents(''));

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('widget'),
                wOverrideIsConfigurationChanged: () => false,
                children: [
                  Text('a'),
                  Text('b'),
                  Text('c'),
                ],
              ),
            ],
            updateType: UpdateType.setState,
            parentContext: app!.appContext,
          );

          expect(RT_TestBed.rootElement, RT_hasContents('a|b|c'));

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                key: GlobalKey('widget'),
                wOverrideIsConfigurationChanged: () => false,
                children: [],
              ),
            ],
            updateType: UpdateType.setState,
            parentContext: app!.appContext,
          );

          expect(RT_TestBed.rootElement, RT_hasContents(''));
        },
      );

      test(
        'should rebind widget instance if configuration has changed',
        () async {
          await app!.buildChildren(
            widgets: [
              RT_TestWidget(
                customHash: '1a',
                key: GlobalKey('widget'),
                wOverrideIsConfigurationChanged: () => true,
              ),
            ],
            parentContext: app!.appContext,
          );

          var widgetObject = app!.widgetObjectByGlobalKey('widget');
          expect((widgetObject.widget as RT_TestWidget).hash, equals('1a'));

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                customHash: '2a',
                key: GlobalKey('widget'),
                wOverrideIsConfigurationChanged: () => true,
              ),
            ],
            updateType: UpdateType.setState,
            parentContext: app!.appContext,
          );

          expect((widgetObject.widget as RT_TestWidget).hash, equals('2a'));

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                customHash: '3a',
                key: GlobalKey('widget'),
                wOverrideIsConfigurationChanged: () => true,
              ),
            ],
            updateType: UpdateType.setState,
            parentContext: app!.appContext,
          );

          expect((widgetObject.widget as RT_TestWidget).hash, equals('3a'));
        },
      );

      test(
        'should rebind widget instance even if configuration has not changed',
        () async {
          // Rebinding isn't required if both(old and new) instances of widget
          // are same, e.g in const costructors. But in all other cases
          // framework must update widget instance, even if widget's
          // configuration hasn't changed. This is because some properties of
          // widget are not part of widget's configuration such as
          // widgetChildren, widgetEventListeners. instead these properties are
          // checked at framework side. updating instance will ensure that
          // framework is dealing with at-least correct values.

          await app!.buildChildren(
            widgets: [
              RT_TestWidget(
                customHash: '1a',
                key: GlobalKey('widget'),
                wOverrideIsConfigurationChanged: () => false,
              ),
            ],
            parentContext: app!.appContext,
          );

          var widgetObject = app!.widgetObjectByGlobalKey('widget');
          expect((widgetObject.widget as RT_TestWidget).hash, equals('1a'));

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                customHash: '2a',
                key: GlobalKey('widget'),
                wOverrideIsConfigurationChanged: () => false,
              ),
            ],
            updateType: UpdateType.setState,
            parentContext: app!.appContext,
          );

          expect((widgetObject.widget as RT_TestWidget).hash, equals('2a'));

          await app!.updateChildren(
            widgets: [
              RT_TestWidget(
                customHash: '3a',
                key: GlobalKey('widget'),
                wOverrideIsConfigurationChanged: () => false,
              ),
            ],
            updateType: UpdateType.setState,
            parentContext: app!.appContext,
          );

          expect((widgetObject.widget as RT_TestWidget).hash, equals('3a'));
        },
      );

      // widgets matching tests

      test(
        'should dispose and match immediate if mismatched without keys',
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
        () async {
          var testStack = RT_TestStack();

          await app!.updateChildren(
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

          await app!.updateChildren(
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
        () async {
          var testStack = RT_TestStack();

          await app!.updateChildren(
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

          await app!.updateChildren(
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
        () async {
          var testStack = RT_TestStack();

          await app!.updateChildren(
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

          await app!.updateChildren(
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
        () async {
          var testStack = RT_TestStack();

          await app!.updateChildren(
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

          await app!.updateChildren(
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
        'should be able to run update on tree containing non-direct childs '
        'direct childs means childs that are rendered by the state of widget it self',
        () async {
          var pap = app!;

          await pap.updateChildren(
            widgets: [
              Navigator(
                routes: [
                  Route(
                    key: GlobalKey('route'),
                    name: 'some-name',
                    page: Text(''),
                  ),
                ],
              ),
            ],
            parentContext: pap.appContext,
            updateType: UpdateType.setState,
          );

          await pap.updateChildren(
            widgets: [
              Navigator(
                routes: [
                  Route(
                    key: GlobalKey('route'),
                    name: 'some-name',
                    page: Text(''),
                  ),
                ],
              ),
            ],
            parentContext: app!.appContext,
            updateType: UpdateType.setState,
          );

          var route = pap.widget('route');

          expect((route as Route).name, equals('some-name'));
        },
      );

      test(
        'should skip mismatch and reuse existing widget(prevent loosing state when childs are added optionally)',
        () async {
          var testStack = RT_TestStack();

          await app!.updateChildren(
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

          await app!.updateChildren(
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
        () async {
          var testStack = RT_TestStack();

          // render childs
          // ----------------expected
          // render 1a-1, render 1a-2, render 1a-3, render 1a-4

          await app!.updateChildren(
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

          await app!.updateChildren(
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

          await app!.updateChildren(
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

          await app!.updateChildren(
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
