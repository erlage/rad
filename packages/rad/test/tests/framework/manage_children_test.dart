import 'package:rad_test/rad_test.dart';

import '../../test_imports.dart';

/*
|--------------------------------------------------------------------------
| Component tests for core/framework
|--------------------------------------------------------------------------
*/

void main() {
  group('manage children tests:', () {
    testWidgets(
      'should iterate over all childs in insertion order if '
      'flagIterateInReverseOrder is not set',
      (tester) async {
        await tester.pumpMultipleWidgets([
          RT_TestWidget(customHash: 'widget-1'),
          RT_TestWidget(customHash: 'widget-2'),
          RT_TestWidget(customHash: 'widget-3'),
          RT_TestWidget(customHash: 'widget-4'),
          RT_TestWidget(customHash: 'widget-5'),
        ]);

        await tester.visitChildren(
          updateType: UpdateType.visitorUpdate,
          parentRenderElement: tester.app.appRenderElement,
          widgetActionCallback: (renderElement) {
            var widget = renderElement.widget;

            if (widget is RT_TestWidget) {
              tester.push(widget.hash);
            }

            return [];
          },
        );

        tester.assertMatchStack([
          'widget-1',
          'widget-2',
          'widget-3',
          'widget-4',
          'widget-5',
        ]);
      },
    );

    testWidgets(
      'should iterate over all childs in insertion order if '
      'flagIterateInReverseOrder: false',
      (tester) async {
        await tester.pumpMultipleWidgets([
          RT_TestWidget(customHash: 'widget-1'),
          RT_TestWidget(customHash: 'widget-2'),
          RT_TestWidget(customHash: 'widget-3'),
          RT_TestWidget(customHash: 'widget-4'),
          RT_TestWidget(customHash: 'widget-5'),
        ]);

        await tester.visitChildren(
          updateType: UpdateType.visitorUpdate,
          parentRenderElement: tester.app.appRenderElement,
          flagIterateInReverseOrder: false,
          widgetActionCallback: (renderElement) {
            var widget = renderElement.widget;

            if (widget is RT_TestWidget) {
              tester.push(widget.hash);
            }

            return [];
          },
        );

        tester.assertMatchStack([
          'widget-1',
          'widget-2',
          'widget-3',
          'widget-4',
          'widget-5',
        ]);
      },
    );

    testWidgets(
      'should iterate over all childs in reverse order if '
      'flagIterateInReverseOrder: true',
      (tester) async {
        await tester.pumpMultipleWidgets([
          RT_TestWidget(customHash: 'widget-1'),
          RT_TestWidget(customHash: 'widget-2'),
          RT_TestWidget(customHash: 'widget-3'),
          RT_TestWidget(customHash: 'widget-4'),
          RT_TestWidget(customHash: 'widget-5'),
        ]);

        await tester.visitChildren(
          updateType: UpdateType.visitorUpdate,
          parentRenderElement: tester.app.appRenderElement,
          flagIterateInReverseOrder: true,
          widgetActionCallback: (renderElement) {
            var widget = renderElement.widget;

            if (widget is RT_TestWidget) {
              tester.push(widget.hash);
            }

            return [];
          },
        );

        tester.assertMatchStack([
          'widget-5',
          'widget-4',
          'widget-3',
          'widget-2',
          'widget-1',
        ]);
      },
    );

    testWidgets(
      'should iterate over only childs at one level',
      (tester) async {
        await tester.pumpMultipleWidgets([
          RT_TestWidget(customHash: 'widget-1'),
          RT_TestWidget(customHash: 'widget-2'),
          RT_TestWidget(customHash: 'widget-3', children: [
            RT_TestWidget(customHash: 'widget-3-1'),
            RT_TestWidget(customHash: 'widget-3-2'),
          ]),
          RT_TestWidget(customHash: 'widget-4'),
          RT_TestWidget(customHash: 'widget-5'),
        ]);

        await tester.visitChildren(
          updateType: UpdateType.visitorUpdate,
          parentRenderElement: tester.app.appRenderElement,
          widgetActionCallback: (renderElement) {
            var widget = renderElement.widget;

            if (widget is RT_TestWidget) {
              tester.push(widget.hash);
            }

            return [];
          },
        );

        tester.assertMatchStack([
          'widget-1',
          'widget-2',
          'widget-3',
          'widget-4',
          'widget-5',
        ]);
      },
    );

    testWidgets(
      'should short circuite further iterations when encounters skip',
      (tester) async {
        await tester.pumpMultipleWidgets([
          RT_TestWidget(customHash: 'widget-1'),
          RT_TestWidget(customHash: 'widget-2'),
          RT_TestWidget(customHash: 'widget-3'),
          RT_TestWidget(customHash: 'widget-4'),
          RT_TestWidget(customHash: 'widget-5'),
        ]);

        await tester.visitChildren(
          updateType: UpdateType.visitorUpdate,
          parentRenderElement: tester.app.appRenderElement,
          widgetActionCallback: (renderElement) {
            var widget = renderElement.widget;

            if (widget is RT_TestWidget) {
              tester.push(widget.hash);

              if ('widget-3' == widget.hash) {
                return [WidgetAction.skipRest];
              }
            }

            return [];
          },
        );

        tester.assertMatchStack([
          'widget-1',
          'widget-2',
          'widget-3',
        ]);
      },
    );

    testWidgets(
      'should dispose widget when encounter dispose action',
      (tester) async {
        await tester.pumpMultipleWidgets([
          RT_TestWidget(
            customHash: 'widget-1',
            roEventAfterUnMount: () => tester.push('dispose 1'),
          ),
          RT_TestWidget(
            customHash: 'widget-2',
            roEventAfterUnMount: () => tester.push('dispose 2'),
          ),
          RT_TestWidget(
            customHash: 'widget-3',
            roEventAfterUnMount: () => tester.push('dispose 3'),
          ),
          RT_TestWidget(
            customHash: 'widget-4',
            roEventAfterUnMount: () => tester.push('dispose 3'),
          ),
        ]);

        await tester.visitChildren(
          updateType: UpdateType.visitorUpdate,
          parentRenderElement: tester.app.appRenderElement,
          widgetActionCallback: (renderElement) {
            var widget = renderElement.widget;

            if (widget is RT_TestWidget) {
              tester.push(widget.hash);

              if ('widget-3' == widget.hash) {
                return [WidgetAction.skipRest];
              }
            }

            return [WidgetAction.dispose];
          },
        );

        await tester.pump();

        tester.assertMatchStack([
          'widget-1',
          'widget-2',
          'widget-3',
          'dispose 1',
          'dispose 2',
        ]);
      },
    );

    testWidgets(
      'should update widget when encounter update action',
      (tester) async {
        await tester.pumpMultipleWidgets([
          RT_TestWidget(
            customHash: 'widget-1',
            roEventUpdate: () => tester.push('update-1'),
          ),
          RT_TestWidget(
            customHash: 'widget-2',
            roEventUpdate: () => tester.push('update-2'),
            children: [
              RT_TestWidget(
                customHash: 'widget-2-1',
                children: [
                  RT_TestWidget(
                    customHash: 'widget-2-1-1',
                    children: [],
                    roEventUpdate: () => tester.push('update-2-1-1'),
                  ),
                ],
                roEventUpdate: () => tester.push('update-2-1'),
              ),
            ],
          ),
          RT_TestWidget(
            customHash: 'widget-3',
            roEventUpdate: () => tester.push('update-3'),
          ),
        ]);

        await tester.visitChildren(
          updateType: UpdateType.visitorUpdate,
          parentRenderElement: tester.app.appRenderElement,
          widgetActionCallback: (renderElement) {
            var widget = renderElement.widget;

            if (widget is RT_TestWidget) {
              tester.push(widget.hash);
            }

            return [WidgetAction.updateWidget];
          },
        );

        tester.assertMatchStack([
          'widget-1',
          'widget-2',
          'widget-3',
          'update-1',
          'update-2',
          'update-2-1',
          'update-3',
        ]);
      },
    );

    testWidgets(
      'should hide widget when encounter hide action',
      (tester) async {
        await tester.pumpMultipleWidgets([
          RT_TestWidget(key: GlobalKey('1')),
          RT_TestWidget(key: GlobalKey('2')),
          RT_TestWidget(key: GlobalKey('3')),
        ]);

        await tester.visitChildren(
          updateType: UpdateType.visitorUpdate,
          parentRenderElement: tester.app.appRenderElement,
          widgetActionCallback: (renderElement) {
            return [WidgetAction.hideWidget];
          },
        );

        var node1 = tester
            .getRenderElementByGlobalKey(GlobalKey(
              '1',
            ))!
            .findClosestDomNode();

        var node2 = tester
            .getRenderElementByGlobalKey(GlobalKey(
              '2',
            ))!
            .findClosestDomNode();

        var node3 = tester
            .getRenderElementByGlobalKey(GlobalKey(
              '3',
            ))!
            .findClosestDomNode();

        expect(node1.classes.contains(Constants.classHidden), equals(true));
        expect(node2.classes.contains(Constants.classHidden), equals(true));
        expect(node3.classes.contains(Constants.classHidden), equals(true));
      },
    );

    testWidgets(
      'should show widget when encounter show action',
      (tester) async {
        await tester.pumpMultipleWidgets([
          RT_TestWidget(key: GlobalKey('1')),
          RT_TestWidget(key: GlobalKey('2')),
          RT_TestWidget(key: GlobalKey('3')),
        ]);

        // first hide widgets
        await tester.visitChildren(
          updateType: UpdateType.visitorUpdate,
          parentRenderElement: tester.app.appRenderElement,
          widgetActionCallback: (renderElement) {
            return [WidgetAction.hideWidget];
          },
        );

        // then show widgets
        await tester.visitChildren(
          updateType: UpdateType.visitorUpdate,
          parentRenderElement: tester.app.appRenderElement,
          widgetActionCallback: (renderElement) {
            return [WidgetAction.showWidget];
          },
        );

        var node1 = tester
            .getRenderElementByGlobalKey(GlobalKey(
              '1',
            ))!
            .findClosestDomNode();

        var node2 = tester
            .getRenderElementByGlobalKey(GlobalKey(
              '2',
            ))!
            .findClosestDomNode();

        var node3 = tester
            .getRenderElementByGlobalKey(GlobalKey(
              '3',
            ))!
            .findClosestDomNode();

        expect(node1.classes.contains(Constants.classHidden), equals(false));
        expect(node2.classes.contains(Constants.classHidden), equals(false));
        expect(node3.classes.contains(Constants.classHidden), equals(false));
      },
    );

    testWidgets(
      'should dispatch mixed actions',
      (tester) async {
        await tester.pumpMultipleWidgets([
          RT_TestWidget(
            key: GlobalKey('1'),
            customHash: 'widget-1',
            roEventUpdate: () => tester.push('update-1'),
            roEventAfterUnMount: () => tester.push('dispose-1'),
          ),
          RT_TestWidget(
            customHash: 'widget-2',
            children: [
              RT_TestWidget(
                customHash: 'widget-2-1',
                children: [
                  RT_TestWidget(
                    customHash: 'widget-2-1-1',
                    children: [],
                    // should never cascade update to this level
                    roEventUpdate: () => tester.push('update-2-1-1'),
                  ),
                ],
                roEventUpdate: () => tester.push('update-2-1'),
                roEventAfterUnMount: () => tester.push('dispose-2-1'),
              ),
            ],
            roEventUpdate: () => tester.push('update-2'),
            roEventAfterUnMount: () => tester.push('dispose-2'),
          ),
          RT_TestWidget(
            key: GlobalKey('3'),
            customHash: 'widget-3',
            roEventUpdate: () => tester.push('update-3'),
            roEventAfterUnMount: () => tester.push('dispose-3'),
          ),
          RT_TestWidget(customHash: 'widget-4'),
        ]);

        await tester.visitChildren(
          updateType: UpdateType.visitorUpdate,
          parentRenderElement: tester.app.appRenderElement,
          widgetActionCallback: (renderElement) {
            var widget = renderElement.widget;

            if (widget is RT_TestWidget) {
              var hash = widget.hash;
              tester.push(hash);

              switch (hash) {
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
            }

            return [];
          },
        );

        var node1 = tester
            .getRenderElementByGlobalKey(GlobalKey(
              '1',
            ))!
            .findClosestDomNode();

        var node3 = tester
            .getRenderElementByGlobalKey(GlobalKey(
              '3',
            ))!
            .findClosestDomNode();

        expect(node1.classes.contains(Constants.classHidden), equals(false));
        expect(node3.classes.contains(Constants.classHidden), equals(true));

        // ensure all are iterated except last

        tester.assertMatchStack([
          'widget-1',
          'widget-2',
          'widget-3',
          'update-2',
          'update-2-1',
          'dispose-2-1',
          'dispose-2',
        ]);
      },
    );
  });
}
