// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '../../test_imports.dart';

void main() {
  RT_AppRunner? app;

  setUp(() {
    app = createTestApp()..start();
  });

  tearDown(() => app!.stop());

  group('Hook interface tests', () {
    test('should fetch existing hooks on update', () async {
      Hook? instance1;
      Hook? instance2;
      Hook? instance3;

      Hook? instance1Again;
      Hook? instance2Again;
      Hook? instance3Again;

      await build(app!, [
        () {
          instance1 = useTestHook();
          instance2 = useTestHook();
          instance3 = useTestHook();
        },
      ]);

      await update(app!, [
        () {
          instance1Again = useTestHook();
          instance2Again = useTestHook();
          instance3Again = useTestHook();
        },
      ]);

      expect(instance1, equals(instance1Again));
      expect(instance2, equals(instance2Again));
      expect(instance3, equals(instance3Again));

      await update(app!, [
        () {
          instance1Again = useTestHook();
          instance2Again = useTestHook();
          instance3Again = useTestHook();
        },
      ]);

      expect(instance1, equals(instance1Again));
      expect(instance2, equals(instance2Again));
      expect(instance3, equals(instance3Again));
    });

    test('should call in order', () async {
      var stack = RT_TestStack();

      // this test exercises the whole system
      // if it fails, check the other ones

      await build(app!, [
        () => useTestHook(eventWillBuildScope: () => stack.push('WBuild')),
        () => useTestHook(eventDidBuildScope: () => stack.push('DBuild')),
        () => useTestHook(eventDidRenderScope: () => stack.push('DRender')),
        () => useTestHook(eventWillRebuildScope: () => stack.push('WRebuild')),
        () => useTestHook(eventDidRebuildScope: () => stack.push('DRebuild')),
        () => useTestHook(eventDidUpdateScope: () => stack.push('DUpdate')),
        () => useTestHook(eventWillUnMountScope: () => stack.push('WUnMount')),
        () => useTestHook(eventDidUnMountScope: () => stack.push('DUnMount')),
      ]);

      await update(app!, [
        () => useTestHook(eventWillBuildScope: () => stack.push('WBuild')),
        () => useTestHook(eventDidBuildScope: () => stack.push('DBuild')),
        () => useTestHook(eventDidRenderScope: () => stack.push('DRender')),
        () => useTestHook(eventWillRebuildScope: () => stack.push('WRebuild')),
        () => useTestHook(eventDidRebuildScope: () => stack.push('DRebuild')),
        () => useTestHook(eventDidUpdateScope: () => stack.push('DUpdate')),
        () => useTestHook(eventWillUnMountScope: () => stack.push('WUnMount')),
        () => useTestHook(eventDidUnMountScope: () => stack.push('DUnMount')),
      ]);

      await update(app!, [
        () => useTestHook(eventWillBuildScope: () => stack.push('WBuild')),
        () => useTestHook(eventDidBuildScope: () => stack.push('DBuild')),
        () => useTestHook(eventDidRenderScope: () => stack.push('DRender')),
        () => useTestHook(eventWillRebuildScope: () => stack.push('WRebuild')),
        () => useTestHook(eventDidRebuildScope: () => stack.push('DRebuild')),
        () => useTestHook(eventDidUpdateScope: () => stack.push('DUpdate')),
        () => useTestHook(eventWillUnMountScope: () => stack.push('WUnMount')),
        () => useTestHook(eventDidUnMountScope: () => stack.push('DUnMount')),
      ]);

      await dispose(app!);

      stack.assertMatch([
        'WBuild',
        'DBuild',
        'DRender',

        // wont get called during initial builds

        // 'WRebuild',
        // 'DRebuild',
        // 'DUpdate',
        // 'WUnMount',
        // 'DUnMount',

        // wont get called during updates

        // 'WBuild',
        // 'DBuild',
        // 'DRender',
        'WRebuild',
        'DRebuild',
        'DUpdate',

        // second update

        'WRebuild',
        'DRebuild',
        'DUpdate',

        // dispose

        'WUnMount',
        'DUnMount',
      ]);
    });

    // below tests are redundant but makes it easy to pinpoint what's failing

    test('should call WillBuild once', () async {
      var stack = RT_TestStack();

      await build(app!, [
        () => useTestHook(eventWillBuildScope: () => stack.push('WillBuild')),
      ]);

      await update(app!, [
        () => useTestHook(eventWillBuildScope: () => stack.push('WillBuild')),
      ]);

      stack.assertMatch(['WillBuild']);

      await build(app!, [
        () => useTestHook(eventWillBuildScope: () => stack.push('WillBuild 1')),
        () => useTestHook(eventWillBuildScope: () => stack.push('WillBuild 2')),
        () => useTestHook(eventWillBuildScope: () => stack.push('WillBuild 3')),
      ]);

      await update(app!, [
        () => useTestHook(eventWillBuildScope: () => stack.push('WillBuild 1')),
        () => useTestHook(eventWillBuildScope: () => stack.push('WillBuild 2')),
        () => useTestHook(eventWillBuildScope: () => stack.push('WillBuild 3')),
      ]);

      stack.assertMatch(['WillBuild 1', 'WillBuild 2', 'WillBuild 3']);
    });

    test('should call DidBuild once', () async {
      var stack = RT_TestStack();

      await build(app!, [
        () => useTestHook(eventDidBuildScope: () => stack.push('DidBuild')),
      ]);

      await update(app!, [
        () => useTestHook(eventDidBuildScope: () => stack.push('DidBuild')),
      ]);

      stack.assertMatch(['DidBuild']);

      await build(app!, [
        () => useTestHook(eventDidBuildScope: () => stack.push('DidBuild 1')),
        () => useTestHook(eventDidBuildScope: () => stack.push('DidBuild 2')),
        () => useTestHook(eventDidBuildScope: () => stack.push('DidBuild 3')),
      ]);

      await update(app!, [
        () => useTestHook(eventDidBuildScope: () => stack.push('DidBuild 1')),
        () => useTestHook(eventDidBuildScope: () => stack.push('DidBuild 2')),
        () => useTestHook(eventDidBuildScope: () => stack.push('DidBuild 3')),
      ]);

      stack.assertMatch(['DidBuild 1', 'DidBuild 2', 'DidBuild 3']);
    });

    test('should call DidRender once', () async {
      var stack = RT_TestStack();

      await build(app!, [
        () => useTestHook(eventDidRenderScope: () => stack.push('DidRender')),
      ]);

      await update(app!, [
        () => useTestHook(eventDidRenderScope: () => stack.push('DidRender')),
      ]);

      stack.assertMatch(['DidRender']);

      await build(app!, [
        () => useTestHook(eventDidRenderScope: () => stack.push('DidRender 1')),
        () => useTestHook(eventDidRenderScope: () => stack.push('DidRender 2')),
        () => useTestHook(eventDidRenderScope: () => stack.push('DidRender 3')),
      ]);

      await update(app!, [
        () => useTestHook(eventDidRenderScope: () => stack.push('DidRender 1')),
        () => useTestHook(eventDidRenderScope: () => stack.push('DidRender 2')),
        () => useTestHook(eventDidRenderScope: () => stack.push('DidRender 3')),
      ]);

      stack.assertMatch(['DidRender 1', 'DidRender 2', 'DidRender 3']);
    });

    test('should call WillRebuild on each update', () async {
      var stack = RT_TestStack();

      await build(app!, [
        () => useTestHook(eventWillRebuildScope: () => stack.push('WR')),
      ]);

      await update(app!, [
        () => useTestHook(eventWillRebuildScope: () => stack.push('WR')),
      ]);

      await update(app!, [
        () => useTestHook(eventWillRebuildScope: () => stack.push('WR')),
      ]);

      stack.assertMatch(['WR', 'WR']);

      await build(app!, [
        () => useTestHook(eventWillRebuildScope: () => stack.push('WR 1')),
        () => useTestHook(eventWillRebuildScope: () => stack.push('WR 2')),
        () => useTestHook(eventWillRebuildScope: () => stack.push('WR 3')),
      ]);

      await update(app!, [
        () => useTestHook(eventWillRebuildScope: () => stack.push('WR 1')),
        () => useTestHook(eventWillRebuildScope: () => stack.push('WR 2')),
        () => useTestHook(eventWillRebuildScope: () => stack.push('WR 3')),
      ]);

      await update(app!, [
        () => useTestHook(eventWillRebuildScope: () => stack.push('WR 1')),
        () => useTestHook(eventWillRebuildScope: () => stack.push('WR 2')),
        () => useTestHook(eventWillRebuildScope: () => stack.push('WR 3')),
      ]);

      stack.assertMatch(['WR 1', 'WR 2', 'WR 3', 'WR 1', 'WR 2', 'WR 3']);
    });

    test('should call DidRebuild on each update', () async {
      var stack = RT_TestStack();

      await build(app!, [
        () => useTestHook(eventDidRebuildScope: () => stack.push('DR')),
      ]);

      await update(app!, [
        () => useTestHook(eventDidRebuildScope: () => stack.push('DR')),
      ]);

      await update(app!, [
        () => useTestHook(eventDidRebuildScope: () => stack.push('DR')),
      ]);

      stack.assertMatch(['DR', 'DR']);

      await build(app!, [
        () => useTestHook(eventDidRebuildScope: () => stack.push('DR 1')),
        () => useTestHook(eventDidRebuildScope: () => stack.push('DR 2')),
        () => useTestHook(eventDidRebuildScope: () => stack.push('DR 3')),
      ]);

      await update(app!, [
        () => useTestHook(eventDidRebuildScope: () => stack.push('DR 1')),
        () => useTestHook(eventDidRebuildScope: () => stack.push('DR 2')),
        () => useTestHook(eventDidRebuildScope: () => stack.push('DR 3')),
      ]);

      await update(app!, [
        () => useTestHook(eventDidRebuildScope: () => stack.push('DR 1')),
        () => useTestHook(eventDidRebuildScope: () => stack.push('DR 2')),
        () => useTestHook(eventDidRebuildScope: () => stack.push('DR 3')),
      ]);

      stack.assertMatch(['DR 1', 'DR 2', 'DR 3', 'DR 1', 'DR 2', 'DR 3']);
    });

    test('should call DidUpdate on each update', () async {
      var stack = RT_TestStack();

      await build(app!, [
        () => useTestHook(eventDidUpdateScope: () => stack.push('DU')),
      ]);

      await update(app!, [
        () => useTestHook(eventDidUpdateScope: () => stack.push('DU')),
      ]);

      await update(app!, [
        () => useTestHook(eventDidUpdateScope: () => stack.push('DU')),
      ]);

      stack.assertMatch(['DU', 'DU']);

      await build(app!, [
        () => useTestHook(eventDidUpdateScope: () => stack.push('DU 1')),
        () => useTestHook(eventDidUpdateScope: () => stack.push('DU 2')),
        () => useTestHook(eventDidUpdateScope: () => stack.push('DU 3')),
      ]);

      await update(app!, [
        () => useTestHook(eventDidUpdateScope: () => stack.push('DU 1')),
        () => useTestHook(eventDidUpdateScope: () => stack.push('DU 2')),
        () => useTestHook(eventDidUpdateScope: () => stack.push('DU 3')),
      ]);

      await update(app!, [
        () => useTestHook(eventDidUpdateScope: () => stack.push('DU 1')),
        () => useTestHook(eventDidUpdateScope: () => stack.push('DU 2')),
        () => useTestHook(eventDidUpdateScope: () => stack.push('DU 3')),
      ]);

      stack.assertMatch(['DU 1', 'DU 2', 'DU 3', 'DU 1', 'DU 2', 'DU 3']);
    });

    test('should call WillUnMount once', () async {
      var stack = RT_TestStack();

      await build(app!, [
        () => useTestHook(eventWillUnMountScope: () => stack.push('WU')),
      ]);

      await update(app!, [
        () => useTestHook(eventWillUnMountScope: () => stack.push('WU')),
      ]);

      await dispose(app!);

      stack.assertMatch(['WU']);

      await build(app!, [
        () => useTestHook(eventWillUnMountScope: () => stack.push('WU 1')),
        () => useTestHook(eventWillUnMountScope: () => stack.push('WU 2')),
        () => useTestHook(eventWillUnMountScope: () => stack.push('WU 3')),
      ]);

      await update(app!, [
        () => useTestHook(eventWillUnMountScope: () => stack.push('WU 1')),
        () => useTestHook(eventWillUnMountScope: () => stack.push('WU 2')),
        () => useTestHook(eventWillUnMountScope: () => stack.push('WU 3')),
      ]);

      await dispose(app!);

      stack.assertMatch(['WU 1', 'WU 2', 'WU 3']);
    });

    test('should call DidUnMount once', () async {
      var stack = RT_TestStack();

      await build(app!, [
        () => useTestHook(eventDidUnMountScope: () => stack.push('DU')),
      ]);

      await update(app!, [
        () => useTestHook(eventDidUnMountScope: () => stack.push('DU')),
      ]);

      await dispose(app!);

      stack.assertMatch(['DU']);

      await build(app!, [
        () => useTestHook(eventDidUnMountScope: () => stack.push('DU 1')),
        () => useTestHook(eventDidUnMountScope: () => stack.push('DU 2')),
        () => useTestHook(eventDidUnMountScope: () => stack.push('DU 3')),
      ]);

      await update(app!, [
        () => useTestHook(eventDidUnMountScope: () => stack.push('DU 1')),
        () => useTestHook(eventDidUnMountScope: () => stack.push('DU 2')),
        () => useTestHook(eventDidUnMountScope: () => stack.push('DU 3')),
      ]);

      await dispose(app!);

      stack.assertMatch(['DU 1', 'DU 2', 'DU 3']);
    });
  });

  group('Hook misc tests', () {
    test('should batch & process rebuild requests', () async {
      var stack = RT_TestStack();

      var isInitialRender = true;

      await build(app!, [
        () {
          var hook1 = useTestHook(
            eventDidBuildScope: () => stack.push('build 1'),
            eventDidRebuildScope: () => stack.push('rebuild 1'),
            eventDidRenderScope: () => stack.push('render 1'),
          );

          var hook2 = useTestHook(
            eventDidBuildScope: () => stack.push('build 2'),
            eventDidRebuildScope: () => stack.push('rebuild 2'),
            eventDidRenderScope: () => stack.push('render 2'),
          );

          if (isInitialRender) {
            isInitialRender = false; // so that we don't go on forever

            hook1.dispatchRebuildRequest();
            hook1.dispatchRebuildRequest();
            hook1.dispatchRebuildRequest();
            hook2.dispatchRebuildRequest();
            hook2.dispatchRebuildRequest();
            hook2.dispatchRebuildRequest();
          }
        },
      ]);

      await Future.delayed(Duration(milliseconds: 100));

      stack.assertMatch([
        'build 1',
        'build 2',
        'render 1',
        'render 2',
        'rebuild 1',
        'rebuild 2',
      ]);
    });
  });
}

Future<void> build(RT_AppRunner app, List<VoidCallback> callbacks) async {
  await app.buildChildren(
    widgets: [
      HookScope(() {
        for (final callback in callbacks) {
          callback();
        }

        return Text('hello world');
      }),
    ],
    parentRenderElement: app.appRenderElement,
  );
}

Future<void> update(RT_AppRunner app, List<VoidCallback> callbacks) async {
  await app.updateChildren(
    widgets: [
      HookScope(() {
        for (final callback in callbacks) {
          callback();
        }

        return Text('hello world');
      }),
    ],
    updateType: UpdateType.setState,
    parentRenderElement: app.appRenderElement,
  );
}

Future<void> dispose(RT_AppRunner app) async {
  await app.updateChildren(
    widgets: [
      Text('hello world'),
    ],
    updateType: UpdateType.setState,
    parentRenderElement: app.appRenderElement,
  );
}
