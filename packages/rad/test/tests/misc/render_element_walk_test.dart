// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '../../test_imports.dart';

void main() {
  /*
  |--------------------------------------------------------------------------
  | render element tests(APIs that might get missed in framework tests)
  |--------------------------------------------------------------------------
  */

  RT_AppRunner? app;

  setUp(() {
    app = createTestApp()..start();
  });

  tearDown(() => app!.stop());

  group('findAncestorWidgetOfExactType():', () {
    test('should return null if widget not found', () {
      var element = app!.appRenderElement;

      var widget = element.findAncestorWidgetOfExactType();

      expect(widget, equals(null));

      widget = element.findAncestorWidgetOfExactType<RT_TestWidget>();

      expect(widget, equals(null));
    });

    test(
      'should return matching widget from ancestors',
      () async {
        var pap = app!;

        await pap.buildChildren(
          widgets: [
            RT_TestWidget(),
            RT_TestWidget(
              children: [
                RT_AnotherTestWidget(key: Key('widget')),
              ],
            ),
          ],
          parentRenderElement: pap.appRenderElement,
        );

        var element = pap.renderElementByKeyValue('widget')!;

        var widget = element.findAncestorWidgetOfExactType<RT_TestWidget>();

        expect('${widget.runtimeType}', equals('$RT_TestWidget'));
      },
    );

    test(
      'should return nearest matching widget from ancestors',
      () async {
        var pap = app!;

        await pap.buildChildren(
          widgets: [
            RT_TestWidget(),
            RT_TestWidget(
              customHash: '1',
              children: [
                RT_TestWidget(
                  customHash: '2',
                  children: [
                    RT_AnotherTestWidget(key: Key('widget')),
                  ],
                ),
              ],
            ),
          ],
          parentRenderElement: pap.appRenderElement,
        );

        var element = pap.renderElementByKeyValue('widget')!;

        var widget = element.findAncestorWidgetOfExactType<RT_TestWidget>();

        expect('${widget.runtimeType}', equals('$RT_TestWidget'));
        expect((widget as RT_TestWidget).hash, equals('2'));
      },
    );

    test(
      'should return widget with exact runtime type(ignore super classes)',
      () async {
        var pap = app!;

        await pap.buildChildren(
          widgets: [
            RT_AnotherTestWidget(),
            RT_AnotherTestWidget(
              customHash: '1',
              children: [
                RT_TestWidget(
                  customHash: '2',
                  children: [
                    RT_AnotherTestWidget(key: Key('widget')),
                  ],
                ),
              ],
            ),
          ],
          parentRenderElement: pap.appRenderElement,
        );

        var el = pap.renderElementByKeyValue('widget')!;

        var widget = el.findAncestorWidgetOfExactType<RT_AnotherTestWidget>();

        expect('${widget.runtimeType}', equals('$RT_AnotherTestWidget'));
        expect((widget as RT_TestWidget).hash, equals('1'));
      },
    );

    test(
      'should return null if no direct ancestor matched',
      () async {
        var pap = app!;

        await pap.buildChildren(
          widgets: [
            RT_AnotherTestWidget(),
            RT_TestWidget(
              children: [
                RT_TestWidget(
                  children: [
                    RT_AnotherTestWidget(key: Key('widget')),
                  ],
                ),
              ],
            ),
          ],
          parentRenderElement: pap.appRenderElement,
        );

        var el = pap.renderElementByKeyValue('widget')!;

        var widget = el.findAncestorWidgetOfExactType<RT_AnotherTestWidget>();

        expect(widget, equals(null));
      },
    );
  });

  group('findAncestorStateOfType():', () {
    test(
      'should return null if widget with exact state not found',
      () async {
        var element = app!.appRenderElement;

        var state = element.findAncestorStateOfType();

        expect(state, equals(null));

        state = element.findAncestorStateOfType<RT_StatefulTestWidget_State>();

        expect(state, equals(null));
      },
    );

    test('should return matching state from ancestors', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_StatefulTestWidget(),
          RT_StatefulTestWidget(
            children: [
              RT_AnotherStatefulWidget(key: Key('widget')),
            ],
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var el = pap.renderElementByKeyValue('widget')!;

      var state = el.findAncestorStateOfType<RT_StatefulTestWidget_State>()!;

      expect('${state.runtimeType}', equals('$RT_StatefulTestWidget_State'));
    });

    test('should return nearest matching state from ancestors', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_StatefulTestWidget(),
          RT_StatefulTestWidget(
            customHash: '1',
            children: [
              RT_StatefulTestWidget(
                customHash: '2',
                children: [
                  RT_AnotherStatefulWidget(key: Key('widget')),
                ],
              ),
            ],
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var el = pap.renderElementByKeyValue('widget')!;

      var state = el.findAncestorStateOfType<RT_StatefulTestWidget_State>()!;

      expect('${state.runtimeType}', equals('$RT_StatefulTestWidget_State'));
      expect(state.widget.hash, equals('2'));
    });

    test('should return null if no direct ancestor matched', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_AnotherStatefulWidget(),
          RT_StatefulTestWidget(
            children: [
              RT_StatefulTestWidget(
                children: [
                  RT_AnotherStatefulWidget(key: Key('widget')),
                ],
              ),
            ],
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var el = pap.renderElementByKeyValue('widget')!;

      var state = el.findAncestorStateOfType<RT_AnotherStatefulWidget_State>();

      expect(state, equals(null));
    });
  });

  group('findClosestDomNodeInAncestors():', () {
    test(
      'should return ancestor element with dom node',
      () async {
        var pap = app!;

        await pap.buildChildren(
          widgets: [
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
          ],
          parentRenderElement: pap.appRenderElement,
        );
      },
    );

    test(
      'should return root if there are no ancestor elements with dom node',
      () async {
        var pap = app!;

        await pap.buildChildren(
          widgets: [
            RT_StatefulTestWidget(
              stateHookBuild: (state) {
                var element = state.context as RenderElement;

                expect(
                  // because test widget wraps widgets in a app widget
                  element.frameworkParent?.findClosestDomNodeInAncestors(),
                  equals(pap.appDomNode),
                );
              },
            ),
          ],
          parentRenderElement: pap.appRenderElement,
        );
      },
    );
  });

  group('findClosestDomNodeInDescendants():', () {
    test(
      'should return null if no dom node in descendants',
      () async {
        var pap = app!;

        await pap.buildChildren(
          widgets: [
            RT_StatefulTestWidget(
              stateHookBuild: (state) {
                expect(
                  state.context.findClosestDomNodeInDescendants(),
                  equals(null),
                );
              },
            ),
          ],
          parentRenderElement: pap.appRenderElement,
        );
      },
    );

    test(
      'should return nearest dom node in descendants',
      () async {
        var isFirstBuild = true;
        var pap = app!;

        await pap.buildChildren(
          widgets: [
            RT_StatefulTestWidget(
              stateHookBuild: (state) {
                // because child widgets will be built after first build
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
          ],
          parentRenderElement: pap.appRenderElement,
        );

        await pap.updateChildren(
          widgets: [
            RT_StatefulTestWidget(
              children: [
                Span(
                  children: [
                    Division(),
                  ],
                ),
              ],
            ),
          ],
          updateType: UpdateType.setState,
          parentRenderElement: pap.appRenderElement,
        );
      },
    );
  });

  group('findClosestDomNode():', () {
    test(
      'should try ancestors if cant find in descendants',
      () async {
        var pap = app!;

        await pap.buildChildren(
          widgets: [
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
          ],
          parentRenderElement: pap.appRenderElement,
        );
      },
    );

    test(
      'should try descendants first',
      () async {
        var isFirstBuild = true;
        var pap = app!;

        await pap.buildChildren(
          widgets: [
            RT_StatefulTestWidget(
              stateHookBuild: (state) {
                // because child widgets will be built after first build
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
          ],
          parentRenderElement: pap.appRenderElement,
        );

        await pap.updateChildren(
          widgets: [
            RT_StatefulTestWidget(
              children: [
                Span(
                  children: [
                    Division(),
                  ],
                ),
              ],
            ),
          ],
          updateType: UpdateType.setState,
          parentRenderElement: pap.appRenderElement,
        );
      },
    );
  });
}
