// Copyright (c) 2022, Rad developers. All rights reserved.
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

      var afterRender = (e) => {};
      var afterUpdate = (e) => {};
      var beforeUnMount = (e) => {};
      var afterUnMount = (e) => {};

      await pap.buildChildren(
        widgets: [
          RT_RenderAbleWidget(
            key: Key('widget'),
            eventAfterRenderEffect: afterRender,
            eventAfterUpdateEffect: afterUpdate,
            eventBeforeUnMountEffect: beforeUnMount,
            eventAfterUnMountEffect: afterUnMount,
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );
      var renderElement = pap.renderElementByKeyValue('widget')!;
      var eventListeners = renderElement.frameworkRenderEventListeners;

      expect(
        eventListeners[RenderEventType.afterRenderEffect],
        equals(afterRender),
      );
      expect(
        eventListeners[RenderEventType.afterUpdateEffect],
        equals(afterUpdate),
      );
      expect(
        eventListeners[RenderEventType.afterUnMountEffect],
        equals(afterUnMount),
      );
      expect(
        eventListeners[RenderEventType.beforeUnMountEffect],
        equals(beforeUnMount),
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
      ', before afterRender ',
      () async {
        var app = createTestApp()..start();
        var stack = RT_TestStack();

        await app.buildChildren(
          widgets: [
            RT_RenderAbleWidget(
              eventRegister: () => stack.push('register'),
              eventRender: () => stack.push('render'),
              eventAfterRenderEffect: (e) => stack.push('after render'),
            ),
          ],
          parentRenderElement: app.appRenderElement,
        );

        await app.updateChildren(
          widgets: [
            RT_RenderAbleWidget(
              eventRegister: () => stack.push('register'),
              eventRender: () => stack.push('render'),
              eventAfterRenderEffect: (e) => stack.push('after render'),
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

    test('should call beforeUnMount before actual un-mount', () async {
      var stack = RT_TestStack();

      var runner = runApp(
        app: RT_RenderAbleWidget(
          children: [Text('hello world')],
          eventBeforeUnMountEffect: (e) {
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
      'should call afterRender '
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
              eventAfterRenderEffect: (e) {
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

    test('should call afterUpdate after dom updates', () async {
      var app = createTestApp()..start();
      var stack = RT_TestStack();

      await app.buildChildren(
        widgets: [
          RT_RenderAbleWidget(
            children: [Text('initial contents')],
            eventUpdate: () => stack.push('update'),
            eventAfterUpdateEffect: (e) {
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
            eventAfterUpdateEffect: (e) {
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

    test('should call afterUnMount after actual un-mount', () async {
      var stack = RT_TestStack();

      var runner = runApp(
        app: RT_RenderAbleWidget(
          children: [Text('hello world')],
          eventAfterUnMountEffect: (e) {
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
