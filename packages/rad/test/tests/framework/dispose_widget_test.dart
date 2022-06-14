import 'package:rad_test/rad_test.dart';

import '../../test_imports.dart';

/*
|--------------------------------------------------------------------------
| Component tests for core/framework
|--------------------------------------------------------------------------
*/

void main() {
  group('dispose widget tests:', () {
    testWidgets('should dispose widget', (tester) async {
      var gkey = GlobalKey('gkey');

      await tester.pumpMultipleWidgets([
        Text('widget-1'),
        Text('widget-2', key: gkey),
        Text('widget-3'),
      ]);

      await tester.disposeWidget(
        renderElement: tester.getRenderElementByGlobalKey(gkey),
        flagPreserveTarget: false,
      );

      expect(tester.find.byType(Text), findsNWidgets(2));
      expect(tester.getAppDomNode, nodeHasContents('widget-1|widget-3'));
    });

    testWidgets(
      'should dispose exiting widgets if updated children list is empty',
      (tester) async {
        await tester.pumpMultipleWidgets([
          Text('widget-1'),
          Text('widget-2'),
          Text('widget-3'),
        ]);

        await tester.rePumpMultipleWidgets([]);

        expect(tester.find.byType(Text), findsNothing);
        expect(tester.getAppDomNode, nodeHasContents(''));
      },
    );

    testWidgets('should dispose single nested widget', (tester) async {
      var gkey = GlobalKey('child-0-0');

      await tester.pumpWidget(
        RT_TestWidget(
          children: [
            RT_TestWidget(
              children: [
                Text('0'),
                RT_TestWidget(
                  key: gkey,
                  children: [Text('0-0')],
                ),
                RT_TestWidget(
                  children: [Text('0-1')],
                ),
              ],
            ),
            RT_TestWidget(children: [Text('1')]),
          ],
        ),
      );

      await tester.disposeWidget(
        renderElement: tester.getRenderElementByGlobalKey(gkey),
        flagPreserveTarget: false,
      );

      expect(tester.find.byType(Text), findsNWidgets(3));
      expect(tester.getAppDomNode, nodeHasContents('0|0-1|1'));
    });

    testWidgets('should dispose multiple widgets', (tester) async {
      var gkey1 = GlobalKey('child-0-0');
      var gkey2 = GlobalKey('child-0-1');

      await tester.pumpWidget(
        RT_TestWidget(
          children: [
            RT_TestWidget(
              children: [
                Text('0'),
                RT_TestWidget(
                  key: gkey1,
                  children: [Text('0-0')],
                ),
                RT_TestWidget(
                  key: gkey2,
                  children: [Text('0-1')],
                ),
              ],
            ),
            RT_TestWidget(children: [Text('1')]),
          ],
        ),
      );

      await tester.disposeWidget(
        renderElement: tester.getRenderElementByGlobalKey(gkey1),
        flagPreserveTarget: false,
      );

      await tester.disposeWidget(
        renderElement: tester.getRenderElementByGlobalKey(gkey2),
        flagPreserveTarget: false,
      );

      expect(tester.find.byType(Text), findsNWidgets(2));
      expect(tester.getAppDomNode, nodeHasContents('0|1'));
    });

    testWidgets('should dispose widgets recursively', (tester) async {
      var gkey = GlobalKey('child-0');

      await tester.pumpWidget(
        RT_TestWidget(
          key: GlobalKey('widget'),
          children: [
            RT_TestWidget(
              key: gkey,
              children: [
                Text('0'),
                RT_TestWidget(
                  children: [Text('0-0')],
                ),
                RT_TestWidget(
                  children: [Text('0-1')],
                ),
              ],
            ),
            RT_TestWidget(children: [Text('1')]),
          ],
        ),
      );

      await tester.disposeWidget(
        renderElement: tester.getRenderElementByGlobalKey(gkey),
        flagPreserveTarget: false,
      );

      expect(tester.find.byType(Text), findsOneWidget);
      expect(tester.getAppDomNode, nodeHasContents('1'));
    });

    testWidgets('method call should be idempotent', (tester) async {
      var gkey = GlobalKey('widget');

      await tester.pumpWidget(
        RT_TestWidget(key: gkey),
      );

      expect(tester.find.byType(RT_TestWidget), findsOneWidget);

      await tester.disposeWidget(
        renderElement: tester.getRenderElementByGlobalKey(gkey),
        flagPreserveTarget: false,
      );

      expect(tester.find.byType(RT_TestWidget), findsNothing);

      await tester.disposeWidget(
        renderElement: tester.getRenderElementByGlobalKey(gkey),
        flagPreserveTarget: false,
      );

      await tester.disposeWidget(
        renderElement: tester.getRenderElementByGlobalKey(gkey),
        flagPreserveTarget: false,
      );

      expect(tester.find.byType(RT_TestWidget), findsNothing);
    });

    testWidgets('should preserve target(parent) when asked to', (tester) async {
      var gkey = GlobalKey('child-0');

      await tester.pumpWidget(
        RT_TestWidget(
          children: [
            RT_TestWidget(
              children: [
                Text('0'),
                RT_TestWidget(
                  key: gkey,
                  children: [Text('0-0')],
                ),
                RT_TestWidget(
                  children: [Text('0-1')],
                ),
              ],
            ),
            RT_TestWidget(children: [Text('1')]),
          ],
        ),
      );

      await tester.disposeWidget(
        renderElement: tester.getRenderElementByGlobalKey(gkey),
        flagPreserveTarget: true,
      );

      expect(tester.find.byType(Text), findsNWidgets(3));
      expect(tester.find.byType(RT_TestWidget), findsNWidgets(5));
    });

    testWidgets(
      'should dispose existing widgets, in order, starting from bottom',
      (tester) async {
        var gkey = GlobalKey('widget');

        // create app widget containing some child widgets to test

        await tester.pumpWidget(
          RT_TestWidget(
            key: gkey,
            roEventBeforeUnMount: () => tester.push('root-dispose'),
            children: [
              RT_TestWidget(
                roEventBeforeUnMount: () => tester.push('dispose-0'),
                children: [
                  RT_TestWidget(
                    roEventBeforeUnMount: () => tester.push('dispose-0-0'),
                  ),
                  RT_TestWidget(
                    roEventBeforeUnMount: () => tester.push('dispose-0-1'),
                    children: [
                      RT_TestWidget(
                        roEventBeforeUnMount: () => tester.push(
                          'dispose-0-1-0',
                        ),
                      ),
                      RT_TestWidget(
                        roEventBeforeUnMount: () => tester.push(
                          'dispose-0-1-1',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              RT_TestWidget(
                roEventBeforeUnMount: () => tester.push('dispose-1'),
                children: [
                  // nested child widgets
                  RT_TestWidget(
                    roEventBeforeUnMount: () => tester.push('dispose-1-0'),
                  ),
                  RT_TestWidget(
                    roEventBeforeUnMount: () => tester.push('dispose-1-1'),
                  ),
                ],
              ),
            ],
          ),
        );

        // expected tree and dispose order:
        //
        // 0             : d(4)
        //    0-0        : d(0) - first dispose
        //    0-1        : d(3)
        //        0-1-0  : d(1) - second dispose
        //        0-1-1  : d(2) - third dispose, and so on
        // 1             : d(7)
        //    1-0        : d(5)
        //    1-1        : d(6)
        //

        await tester.disposeWidget(
          renderElement: tester.getRenderElementByGlobalKey(gkey),
          flagPreserveTarget: true,
        );

        tester.assertMatchStack([
          'dispose-0-0',
          'dispose-0-1-0',
          'dispose-0-1-1',
          'dispose-0-1',
          'dispose-0',
          'dispose-1-0',
          'dispose-1-1',
          'dispose-1',
        ]);
      },
    );
  });
}
