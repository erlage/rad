// Copyright (c) 2022-2023, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: avoid_relative_lib_imports

import '../../test_imports.dart' hide RootRenderElement;

void main() {
  test(
    'should call init '
    ', exactly once '
    ', before render ',
    () async {
      var app = createTestApp()..start();
      var stack = RT_TestStack();

      await app.buildChildren(
        widgets: [
          RT_WatchfulWidget(
            eventInit: () => stack.push('init'),
            eventRender: () => stack.push('render'),
          ),
        ],
        parentRenderElement: app.appRenderElement,
      );

      app.stop();
      await Future.delayed(Duration(milliseconds: 100));

      expect(stack.popFromStart(), equals('init'));
      expect(stack.popFromStart(), equals('render'));
      expect(stack.canPop(), equals(false));
    },
  );

  test(
    'should call render '
    ', exactly once '
    ', after init '
    ', before update ',
    () async {
      var app = createTestApp()..start();
      var stack = RT_TestStack();

      await app.buildChildren(
        widgets: [
          RT_WatchfulWidget(
            eventInit: () => stack.push('init'),
            eventRender: () => stack.push('render'),
            eventUpdate: () => stack.push('update'),
          ),
        ],
        parentRenderElement: app.appRenderElement,
      );

      await app.updateChildren(
        widgets: [
          RT_WatchfulWidget(
            eventInit: () => stack.push('init'),
            eventRender: () => stack.push('render'),
            eventUpdate: () => stack.push('update'),
          ),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app.appRenderElement,
      );

      app.stop();
      await Future.delayed(Duration(milliseconds: 100));

      expect(stack.popFromStart(), equals('init'));
      expect(stack.popFromStart(), equals('render'));
      expect(stack.popFromStart(), equals('update'));
      expect(stack.canPop(), equals(false));
    },
  );

  test(
    'should call afterMount '
    ', exactly once '
    ', after render ',
    () async {
      var app = createTestApp()..start();
      var stack = RT_TestStack();

      await app.buildChildren(
        widgets: [
          RT_WatchfulWidget(
            children: [Text('hello world')],
            eventRender: () => stack.push('render'),
            eventAfterMount: () {
              stack.push('after mount');

              expect(app.appDomNode, RT_hasContents('hello world'));
            },
          ),
        ],
        parentRenderElement: app.appRenderElement,
      );

      app.stop();
      await Future.delayed(Duration(milliseconds: 100));

      expect(stack.popFromStart(), equals('render'));
      expect(stack.popFromStart(), equals('after mount'));
      expect(stack.canPop(), equals(false));
    },
  );

  test('should call afterUpdate after update & dom update', () async {
    var app = createTestApp()..start();
    var stack = RT_TestStack();

    await app.buildChildren(
      widgets: [
        RT_WatchfulWidget(
          children: [Text('initial contents')],
          eventUpdate: () => stack.push('update'),
          eventAfterUpdate: () {
            stack.push('after update');

            expect(app.appDomNode, RT_hasContents('initial contents'));
          },
        ),
      ],
      parentRenderElement: app.appRenderElement,
    );

    await app.updateChildren(
      widgets: [
        RT_WatchfulWidget(
          children: [Text('updated contents')],
          eventUpdate: () => stack.push('update'),
          eventAfterUpdate: () {
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

  test('should call update after render', () async {
    var app = createTestApp()..start();
    var stack = RT_TestStack();

    await app.buildChildren(
      widgets: [
        RT_WatchfulWidget(
          children: [Text('hello world')],
          eventRender: () => stack.push('render'),
          eventUpdate: () => stack.push('update'),
        ),
      ],
      parentRenderElement: app.appRenderElement,
    );

    await app.updateChildren(
      widgets: [
        RT_WatchfulWidget(
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

  test('should call dispose before actual unmount', () async {
    var stack = RT_TestStack();

    var runner = runApp(
      app: RT_WatchfulWidget(
        children: [Text('hello world')],
        eventDispose: () {
          stack.push('dispose');
          expect(RT_TestBed.rootDomNode, RT_hasContents('hello world'));
        },
      ),
      appTargetId: RT_TestBed.rootTargetId,
    );

    await Future.delayed(Duration(milliseconds: 100));
    runner.stop();
    await Future.delayed(Duration(milliseconds: 100));

    expect(stack.popFromStart(), equals('dispose'));
    expect(stack.canPop(), equals(false));
  });

  test('should call afterUnMount after actual unmount', () async {
    var stack = RT_TestStack();

    var runner = runApp(
      app: RT_WatchfulWidget(
        children: [Text('hello world')],
        eventAfterUnMount: () {
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
}
