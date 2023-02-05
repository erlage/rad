// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
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
  });
}
