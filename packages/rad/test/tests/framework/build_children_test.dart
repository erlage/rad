import 'package:rad_test/rad_test.dart';

import '../../test_imports.dart';

/*
|--------------------------------------------------------------------------
| Component tests for core/framework
|--------------------------------------------------------------------------
*/

void main() {
  group('build widgets tests:', () {
    testWidgets('should build a single child', (tester) async {
      await tester.pumpWidget(
        Text('hello world'),
      );

      expect(tester.find.byType(Text), findsOneWidget);
      expect(tester.getAppDomNode, nodeHasContents('hello world'));
    });

    testWidgets('should build multiple childs', (tester) async {
      await tester.pumpMultipleWidgets([
        Text('child1'),
        Text('child2'),
      ]);

      expect(tester.find.byType(Text), findsNWidgets(2));
      expect(tester.getAppDomNode, nodeHasContents('child1|child2'));
    });

    testWidgets('should build nested childs', (tester) async {
      await tester.pumpWidget(
        Division(
          children: [
            Text('child1'),
            Division(child: Text('child2')),
            Text('child3'),
          ],
        ),
      );

      expect(tester.find.byType(Text), findsNWidgets(3));
      expect(tester.find.byType(Division), findsNWidgets(2));

      expect(tester.getAppDomNode, nodeHasContents('child1|child2|child3'));
    });

    testWidgets('should build mixed and nested childs', (tester) async {
      await tester.pumpWidget(
        Division(
          children: [
            Division(innerText: 'c1'),
            Text('c2'),
            Span(innerText: 'c3'),
            Division(
              children: [
                Text('c4'),
                Text('c5'),
              ],
            ),
            Text('c6'),
          ],
        ),
      );

      expect(tester.find.byType(Span), findsOneWidget);
      expect(tester.find.byType(Text), findsNWidgets(4));
      expect(tester.find.byType(Division), findsNWidgets(3));

      expect(tester.getAppDomNode, nodeHasContents('c1|c2|c3|c4|c5|c6'));
    });

    testWidgets('should mount', (tester) async {
      await tester.pumpMultipleWidgets([
        RT_TestWidget(),
        RT_TestWidget(),
      ]);

      expect(tester.find.byType(RT_TestWidget), areMounted);
    });

    testWidgets('should trigger afterMount hook after mount', (tester) async {
      await tester.pumpWidget(
        RT_TestWidget(
          roEventAfterMount: () {
            expect(tester.find.byType(RT_TestWidget), isMounted);
          },
        ),
      );

      await tester.pump();
    });

    testWidgets('should call render before mount', (tester) async {
      await tester.pumpWidget(
        RT_TestWidget(
          roEventRender: () {
            // if widget is not mounted, then test framework will not be able
            // to collect it. that's also the reason why we can't use the matcher
            // widgetObjectIsNotMounted here
            expect(tester.find.byType(RT_TestWidget), findsNothing);
          },
        ),
      );

      await tester.pump();
    });

    testWidgets(
      'should build widgets in order. mixed widgets test: '
      'widgets that have no corresponding dom tags and has direct childs',
      (tester) async {
        await tester.pumpMultipleWidgets([
          Text('widget 1'),
          RT_InheritedWidget(
            child: Division(
              children: [
                Text('widget 2'),
                Division(innerText: 'widget 3'),
              ],
            ),
          ),
          Text('widget 4'),
        ]);

        expect(tester.find.byType(Text), findsNWidgets(3));

        expect(
          tester.getAppDomNode,
          nodeHasContents('widget 1|widget 2|widget 3|widget 4'),
        );
      },
    );

    testWidgets(
      'should build widgets in order. mixed widgets test: '
      'widgets that has no corresponding dom tags and has non-direct childs',
      (tester) async {
        await tester.pumpMultipleWidgets([
          Text('widget 1'),
          RT_StatefulTestWidget(
            children: [
              Text('widget 2'),
              Division(innerText: 'widget 3'),
            ],
          ),
          Text('widget 4'),
        ]);

        expect(
          tester.getAppDomNode,
          nodeHasContents('widget 1|widget 2|widget 3|widget 4'),
        );
      },
    );

    testWidgets('should build widgets in order', (tester) async {
      await tester.pumpMultipleWidgets([
        RT_TestWidget(roEventRender: () => tester.push('build-1a')),
        RT_TestWidget(roEventRender: () => tester.push('build-1b')),
        RT_TestWidget(roEventRender: () => tester.push('build-1c')),
      ]);

      tester.assertMatchStack([
        'build-1a',
        'build-1b',
        'build-1c',
      ]);
    });

    testWidgets('should trigger hooks in order', (tester) async {
      await tester.pumpWidget(
        RT_TestWidget(
          // widget hooks

          wEventCreateRenderObject: () => tester.push(
            'createRenderObject',
          ),

          // render object hooks

          roEventRender: () => tester.push('render'),
          roEventAfterMount: () => tester.push('afterMount'),
        ),
      );

      tester.assertMatchStack([
        'createRenderObject',
        'render',
        'afterMount',
      ]);
    });

    testWidgets('should call init on alive render elements', (tester) async {
      await tester.pumpWidget(
        RT_TestWidget(
          // widget hooks

          wEventCreateRenderObject: () => tester.push(
            'createRenderElement',
          ),

          // render object hooks

          roEventInit: () => tester.push('init'),
          roEventRender: () => tester.push('render'),
          roEventAfterMount: () => tester.push('afterMount'),
        ),
      );

      tester.assertMatchStack([
        'createRenderElement',
        'init',
        'render',
        'afterMount',
      ]);
    });

    testWidgets('should build widgets, in order, from top', (tester) async {
      await tester.pumpWidget(
        RT_TestWidget(
          roEventRender: () => tester.push('render-root'),
          children: [
            RT_TestWidget(
              roEventRender: () => tester.push('render-0'),
              children: [
                RT_TestWidget(
                  roEventRender: () => tester.push('render-0-0'),
                ),
                RT_TestWidget(
                  roEventRender: () => tester.push('render-0-1'),
                  children: [
                    RT_TestWidget(
                      roEventRender: () => tester.push('render-0-1-0'),
                    ),
                    RT_TestWidget(
                      roEventRender: () => tester.push('render-0-1-1'),
                    ),
                  ],
                ),
              ],
            ),
            RT_TestWidget(
              roEventRender: () => tester.push('render-1'),
              children: [
                // nested child widgets
                RT_TestWidget(
                  roEventRender: () => tester.push('render-1-0'),
                ),
                RT_TestWidget(
                  roEventRender: () => tester.push('render-1-1'),
                ),
              ],
            ),
          ],
        ),
      );

      tester.assertMatchStack([
        'render-root',
        'render-0',
        'render-0-0',
        'render-0-1',
        'render-0-1-0',
        'render-0-1-1',
        'render-1',
        'render-1-0',
        'render-1-1',
      ]);
    });

    testWidgets(
      'should not dispose existing widgets when provided empty widget list',
      (tester) async {
        await tester.pumpMultipleWidgets([
          Text('this should presist'),
        ]);

        // try building, and provide no widgets to build

        await tester.pumpMultipleWidgets([]);

        expect(tester.getAppDomNode, nodeHasContents('this should presist'));
      },
    );

    testWidgets(
      'should dispose existing widgets when provided non-empty widgets list',
      (tester) async {
        // create root widget
        await tester.pumpWidget(
          Span(),
        );

        // rebuild root widget but with 8 child widgets (nested)
        await tester.pumpWidget(
          Span(
            children: [
              RT_TestWidget(
                children: [
                  RT_TestWidget(
                    children: [
                      RT_TestWidget(),
                      RT_TestWidget(),
                    ],
                  ),
                ],
              ),
              RT_TestWidget(
                children: [
                  RT_TestWidget(),
                  RT_TestWidget(),
                  RT_TestWidget(),
                ],
              ),
            ],
          ),
        );

        // ensure all child widgets are built
        expect(tester.find.byType(RT_TestWidget), findsNWidgets(8));

        // rebuild root widget but without any child widgets
        await tester.pumpWidget(Span());

        // ensure all child widgets are disposed off
        expect(tester.find.byType(RT_TestWidget), findsNothing);
      },
    );

    testWidgets(
      'should dispose widgets when flagCleanParentContents is off',
      (tester) async {
        await tester.pumpMultipleWidgets([
          Text('1'),
          Text('2'),
          Text('3'),
        ]);

        await tester.pumpMultipleWidgets([
          Text('4'),
        ], flagCleanParentContents: true);

        expect(tester.getAppDomNode, nodeHasContents('4'));
      },
    );

    testWidgets(
      'should not dispose widgets when flagCleanParentContents is off',
      (tester) async {
        await tester.pumpMultipleWidgets([
          Text('1'),
          Text('2'),
          Text('3'),
        ]);

        await tester.pumpMultipleWidgets([
          Text('4'),
        ], flagCleanParentContents: false);

        expect(tester.getAppDomNode, nodeHasContents('1|2|3|4'));
      },
    );

    testWidgets('should continue to append new widgets when clean flag is off',
        (tester) async {
      await tester.pumpWidget(
        Text('1'),
      );

      await tester.pumpWidget(
        Text('2'),
        flagCleanParentContents: false,
      );

      await tester.pumpMultipleWidgets([
        Text('3'),
        Text('4'),
      ], flagCleanParentContents: false);

      await tester.pumpWidget(
        Text('5'),
        flagCleanParentContents: false,
      );

      expect(tester.getAppDomNode, nodeHasContents('1|2|3|4|5'));
    });

    testWidgets('should mount at given index', (tester) async {
      await tester.pumpMultipleWidgets([
        Text('1'),
        Text('3'),
        Text('4'),
      ]);

      await tester.pumpWidget(
        Text('2'),
        mountAtIndex: 1,
        flagCleanParentContents: false,
      );

      expect(tester.getAppDomNode, nodeHasContents('1|2|3|4'));
    });

    testWidgets('should mount multiple widgets at given index', (tester) async {
      await tester.pumpMultipleWidgets([
        Text('1'),
        Text('4'),
      ]);

      await tester.pumpMultipleWidgets([
        Text('2'),
        Text('3'),
      ], mountAtIndex: 1, flagCleanParentContents: false);

      expect(tester.getAppDomNode, nodeHasContents('1|2|3|4'));
    });

    testWidgets('should mount at start', (tester) async {
      await tester.pumpWidget(Text('2'));

      await tester.pumpWidget(
        Text('1'),
        mountAtIndex: 0,
        flagCleanParentContents: false,
      );

      expect(tester.getAppDomNode, nodeHasContents('1|2'));
    });

    testWidgets('should mount at end', (tester) async {
      await tester.pumpWidget(
        Text('1'),
      );

      await tester.pumpWidget(
        Text('2'),
        mountAtIndex: 1,
        flagCleanParentContents: false,
      );

      expect(tester.getAppDomNode, nodeHasContents('1|2'));
    });

    testWidgets(
      'should mount at start if there are no exisiting widgets',
      (tester) async {
        await tester.pumpMultipleWidgets([]);

        await tester.pumpWidget(
          Text('1'),
          mountAtIndex: 0,
          flagCleanParentContents: false,
        );

        expect(tester.getAppDomNode, nodeHasContents('1'));
      },
    );

    testWidgets(
      'should mount at start if no exisiting widgets and index is OOBs',
      (tester) async {
        await tester.pumpMultipleWidgets([]);

        await tester.pumpWidget(
          Text('1'),
          mountAtIndex: 123,
          flagCleanParentContents: false,
        );

        expect(tester.getAppDomNode, nodeHasContents('1'));
      },
    );

    testWidgets(
      'should append if mount index is out of bounds',
      (tester) async {
        await tester.pumpWidget(
          Text('1'),
        );

        await tester.pumpWidget(
          Text('2'),
          mountAtIndex: 123,
          flagCleanParentContents: false,
        );

        await tester.pumpMultipleWidgets(
          [
            Text('3'),
            Text('4'),
          ],
          mountAtIndex: 123,
          flagCleanParentContents: false,
        );

        await tester.pumpWidget(
          Text('5'),
          mountAtIndex: -20,
          flagCleanParentContents: false,
        );

        await tester.pumpMultipleWidgets(
          [Text('6')],
          mountAtIndex: -20,
          flagCleanParentContents: false,
        );

        expect(tester.getAppDomNode, nodeHasContents('1|2|3|4|5|6'));
      },
    );

    testWidgets(
      'should clean & build if mount index is provided but clean flag is on',
      (tester) async {
        await tester.pumpMultipleWidgets([
          Text('1'),
          Text('3'),
          Text('4'),
        ]);

        await tester.pumpWidget(
          Text('2'),
          mountAtIndex: 1,
        );

        expect(tester.getAppDomNode, nodeHasContents('2'));
      },
    );
  });
}
