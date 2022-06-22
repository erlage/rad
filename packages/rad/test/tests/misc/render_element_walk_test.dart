import 'package:rad_test/rad_test.dart';

import '../../test_imports.dart';

void main() {
  /*
  |--------------------------------------------------------------------------
  | render element tests(APIs that might get missed in framework tests)
  |--------------------------------------------------------------------------
  */

  group('findAncestorWidgetOfExactType():', () {
    RT_AppRunner? app;
    setUp(() => app = createTestApp()..start());
    tearDown(() => app!.stop());

    testWidgets('should return null if widget not found', (tester) {
      var element = tester.app.appRenderElement;

      var widget = element.findAncestorWidgetOfExactType();

      expect(widget, equals(null));

      widget = element.findAncestorWidgetOfExactType<RT_TestWidget>();

      expect(widget, equals(null));
    });

    testWidgets(
      'should return matching widget from ancestors',
      (tester) async {
        await tester.pumpMultipleWidgets(
          [
            RT_TestWidget(),
            RT_TestWidget(
              children: [
                RT_AnotherTestWidget(key: GlobalKey('widget')),
              ],
            ),
          ],
        );

        var element = tester.getRenderElementByGlobalKey(GlobalKey('widget'))!;

        var widget = element.findAncestorWidgetOfExactType<RT_TestWidget>();

        expect('${widget.runtimeType}', equals('$RT_TestWidget'));
      },
    );

    testWidgets(
      'should return nearest matching widget from ancestors',
      (tester) async {
        await tester.pumpMultipleWidgets(
          [
            RT_TestWidget(),
            RT_TestWidget(
              customHash: '1',
              children: [
                RT_TestWidget(
                  customHash: '2',
                  children: [
                    RT_AnotherTestWidget(key: GlobalKey('widget')),
                  ],
                ),
              ],
            ),
          ],
        );

        var element = tester.getRenderElementByGlobalKey(GlobalKey('widget'))!;

        var widget = element.findAncestorWidgetOfExactType<RT_TestWidget>();

        expect('${widget.runtimeType}', equals('$RT_TestWidget'));
        expect((widget as RT_TestWidget).hash, equals('2'));
      },
    );

    testWidgets(
      'should return widget with exact runtime type(ignore super classes)',
      (tester) async {
        await tester.pumpMultipleWidgets(
          [
            RT_AnotherTestWidget(),
            RT_AnotherTestWidget(
              customHash: '1',
              children: [
                RT_TestWidget(
                  customHash: '2',
                  children: [
                    RT_AnotherTestWidget(key: GlobalKey('widget')),
                  ],
                ),
              ],
            ),
          ],
        );

        var el = tester.getRenderElementByGlobalKey(GlobalKey('widget'))!;

        var widget = el.findAncestorWidgetOfExactType<RT_AnotherTestWidget>();

        expect('${widget.runtimeType}', equals('$RT_AnotherTestWidget'));
        expect((widget as RT_TestWidget).hash, equals('1'));
      },
    );

    testWidgets(
      'should return null if no direct ancestor matched',
      (tester) async {
        await tester.pumpMultipleWidgets(
          [
            RT_AnotherTestWidget(),
            RT_TestWidget(
              children: [
                RT_TestWidget(
                  children: [
                    RT_AnotherTestWidget(key: GlobalKey('widget')),
                  ],
                ),
              ],
            ),
          ],
        );

        var el = tester.getRenderElementByGlobalKey(GlobalKey('widget'))!;

        var widget = el.findAncestorWidgetOfExactType<RT_AnotherTestWidget>();

        expect(widget, equals(null));
      },
    );
  });

  group('findAncestorStateOfType():', () {
    testWidgets(
      'should return null if widget with exact state not found',
      (tester) async {
        var element = tester.app.appRenderElement;

        var state = element.findAncestorStateOfType();

        expect(state, equals(null));

        state = element.findAncestorStateOfType<RT_StatefulTestWidget_State>();

        expect(state, equals(null));
      },
    );

    testWidgets('should return matching state from ancestors', (tester) async {
      await tester.pumpMultipleWidgets(
        [
          RT_StatefulTestWidget(),
          RT_StatefulTestWidget(
            children: [
              RT_AnotherStatefulWidget(key: GlobalKey('widget')),
            ],
          ),
        ],
      );

      var el = tester.getRenderElementByGlobalKey(GlobalKey('widget'))!;

      var state = el.findAncestorStateOfType<RT_StatefulTestWidget_State>()!;

      expect('${state.runtimeType}', equals('$RT_StatefulTestWidget_State'));
    });

    testWidgets('should return nearest matching state from ancestors',
        (tester) async {
      await tester.pumpMultipleWidgets(
        [
          RT_StatefulTestWidget(),
          RT_StatefulTestWidget(
            customHash: '1',
            children: [
              RT_StatefulTestWidget(
                customHash: '2',
                children: [
                  RT_AnotherStatefulWidget(key: GlobalKey('widget')),
                ],
              ),
            ],
          ),
        ],
      );

      var el = tester.getRenderElementByGlobalKey(GlobalKey('widget'))!;

      var state = el.findAncestorStateOfType<RT_StatefulTestWidget_State>()!;

      expect('${state.runtimeType}', equals('$RT_StatefulTestWidget_State'));
      expect(state.widget.hash, equals('2'));
    });

    testWidgets('should return null if no direct ancestor matched',
        (tester) async {
      await tester.pumpMultipleWidgets(
        [
          RT_AnotherStatefulWidget(),
          RT_StatefulTestWidget(
            children: [
              RT_StatefulTestWidget(
                children: [
                  RT_AnotherStatefulWidget(key: GlobalKey('widget')),
                ],
              ),
            ],
          ),
        ],
      );

      var el = tester.getRenderElementByGlobalKey(GlobalKey('widget'))!;

      var state = el.findAncestorStateOfType<RT_AnotherStatefulWidget_State>();

      expect(state, equals(null));
    });
  });

  group('findClosestDomNodeInAncestors():', () {
    testWidgets(
      'should return ancestor element with dom node',
      (tester) async {
        await tester.pumpWidget(
          Paragraph(
            children: [
              RT_StatefulTestWidget(
                stateHookBuild: (state) {
                  expect(
                    state.context.findClosestDomNodeInAncestors()?.tagName,
                    equals('P'),
                  );
                },
              ),
            ],
          ),
        );
      },
    );

    testWidgets(
      'should return root if there are no ancestor elements with dom node',
      (tester) async {
        await tester.pumpWidget(
          RT_StatefulTestWidget(
            stateHookBuild: (state) {
              var element = state.context as RenderElement;

              expect(
                // because test widget wraps widgets in a app widget
                element.frameworkParent?.findClosestDomNodeInAncestors(),
                equals(tester.getAppDomNode),
              );
            },
          ),
        );
      },
    );
  });

  group('findClosestDomNodeInDescendants():', () {
    testWidgets(
      'should return null if no dom node in descendants',
      (tester) async {
        await tester.pumpWidget(
          RT_StatefulTestWidget(
            stateHookBuild: (state) {
              expect(
                state.context.findClosestDomNodeInDescendants(),
                equals(null),
              );
            },
          ),
        );
      },
    );

    testWidgets(
      'should return nearest dom node in descendants',
      (tester) async {
        var isFirstBuild = true;

        await tester.pumpWidget(
          RT_StatefulTestWidget(
            stateHookBuild: (state) {
              // because childs widgets will be built after first build
              if (isFirstBuild) {
                isFirstBuild = false;

                return;
              }

              // because test stateful widget wraps child list in a test widget
              // we've to unwrap context of that wrapper test widget to test

              var currentContext = state.context as RenderElement;
              var actualContext = currentContext.frameworkChildElements.first;

              var node = actualContext.findClosestDomNodeInDescendants();

              expect(node?.tagName, equals('SPAN'));
            },
            children: [
              // should match span not div
              Span(
                children: [
                  Division(),
                ],
              ),
            ],
          ),
        );

        await tester.rePumpWidget(
          RT_StatefulTestWidget(
            children: [
              Span(
                children: [
                  Division(),
                ],
              ),
            ],
          ),
        );
      },
    );
  });

  group('findClosestDomNode():', () {
    testWidgets(
      'should try ancestors if cant find in descendants',
      (tester) async {
        await tester.pumpWidget(
          Paragraph(
            children: [
              RT_StatefulTestWidget(
                stateHookBuild: (state) {
                  expect(
                    state.context.findClosestDomNode(),
                    state.context.findClosestDomNodeInAncestors(),
                  );
                },
                children: [
                  Division(),
                ],
              ),
            ],
          ),
        );
      },
    );

    testWidgets(
      'should try descendants first',
      (tester) async {
        var isFirstBuild = true;

        await tester.pumpWidget(
          RT_StatefulTestWidget(
            stateHookBuild: (state) {
              // because childs widgets will be built after first build
              if (isFirstBuild) {
                isFirstBuild = false;

                return;
              }

              expect(
                state.context.findClosestDomNode(),
                state.context.findClosestDomNodeInDescendants(),
              );
            },
            children: [
              // should match span not div
              Span(
                children: [
                  Division(),
                ],
              ),
            ],
          ),
        );

        await tester.rePumpWidget(
          RT_StatefulTestWidget(
            children: [
              Span(
                children: [
                  Division(),
                ],
              ),
            ],
          ),
        );
      },
    );
  });
}
