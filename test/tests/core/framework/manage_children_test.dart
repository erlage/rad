import 'package:rad/rad.dart';
import 'package:rad/widgets_internals.dart';
import 'package:test/scaffolding.dart';
import 'package:test/expect.dart';

import '../../../fixers/test_app.dart';
import '../../../fixers/test_stack.dart';
import '../../../fixers/test_widget.dart';

/*
|--------------------------------------------------------------------------
| Component tests for core/framework.dart
|
| Methods to test in this file: manageChildren()
|--------------------------------------------------------------------------
*/

void main() {
  /*
  |--------------------------------------------------------------------------
  | manageChildren tests
  |--------------------------------------------------------------------------
  */

  group('manageChildren() tests: under app context:', () {
    RT_AppRunner? app;

    setUp(() => app = createTestApp()..startWithAppWidget());

    tearDown(() => app!.stop());

    test(
      'should iterate over all childs in insertion order if'
      'flagIterateInReverseOrder is not set',
      () {
        var testStack = RT_TestStack();

        app!.framework.buildChildren(
          widgets: [
            RT_TestWidget(key: GlobalKey('widget-1')),
            RT_TestWidget(key: GlobalKey('widget-2')),
            RT_TestWidget(key: GlobalKey('widget-3')),
            RT_TestWidget(key: GlobalKey('widget-4')),
            RT_TestWidget(key: GlobalKey('widget-5')),
          ],
          parentContext: app!.appContext,
        );

        app!.framework.manageChildren(
          updateType: UpdateType.undefined,
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
      'should iterate over all childs in insertion order if'
      'flagIterateInReverseOrder: false',
      () {
        var testStack = RT_TestStack();

        app!.framework.buildChildren(
          widgets: [
            RT_TestWidget(key: GlobalKey('widget-1')),
            RT_TestWidget(key: GlobalKey('widget-2')),
            RT_TestWidget(key: GlobalKey('widget-3')),
            RT_TestWidget(key: GlobalKey('widget-4')),
            RT_TestWidget(key: GlobalKey('widget-5')),
          ],
          parentContext: app!.appContext,
        );

        app!.framework.manageChildren(
          updateType: UpdateType.undefined,
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
      'should iterate over all childs in reverse order if'
      'flagIterateInReverseOrder: true',
      () {
        var testStack = RT_TestStack();

        app!.framework.buildChildren(
          widgets: [
            RT_TestWidget(key: GlobalKey('widget-1')),
            RT_TestWidget(key: GlobalKey('widget-2')),
            RT_TestWidget(key: GlobalKey('widget-3')),
            RT_TestWidget(key: GlobalKey('widget-4')),
            RT_TestWidget(key: GlobalKey('widget-5')),
          ],
          parentContext: app!.appContext,
        );

        app!.framework.manageChildren(
          updateType: UpdateType.undefined,
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
      () {
        var testStack = RT_TestStack();

        app!.framework.buildChildren(
          widgets: [
            RT_TestWidget(key: GlobalKey('widget-1')),
            RT_TestWidget(key: GlobalKey('widget-2'), children: [
              RT_TestWidget(key: GlobalKey('widget-2-1')),
              RT_TestWidget(key: GlobalKey('widget-2-2')),
            ]),
            RT_TestWidget(key: GlobalKey('widget-3')),
            RT_TestWidget(key: GlobalKey('widget-4')),
            RT_TestWidget(key: GlobalKey('widget-5')),
          ],
          parentContext: app!.appContext,
        );

        app!.framework.manageChildren(
          updateType: UpdateType.undefined,
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
      () {
        var testStack = RT_TestStack();

        app!.framework.buildChildren(
          widgets: [
            RT_TestWidget(key: GlobalKey('widget-1')),
            RT_TestWidget(key: GlobalKey('widget-2'), children: [
              RT_TestWidget(key: GlobalKey('widget-2-1')),
              RT_TestWidget(key: GlobalKey('widget-2-2')),
            ]),
            RT_TestWidget(key: GlobalKey('widget-3')),
            RT_TestWidget(key: GlobalKey('widget-4')),
            RT_TestWidget(key: GlobalKey('widget-5')),
          ],
          parentContext: app!.appContext,
        );

        app!.framework.manageChildren(
          updateType: UpdateType.undefined,
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
      () {
        var testStack = RT_TestStack();

        app!.framework.buildChildren(
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

        app!.framework.manageChildren(
          updateType: UpdateType.undefined,
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
      () {
        var testStack = RT_TestStack();

        app!.framework.buildChildren(
          widgets: [
            RT_TestWidget(
              key: GlobalKey('widget-1'),
              roEventHookUpdate: () => testStack.push('update-1'),
            ),
            RT_TestWidget(
              key: GlobalKey('widget-2'),
              children: [
                RT_TestWidget(
                  key: GlobalKey('widget-2-1'),
                  children: [],
                  roEventHookUpdate: () => testStack.push('update-2-1'),
                ),
              ],
              roEventHookUpdate: () => testStack.push('update-2'),
            ),
            RT_TestWidget(
              key: GlobalKey('widget-3'),
              roEventHookUpdate: () => testStack.push('update-3'),
            ),
          ],
          parentContext: app!.appContext,
        );

        app!.framework.manageChildren(
          updateType: UpdateType.undefined,
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
      () {
        app!.framework.buildChildren(
          widgets: [
            RT_TestWidget(key: GlobalKey('widget-1')),
            RT_TestWidget(key: GlobalKey('widget-2')),
            RT_TestWidget(key: GlobalKey('widget-3')),
          ],
          parentContext: app!.appContext,
        );

        app!.framework.manageChildren(
          updateType: UpdateType.undefined,
          parentContext: app!.appContext,
          widgetActionCallback: (widgetObject) {
            return [WidgetAction.hideWidget];
          },
        );

        var widget1 = app!.services.walker.getWidgetObject('widget-1');
        var widget2 = app!.services.walker.getWidgetObject('widget-2');
        var widget3 = app!.services.walker.getWidgetObject('widget-3');

        expect(widget1!.element.classes.contains('rad-hidden'), equals(true));
        expect(widget2!.element.classes.contains('rad-hidden'), equals(true));
        expect(widget3!.element.classes.contains('rad-hidden'), equals(true));
      },
    );

    test(
      'should show widget when encounter show action',
      () {
        app!.framework.buildChildren(
          widgets: [
            RT_TestWidget(key: GlobalKey('widget-1')),
            RT_TestWidget(key: GlobalKey('widget-2')),
            RT_TestWidget(key: GlobalKey('widget-3')),
          ],
          parentContext: app!.appContext,
        );

        // first hide widgets

        app!.framework.manageChildren(
          updateType: UpdateType.undefined,
          parentContext: app!.appContext,
          widgetActionCallback: (widgetObject) {
            return [WidgetAction.hideWidget];
          },
        );

        app!.framework.manageChildren(
          updateType: UpdateType.undefined,
          parentContext: app!.appContext,
          widgetActionCallback: (widgetObject) {
            return [WidgetAction.showWidget];
          },
        );

        var widget1 = app!.services.walker.getWidgetObject('widget-1');
        var widget2 = app!.services.walker.getWidgetObject('widget-2');
        var widget3 = app!.services.walker.getWidgetObject('widget-3');

        expect(widget1!.element.classes.contains('rad-hidden'), equals(false));
        expect(widget2!.element.classes.contains('rad-hidden'), equals(false));
        expect(widget3!.element.classes.contains('rad-hidden'), equals(false));
      },
    );

    test(
      'should dispatch mixed actions',
      () {
        var testStack = RT_TestStack();

        app!.framework.buildChildren(
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
                  children: [],
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

        app!.framework.manageChildren(
          updateType: UpdateType.undefined,
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

        var widget1 = app!.services.walker.getWidgetObject('widget-1');
        var widget3 = app!.services.walker.getWidgetObject('widget-3');

        expect(widget1!.element.classes.contains('rad-hidden'), equals(false));
        expect(widget3!.element.classes.contains('rad-hidden'), equals(true));

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
