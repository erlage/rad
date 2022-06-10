import '../../test_imports.dart';

/*
|--------------------------------------------------------------------------
| Component tests for core/framework
|--------------------------------------------------------------------------
*/

void main() {
  /*
  |--------------------------------------------------------------------------
  | manage(visit) children tests
  |--------------------------------------------------------------------------
  */

  group('manageChildren() tests: under app context:', () {
    RT_AppRunner? app;

    setUp(() => app = createTestApp()..start());

    tearDown(() => app!.stop());

    test(
      'should iterate over all childs in insertion order if '
      'flagIterateInReverseOrder is not set',
      () async {
        var testStack = RT_TestStack();

        await app!.buildChildren(
          widgets: [
            RT_TestWidget(key: GlobalKey('widget-1')),
            RT_TestWidget(key: GlobalKey('widget-2')),
            RT_TestWidget(key: GlobalKey('widget-3')),
            RT_TestWidget(key: GlobalKey('widget-4')),
            RT_TestWidget(key: GlobalKey('widget-5')),
          ],
          parentContext: app!.appContext,
        );

        await app!.manageChildren(
          updateType: UpdateType.visitorUpdate,
          parentContext: app!.appContext,
          widgetActionCallback: (widgetObject) {
            testStack.push(widgetObject.context.key.value);

            return [];
          },
        );

        expect(testStack.popFromStart(), equals('widget-1'));
        expect(testStack.popFromStart(), equals('widget-2'));
        expect(testStack.popFromStart(), equals('widget-3'));
        expect(testStack.popFromStart(), equals('widget-4'));
        expect(testStack.popFromStart(), equals('widget-5'));

        expect(testStack.canPop(), equals(false));
      },
    );

    test(
      'should iterate over all childs in insertion order if '
      'flagIterateInReverseOrder: false',
      () async {
        var testStack = RT_TestStack();

        await app!.buildChildren(
          widgets: [
            RT_TestWidget(key: GlobalKey('widget-1')),
            RT_TestWidget(key: GlobalKey('widget-2')),
            RT_TestWidget(key: GlobalKey('widget-3')),
            RT_TestWidget(key: GlobalKey('widget-4')),
            RT_TestWidget(key: GlobalKey('widget-5')),
          ],
          parentContext: app!.appContext,
        );

        await app!.manageChildren(
          updateType: UpdateType.visitorUpdate,
          parentContext: app!.appContext,
          flagIterateInReverseOrder: false,
          widgetActionCallback: (widgetObject) {
            testStack.push(widgetObject.context.key.value);

            return [];
          },
        );

        expect(testStack.popFromStart(), equals('widget-1'));
        expect(testStack.popFromStart(), equals('widget-2'));
        expect(testStack.popFromStart(), equals('widget-3'));
        expect(testStack.popFromStart(), equals('widget-4'));
        expect(testStack.popFromStart(), equals('widget-5'));

        expect(testStack.canPop(), equals(false));
      },
    );

    test(
      'should iterate over all childs in reverse order if '
      'flagIterateInReverseOrder: true',
      () async {
        var testStack = RT_TestStack();

        await app!.buildChildren(
          widgets: [
            RT_TestWidget(key: GlobalKey('widget-1')),
            RT_TestWidget(key: GlobalKey('widget-2')),
            RT_TestWidget(key: GlobalKey('widget-3')),
            RT_TestWidget(key: GlobalKey('widget-4')),
            RT_TestWidget(key: GlobalKey('widget-5')),
          ],
          parentContext: app!.appContext,
        );

        await app!.manageChildren(
          updateType: UpdateType.visitorUpdate,
          parentContext: app!.appContext,
          flagIterateInReverseOrder: true,
          widgetActionCallback: (widgetObject) {
            testStack.push(widgetObject.context.key.value);

            return [];
          },
        );

        expect(testStack.popFromStart(), equals('widget-5'));
        expect(testStack.popFromStart(), equals('widget-4'));
        expect(testStack.popFromStart(), equals('widget-3'));
        expect(testStack.popFromStart(), equals('widget-2'));
        expect(testStack.popFromStart(), equals('widget-1'));

        expect(testStack.canPop(), equals(false));
      },
    );

    test(
      'should iterate over only childs at one level',
      () async {
        var testStack = RT_TestStack();

        await app!.buildChildren(
          widgets: [
            RT_TestWidget(key: GlobalKey('widget-1')),
            RT_TestWidget(
              key: GlobalKey('widget-2'),
              children: [
                RT_TestWidget(key: GlobalKey('widget-2-1')),
                RT_TestWidget(key: GlobalKey('widget-2-2')),
              ],
            ),
            RT_TestWidget(key: GlobalKey('widget-3')),
            RT_TestWidget(key: GlobalKey('widget-4')),
            RT_TestWidget(key: GlobalKey('widget-5')),
          ],
          parentContext: app!.appContext,
        );

        await app!.manageChildren(
          updateType: UpdateType.visitorUpdate,
          parentContext: app!.appContext,
          widgetActionCallback: (widgetObject) {
            testStack.push(widgetObject.context.key.value);

            return [];
          },
        );

        expect(testStack.popFromStart(), equals('widget-1'));
        expect(testStack.popFromStart(), equals('widget-2'));
        expect(testStack.popFromStart(), equals('widget-3'));
        expect(testStack.popFromStart(), equals('widget-4'));
        expect(testStack.popFromStart(), equals('widget-5'));

        expect(testStack.canPop(), equals(false));
      },
    );

    test(
      'should short circuite further iterations when encounters skip',
      () async {
        var testStack = RT_TestStack();

        await app!.buildChildren(
          widgets: [
            RT_TestWidget(key: GlobalKey('widget-1')),
            RT_TestWidget(
              key: GlobalKey('widget-2'),
              children: [
                RT_TestWidget(key: GlobalKey('widget-2-1')),
                RT_TestWidget(key: GlobalKey('widget-2-2')),
              ],
            ),
            RT_TestWidget(key: GlobalKey('widget-3')),
            RT_TestWidget(key: GlobalKey('widget-4')),
            RT_TestWidget(key: GlobalKey('widget-5')),
          ],
          parentContext: app!.appContext,
        );

        await app!.manageChildren(
          updateType: UpdateType.visitorUpdate,
          parentContext: app!.appContext,
          widgetActionCallback: (widgetObject) {
            testStack.push(widgetObject.context.key.value);

            if ('widget-3' == widgetObject.context.key.value) {
              return [WidgetAction.skipRest];
            }

            return [];
          },
        );

        expect(testStack.popFromStart(), equals('widget-1'));
        expect(testStack.popFromStart(), equals('widget-2'));
        expect(testStack.popFromStart(), equals('widget-3'));

        expect(testStack.canPop(), equals(false));
      },
    );

    test(
      'should dispose widget when encounter dispose action',
      () async {
        var testStack = RT_TestStack();

        await app!.buildChildren(
          widgets: [
            RT_TestWidget(
              key: GlobalKey('widget-1'),
              roEventHookBeforeUnMount: () => testStack.push('dispose-1'),
            ),
            RT_TestWidget(
              key: GlobalKey('widget-2'),
              roEventHookBeforeUnMount: () => testStack.push('dispose-2'),
            ),
            RT_TestWidget(
              key: GlobalKey('widget-3'),
              roEventHookBeforeUnMount: () => testStack.push('dispose-3'),
            ),
          ],
          parentContext: app!.appContext,
        );

        await app!.manageChildren(
          updateType: UpdateType.visitorUpdate,
          parentContext: app!.appContext,
          widgetActionCallback: (widgetObject) {
            testStack.push(widgetObject.context.key.value);

            if ('widget-3' == widgetObject.context.key.value) {
              return [WidgetAction.skipRest];
            }

            return [WidgetAction.dispose];
          },
        );

        expect(testStack.popFromStart(), equals('widget-1'));
        expect(testStack.popFromStart(), equals('widget-2'));
        expect(testStack.popFromStart(), equals('widget-3'));
        expect(testStack.popFromStart(), equals('dispose-1'));
        expect(testStack.popFromStart(), equals('dispose-2'));

        expect(testStack.canPop(), equals(false));
      },
    );

    test(
      'should update widget when encounter update action',
      () async {
        var testStack = RT_TestStack();

        await app!.buildChildren(
          widgets: [
            RT_TestWidget(
              key: GlobalKey('widget-1'),
              roEventHookUpdate: () => testStack.push('update-1'),
            ),
            RT_TestWidget(
              key: GlobalKey('widget-2'),
              roEventHookUpdate: () => testStack.push('update-2'),
              children: [
                RT_TestWidget(
                  key: GlobalKey('widget-2-1'),
                  children: [
                    RT_TestWidget(
                      key: GlobalKey('widget-2-1-1'),
                      children: [],
                      roEventHookUpdate: () => testStack.push('update-2-1-1'),
                    ),
                  ],
                  roEventHookUpdate: () => testStack.push('update-2-1'),
                ),
              ],
            ),
            RT_TestWidget(
              key: GlobalKey('widget-3'),
              roEventHookUpdate: () => testStack.push('update-3'),
            ),
          ],
          parentContext: app!.appContext,
        );

        await app!.manageChildren(
          updateType: UpdateType.visitorUpdate,
          parentContext: app!.appContext,
          widgetActionCallback: (widgetObject) {
            testStack.push(widgetObject.context.key.value);

            return [WidgetAction.updateWidget];
          },
        );

        expect(testStack.popFromStart(), equals('widget-1'));
        expect(testStack.popFromStart(), equals('widget-2'));
        expect(testStack.popFromStart(), equals('widget-3'));
        expect(testStack.popFromStart(), equals('update-1'));
        expect(testStack.popFromStart(), equals('update-2'));
        expect(testStack.popFromStart(), equals('update-2-1'));
        expect(testStack.popFromStart(), equals('update-3'));

        expect(testStack.canPop(), equals(false));
      },
    );

    test(
      'should hide widget when encounter hide action',
      () async {
        await app!.buildChildren(
          widgets: [
            RT_TestWidget(key: GlobalKey('widget-1')),
            RT_TestWidget(key: GlobalKey('widget-2')),
            RT_TestWidget(key: GlobalKey('widget-3')),
          ],
          parentContext: app!.appContext,
        );

        await app!.manageChildren(
          updateType: UpdateType.visitorUpdate,
          parentContext: app!.appContext,
          widgetActionCallback: (widgetObject) {
            return [WidgetAction.hideWidget];
          },
        );

        var widget1 = app!.services.walker.getWidgetObjectUsingKey('widget-1');
        var widget2 = app!.services.walker.getWidgetObjectUsingKey('widget-2');
        var widget3 = app!.services.walker.getWidgetObjectUsingKey('widget-3');

        expect(
          widget1!.domNode?.classes.contains(Constants.classHidden),
          equals(true),
        );

        expect(
          widget2!.domNode?.classes.contains(Constants.classHidden),
          equals(true),
        );

        expect(
          widget3!.domNode?.classes.contains(Constants.classHidden),
          equals(true),
        );
      },
    );

    test(
      'should show widget when encounter show action',
      () async {
        await app!.buildChildren(
          widgets: [
            RT_TestWidget(key: GlobalKey('widget-1')),
            RT_TestWidget(key: GlobalKey('widget-2')),
            RT_TestWidget(key: GlobalKey('widget-3')),
          ],
          parentContext: app!.appContext,
        );

        // first hide widgets

        await app!.manageChildren(
          updateType: UpdateType.visitorUpdate,
          parentContext: app!.appContext,
          widgetActionCallback: (widgetObject) {
            return [WidgetAction.hideWidget];
          },
        );

        await app!.manageChildren(
          updateType: UpdateType.visitorUpdate,
          parentContext: app!.appContext,
          widgetActionCallback: (widgetObject) {
            return [WidgetAction.showWidget];
          },
        );

        var widget1 = app!.services.walker.getWidgetObjectUsingKey('widget-1');
        var widget2 = app!.services.walker.getWidgetObjectUsingKey('widget-2');
        var widget3 = app!.services.walker.getWidgetObjectUsingKey('widget-3');

        expect(
          widget1!.domNode?.classes.contains(Constants.classHidden),
          equals(false),
        );

        expect(
          widget2!.domNode?.classes.contains(Constants.classHidden),
          equals(false),
        );

        expect(
          widget3!.domNode?.classes.contains(Constants.classHidden),
          equals(false),
        );
      },
    );
    test(
      'should be able to run update on tree containing non-direct childs '
      'direct childs are the childs that widget provides in widget constructor '
      'non-direct childs are the childs that are rendered by the state of widget it-self',
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

        await app!.manageChildren(
          updateType: UpdateType.visitorUpdate,
          parentContext: app!.appContext,
          widgetActionCallback: (widgetObject) {
            return [WidgetAction.updateWidget];
          },
        );

        var route = pap.widget('route');

        expect((route as Route).name, equals('some-name'));
      },
    );

    test(
      'should dispatch mixed actions',
      () async {
        var testStack = RT_TestStack();

        await app!.buildChildren(
          widgets: [
            RT_TestWidget(
              key: GlobalKey('widget-1'),
              roEventHookUpdate: () => testStack.push('update-1'),
              roEventHookBeforeUnMount: () => testStack.push('dispose-1'),
            ),
            RT_TestWidget(
              key: GlobalKey('widget-2'),
              children: [
                RT_TestWidget(
                  key: GlobalKey('widget-2-1'),
                  children: [
                    RT_TestWidget(
                      key: GlobalKey('widget-2-1-1'),
                      children: [],
                      // should never cascade update to this level
                      roEventHookUpdate: () => testStack.push('update-2-1-1'),
                    ),
                  ],
                  roEventHookUpdate: () => testStack.push('update-2-1'),
                  roEventHookBeforeUnMount: () => testStack.push('dispose-2-1'),
                ),
              ],
              roEventHookUpdate: () => testStack.push('update-2'),
              roEventHookBeforeUnMount: () => testStack.push('dispose-2'),
            ),
            RT_TestWidget(
              key: GlobalKey('widget-3'),
              roEventHookUpdate: () => testStack.push('update-3'),
              roEventHookBeforeUnMount: () => testStack.push('dispose-3'),
            ),
            RT_TestWidget(key: GlobalKey('widget-4')),
          ],
          parentContext: app!.appContext,
        );

        await app!.manageChildren(
          updateType: UpdateType.visitorUpdate,
          parentContext: app!.appContext,
          widgetActionCallback: (widgetObject) {
            testStack.push(widgetObject.context.key.value);

            switch (widgetObject.context.key.value) {
              case 'widget-1':
                return [
                  WidgetAction.hideWidget,
                  WidgetAction.showWidget,
                ];

              case 'widget-2':
                return [
                  WidgetAction.updateWidget,
                  WidgetAction.dispose,
                ];

              case 'widget-3':
                return [
                  WidgetAction.hideWidget,
                  WidgetAction.skipRest,
                ];

              default:
                return [];
            }
          },
        );

        var widget1 = app!.services.walker.getWidgetObjectUsingKey('widget-1');
        var widget3 = app!.services.walker.getWidgetObjectUsingKey('widget-3');

        expect(
          widget1!.domNode?.classes.contains(Constants.classHidden),
          equals(false),
        );

        expect(
          widget3!.domNode?.classes.contains(Constants.classHidden),
          equals(true),
        );

        // ensure all are iterated except last
        expect(testStack.popFromStart(), equals('widget-1'));
        expect(testStack.popFromStart(), equals('widget-2'));
        expect(testStack.popFromStart(), equals('widget-3'));

        expect(testStack.popFromStart(), equals('update-2'));
        expect(testStack.popFromStart(), equals('update-2-1'));
        expect(testStack.popFromStart(), equals('dispose-2-1'));
        expect(testStack.popFromStart(), equals('dispose-2'));

        expect(testStack.canPop(), equals(false));
      },
    );

    //
  });
}
