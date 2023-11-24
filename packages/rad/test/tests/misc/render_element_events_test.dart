// Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: prefer_function_declarations_over_variables

import '../../test_imports.dart';

void main() {
  group('basic', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('should not add render event listeners by default', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          RT_RenderAbleWidget(key: Key('widget')),
        ],
        parentRenderElement: pap.appRenderElement,
      );
      var renderElement = pap.renderElementByKeyValue('widget')!;
      var eventListeners = renderElement.frameworkRenderEventListeners;

      for (final renderEventType in RenderEventType.values) {
        expect(eventListeners[renderEventType], equals(null));
      }
    });

    test('should add event listeners ', () async {
      var pap = app!;

      var didRender = (e) => {};
      var didUpdate = (e) => {};
      var willUnMount = (e) => {};
      var didUnMount = (e) => {};

      await pap.buildChildren(
        widgets: [
          RT_RenderAbleWidget(
            key: Key('widget'),
            eventDidRender: didRender,
            eventDidUpdate: didUpdate,
            eventWillUnMount: willUnMount,
            eventDidUnMount: didUnMount,
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );
      var renderElement = pap.renderElementByKeyValue('widget')!;
      var eventListeners = renderElement.frameworkRenderEventListeners;

      expect(
        eventListeners[RenderEventType.didRender],
        equals(didRender),
      );
      expect(
        eventListeners[RenderEventType.didUpdate],
        equals(didUpdate),
      );
      expect(
        eventListeners[RenderEventType.didUnMount],
        equals(didUnMount),
      );
      expect(
        eventListeners[RenderEventType.willUnMount],
        equals(willUnMount),
      );
    });
  });

  group('lifecycle', () {
    test('should call register exactly once before render', () async {
      var app = createTestApp()..start();
      var stack = RT_TestStack();

      await app.buildChildren(
        widgets: [
          RT_RenderAbleWidget(
            eventRegister: () => stack.push('register'),
            eventRender: () => stack.push('render'),
          ),
        ],
        parentRenderElement: app.appRenderElement,
      );

      app.stop();
      await Future.delayed(Duration(milliseconds: 100));

      expect(stack.popFromStart(), equals('register'));
      expect(stack.popFromStart(), equals('render'));
      expect(stack.canPop(), equals(false));
    });

    test(
      'should call render '
      ', exactly once '
      ', after register '
      ', before didRender ',
      () async {
        var app = createTestApp()..start();
        var stack = RT_TestStack();

        await app.buildChildren(
          widgets: [
            RT_RenderAbleWidget(
              eventRegister: () => stack.push('register'),
              eventRender: () => stack.push('render'),
              eventDidRender: (e) => stack.push('after render'),
            ),
          ],
          parentRenderElement: app.appRenderElement,
        );

        await app.updateChildren(
          widgets: [
            RT_RenderAbleWidget(
              eventRegister: () => stack.push('register'),
              eventRender: () => stack.push('render'),
              eventDidRender: (e) => stack.push('after render'),
            ),
          ],
          updateType: UpdateType.setState,
          parentRenderElement: app.appRenderElement,
        );

        app.stop();
        await Future.delayed(Duration(milliseconds: 100));

        expect(stack.popFromStart(), equals('register'));
        expect(stack.popFromStart(), equals('render'));
        expect(stack.popFromStart(), equals('after render'));
        expect(stack.canPop(), equals(false));
      },
    );

    test('should call didRender in order for nested children', () async {
      var app = createTestApp()..start();
      var stack = RT_TestStack();

      await app.buildChildren(
        widgets: [
          RT_RenderAbleWidget(
            children: [
              RT_RenderAbleWidget(
                children: [Text('inner contents')],
                eventRender: () => stack.push('inner render'),
                eventDidRender: (_) => stack.push('inner after render'),
              )
            ],
            eventRender: () => stack.push('outer render'),
            eventDidRender: (_) => stack.push('outer after render'),
          ),
        ],
        parentRenderElement: app.appRenderElement,
      );

      app.stop();
      await Future.delayed(Duration(milliseconds: 100));

      expect(stack.popFromStart(), equals('outer render'));
      expect(stack.popFromStart(), equals('inner render'));
      expect(stack.popFromStart(), equals('inner after render'));
      expect(stack.popFromStart(), equals('outer after render'));
      expect(stack.canPop(), equals(false));
    });

    test('should call update after render', () async {
      var app = createTestApp()..start();
      var stack = RT_TestStack();

      await app.buildChildren(
        widgets: [
          RT_RenderAbleWidget(
            children: [Text('hello world')],
            eventRender: () => stack.push('render'),
            eventUpdate: () => stack.push('update'),
          ),
        ],
        parentRenderElement: app.appRenderElement,
      );

      await app.updateChildren(
        widgets: [
          RT_RenderAbleWidget(
            children: [Text('hello world')],
            eventRender: () => stack.push('render'),
            eventUpdate: () => stack.push('update'),
          ),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app.appRenderElement,
      );

      app.stop();
      await Future.delayed(Duration(milliseconds: 100));

      expect(stack.popFromStart(), equals('render'));
      expect(stack.popFromStart(), equals('update'));
      expect(stack.canPop(), equals(false));
    });

    test('should call willUnMount before actual un-mount', () async {
      var stack = RT_TestStack();

      var runner = runApp(
        app: RT_RenderAbleWidget(
          children: [Text('hello world')],
          eventWillUnMount: (e) {
            stack.push('before un-mount');
            expect(RT_TestBed.rootDomNode, RT_hasContents('hello world'));
          },
        ),
        appTargetId: RT_TestBed.rootTargetId,
      );

      await Future.delayed(Duration(milliseconds: 100));
      runner.stop();
      await Future.delayed(Duration(milliseconds: 100));

      expect(stack.popFromStart(), equals('before un-mount'));
      expect(stack.canPop(), equals(false));
    });

    test(
      'should call didRender '
      ', exactly once '
      ', after render ',
      () async {
        var app = createTestApp()..start();
        var stack = RT_TestStack();

        await app.buildChildren(
          widgets: [
            RT_RenderAbleWidget(
              children: [Text('hello world')],
              eventRender: () => stack.push('render'),
              eventDidRender: (e) {
                stack.push('after render');

                expect(app.appDomNode, RT_hasContents('hello world'));
              },
            ),
          ],
          parentRenderElement: app.appRenderElement,
        );

        app.stop();
        await Future.delayed(Duration(milliseconds: 100));

        expect(stack.popFromStart(), equals('render'));
        expect(stack.popFromStart(), equals('after render'));
        expect(stack.canPop(), equals(false));
      },
    );

    test('should call didUpdate after dom updates', () async {
      var app = createTestApp()..start();
      var stack = RT_TestStack();

      await app.buildChildren(
        widgets: [
          RT_RenderAbleWidget(
            children: [Text('initial contents')],
            eventUpdate: () => stack.push('update'),
            eventDidUpdate: (e) {
              stack.push('after update');
              expect(app.appDomNode, RT_hasContents('updated contents'));
            },
          ),
        ],
        parentRenderElement: app.appRenderElement,
      );

      await app.updateChildren(
        widgets: [
          RT_RenderAbleWidget(
            children: [Text('updated contents')],
            eventUpdate: () => stack.push('update'),
            eventDidUpdate: (e) {
              stack.push('after update');
              expect(app.appDomNode, RT_hasContents('updated contents'));
            },
          ),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app.appRenderElement,
      );

      app.stop();
      await Future.delayed(Duration(milliseconds: 100));

      expect(stack.popFromStart(), equals('update'));
      expect(stack.popFromStart(), equals('after update'));
      expect(stack.canPop(), equals(false));
    });

    test('should call didUpdate in order for nested children', () async {
      var app = createTestApp()..start();
      var stack = RT_TestStack();

      await app.buildChildren(
        widgets: [
          RT_RenderAbleWidget(
            children: [
              RT_RenderAbleWidget(
                children: [Text('inner contents')],
                eventUpdate: () => stack.push('inner update'),
                eventDidUpdate: (_) => stack.push('inner after update'),
              )
            ],
            eventUpdate: () => stack.push('outer update'),
            eventDidUpdate: (_) => stack.push('outer after update'),
          ),
        ],
        parentRenderElement: app.appRenderElement,
      );

      await app.updateChildren(
        widgets: [
          RT_RenderAbleWidget(
            children: [
              RT_RenderAbleWidget(
                children: [Text('updated inner contents')],
                eventUpdate: () => stack.push('inner update'),
                eventDidUpdate: (_) => stack.push('inner after update'),
              )
            ],
            eventUpdate: () => stack.push('outer update'),
            eventDidUpdate: (_) => stack.push('outer after update'),
          ),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app.appRenderElement,
      );

      app.stop();
      await Future.delayed(Duration(milliseconds: 100));

      expect(stack.popFromStart(), equals('outer update'));
      expect(stack.popFromStart(), equals('inner update'));
      expect(stack.popFromStart(), equals('inner after update'));
      expect(stack.popFromStart(), equals('outer after update'));
      expect(stack.canPop(), equals(false));
    });

    test('should call didUnMount after actual un-mount', () async {
      var stack = RT_TestStack();

      var runner = runApp(
        app: RT_RenderAbleWidget(
          children: [Text('hello world')],
          eventDidUnMount: (e) {
            stack.push('after unmount');
            expect(RT_TestBed.rootDomNode, RT_hasContents(''));
          },
        ),
        appTargetId: RT_TestBed.rootTargetId,
      );

      await Future.delayed(Duration(milliseconds: 100));
      runner.stop();
      await Future.delayed(Duration(milliseconds: 100));

      expect(stack.popFromStart(), equals('after unmount'));
      expect(stack.canPop(), equals(false));
    });

    test('should call didUnMount in order for nested children', () async {
      var app = createTestApp()..start();
      var stack = RT_TestStack();

      await app.buildChildren(
        widgets: [
          RT_RenderAbleWidget(
            children: [
              RT_RenderAbleWidget(
                children: [Text('inner contents')],
                eventRender: () => stack.push('inner render'),
                eventDidUnMount: (_) => stack.push('inner after un-mount'),
              )
            ],
            eventRender: () => stack.push('outer render'),
            eventDidUnMount: (_) => stack.push('outer after un-mount'),
          ),
        ],
        parentRenderElement: app.appRenderElement,
      );

      app.stop();
      await Future.delayed(Duration(milliseconds: 100));

      expect(stack.popFromStart(), equals('outer render'));
      expect(stack.popFromStart(), equals('inner render'));
      expect(stack.popFromStart(), equals('inner after un-mount'));
      expect(stack.popFromStart(), equals('outer after un-mount'));
      expect(stack.canPop(), equals(false));
    });

    // more hardcoded ones ...

    test('should call didRender in order for nested children(both-ways)',
        () async {
      var app = createTestApp()..start();
      var stack = RT_TestStack();

      await app.buildChildren(
        widgets: [
          RT_RenderAbleWidget(
            children: [
              RT_RenderAbleWidget(
                children: [
                  RT_RenderAbleWidget(
                    children: [Text('a1')],
                    eventRender: () => stack.push('inner render a1'),
                    eventDidRender: (_) => stack.push('inner after render a1'),
                  ),
                  RT_RenderAbleWidget(
                    children: [Text('a2')],
                    eventRender: () => stack.push('inner render a2'),
                    eventDidRender: (_) => stack.push('inner after render a2'),
                  )
                ],
                eventRender: () => stack.push('outer render a'),
                eventDidRender: (_) => stack.push('outer after render a'),
              ),
              RT_RenderAbleWidget(
                children: [
                  RT_RenderAbleWidget(
                    children: [Text('b1')],
                    eventRender: () => stack.push('inner render b1'),
                    eventDidRender: (_) => stack.push('inner after render b1'),
                  ),
                  RT_RenderAbleWidget(
                    children: [Text('b2')],
                    eventRender: () => stack.push('inner render b2'),
                    eventDidRender: (_) => stack.push('inner after render b2'),
                  )
                ],
                eventRender: () => stack.push('outer render b'),
                eventDidRender: (_) => stack.push('outer after render b'),
              ),
            ],
            eventRender: () => stack.push('root render'),
            eventDidRender: (_) => stack.push('root after render'),
          )
        ],
        parentRenderElement: app.appRenderElement,
      );

      app.stop();
      await Future.delayed(Duration(milliseconds: 100));

      expect(stack.popFromStart(), equals('root render'));

      expect(stack.popFromStart(), equals('outer render a'));
      expect(stack.popFromStart(), equals('inner render a1'));
      expect(stack.popFromStart(), equals('inner render a2'));

      expect(stack.popFromStart(), equals('outer render b'));
      expect(stack.popFromStart(), equals('inner render b1'));
      expect(stack.popFromStart(), equals('inner render b2'));

      expect(stack.popFromStart(), equals('inner after render a1'));
      expect(stack.popFromStart(), equals('inner after render a2'));
      expect(stack.popFromStart(), equals('outer after render a'));

      expect(stack.popFromStart(), equals('inner after render b1'));
      expect(stack.popFromStart(), equals('inner after render b2'));
      expect(stack.popFromStart(), equals('outer after render b'));

      expect(stack.popFromStart(), equals('root after render'));
      expect(stack.canPop(), equals(false));
    });

    test('should call didUpdate in order for nested children(both-ways)',
        () async {
      var app = createTestApp()..start();
      var stack = RT_TestStack();

      await app.buildChildren(
        widgets: [
          RT_RenderAbleWidget(
            children: [
              RT_RenderAbleWidget(
                children: [
                  RT_RenderAbleWidget(
                    children: [Text('a1')],
                    eventUpdate: () => stack.push('inner update a1'),
                    eventDidUpdate: (_) => stack.push('inner after update a1'),
                  ),
                  RT_RenderAbleWidget(
                    children: [Text('a2')],
                    eventUpdate: () => stack.push('inner update a2'),
                    eventDidUpdate: (_) => stack.push('inner after update a2'),
                  )
                ],
                eventUpdate: () => stack.push('outer update a'),
                eventDidUpdate: (_) => stack.push('outer after update a'),
              ),
              RT_RenderAbleWidget(
                children: [
                  RT_RenderAbleWidget(
                    children: [Text('b1')],
                    eventUpdate: () => stack.push('inner update b1'),
                    eventDidUpdate: (_) => stack.push('inner after update b1'),
                  ),
                  RT_RenderAbleWidget(
                    children: [Text('b2')],
                    eventUpdate: () => stack.push('inner update b2'),
                    eventDidUpdate: (_) => stack.push('inner after update b2'),
                  )
                ],
                eventUpdate: () => stack.push('outer update b'),
                eventDidUpdate: (_) => stack.push('outer after update b'),
              ),
            ],
            eventUpdate: () => stack.push('root update'),
            eventDidUpdate: (_) => stack.push('root after update'),
          )
        ],
        parentRenderElement: app.appRenderElement,
      );

      await app.updateChildren(
        widgets: [
          RT_RenderAbleWidget(
            children: [
              RT_RenderAbleWidget(
                children: [
                  RT_RenderAbleWidget(
                    children: [Text('updated a1')],
                    eventUpdate: () => stack.push('inner update a1'),
                    eventDidUpdate: (_) => stack.push('inner after update a1'),
                  ),
                  RT_RenderAbleWidget(
                    children: [Text('updated a2')],
                    eventUpdate: () => stack.push('inner update a2'),
                    eventDidUpdate: (_) => stack.push('inner after update a2'),
                  )
                ],
                eventUpdate: () => stack.push('outer update a'),
                eventDidUpdate: (_) => stack.push('outer after update a'),
              ),
              RT_RenderAbleWidget(
                children: [
                  RT_RenderAbleWidget(
                    children: [Text('updated b1')],
                    eventUpdate: () => stack.push('inner update b1'),
                    eventDidUpdate: (_) => stack.push('inner after update b1'),
                  ),
                  RT_RenderAbleWidget(
                    children: [Text('updated b2')],
                    eventUpdate: () => stack.push('inner update b2'),
                    eventDidUpdate: (_) => stack.push('inner after update b2'),
                  )
                ],
                eventUpdate: () => stack.push('outer update b'),
                eventDidUpdate: (_) => stack.push('outer after update b'),
              ),
            ],
            eventUpdate: () => stack.push('root update'),
            eventDidUpdate: (_) => stack.push('root after update'),
          )
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app.appRenderElement,
      );

      app.stop();
      await Future.delayed(Duration(milliseconds: 100));

      expect(stack.popFromStart(), equals('root update'));

      expect(stack.popFromStart(), equals('outer update a'));
      expect(stack.popFromStart(), equals('inner update a1'));
      expect(stack.popFromStart(), equals('inner update a2'));

      expect(stack.popFromStart(), equals('outer update b'));
      expect(stack.popFromStart(), equals('inner update b1'));
      expect(stack.popFromStart(), equals('inner update b2'));

      expect(stack.popFromStart(), equals('inner after update a1'));
      expect(stack.popFromStart(), equals('inner after update a2'));
      expect(stack.popFromStart(), equals('outer after update a'));

      expect(stack.popFromStart(), equals('inner after update b1'));
      expect(stack.popFromStart(), equals('inner after update b2'));
      expect(stack.popFromStart(), equals('outer after update b'));

      expect(stack.popFromStart(), equals('root after update'));
      expect(stack.canPop(), equals(false));
    });

    test('should call didUnMount in order for nested children(both-ways)',
        () async {
      var app = createTestApp()..start();
      var stack = RT_TestStack();

      await app.buildChildren(
        widgets: [
          RT_RenderAbleWidget(
            children: [
              RT_RenderAbleWidget(
                children: [
                  RT_RenderAbleWidget(
                    children: [Text('a1')],
                    eventRender: () => stack.push('inner render a1'),
                    eventDidUnMount: (_) =>
                        stack.push('inner after un-mount a1'),
                  ),
                  RT_RenderAbleWidget(
                    children: [Text('a2')],
                    eventRender: () => stack.push('inner render a2'),
                    eventDidUnMount: (_) =>
                        stack.push('inner after un-mount a2'),
                  )
                ],
                eventRender: () => stack.push('outer render a'),
                eventDidUnMount: (_) => stack.push('outer after un-mount a'),
              ),
              RT_RenderAbleWidget(
                children: [
                  RT_RenderAbleWidget(
                    children: [Text('b1')],
                    eventRender: () => stack.push('inner render b1'),
                    eventDidUnMount: (_) =>
                        stack.push('inner after un-mount b1'),
                  ),
                  RT_RenderAbleWidget(
                    children: [Text('b2')],
                    eventRender: () => stack.push('inner render b2'),
                    eventDidUnMount: (_) =>
                        stack.push('inner after un-mount b2'),
                  )
                ],
                eventRender: () => stack.push('outer render b'),
                eventDidUnMount: (_) => stack.push('outer after un-mount b'),
              ),
            ],
            eventRender: () => stack.push('root render'),
            eventDidUnMount: (_) => stack.push('root after un-mount'),
          )
        ],
        parentRenderElement: app.appRenderElement,
      );

      app.stop();
      await Future.delayed(Duration(milliseconds: 100));

      expect(stack.popFromStart(), equals('root render'));

      expect(stack.popFromStart(), equals('outer render a'));
      expect(stack.popFromStart(), equals('inner render a1'));
      expect(stack.popFromStart(), equals('inner render a2'));

      expect(stack.popFromStart(), equals('outer render b'));
      expect(stack.popFromStart(), equals('inner render b1'));
      expect(stack.popFromStart(), equals('inner render b2'));

      expect(stack.popFromStart(), equals('inner after un-mount a1'));
      expect(stack.popFromStart(), equals('inner after un-mount a2'));
      expect(stack.popFromStart(), equals('outer after un-mount a'));

      expect(stack.popFromStart(), equals('inner after un-mount b1'));
      expect(stack.popFromStart(), equals('inner after un-mount b2'));
      expect(stack.popFromStart(), equals('outer after un-mount b'));

      expect(stack.popFromStart(), equals('root after un-mount'));
      expect(stack.canPop(), equals(false));
    });
  });
}
