// Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '../../../test_imports.dart';

void main() {
  /*
  |--------------------------------------------------------------------------
  | Tests for Browser actions(back-forward and state replacements)
  | when there are multiple navigators at same level of depth
  |--------------------------------------------------------------------------
  */

  RT_AppRunner? app;

  setUp(() {
    app = createTestApp()..start();
  });

  tearDown(() => app!.stop());

  NavigatorState state(String key) => app!.navigatorState(key);

  Future<void> build([String setPath = '/']) async {
    await app!.setPath(setPath);

    await app!.buildChildren(
      widgets: [
        Navigator(
          key: Key('parent'),
          routes: [
            Route(
              name: 'p-route-1',
              page: Navigator(
                key: Key('child-p1'),
                routes: [
                  Route(name: 'c-p1-route-1', page: Text('c-p1-route-1')),
                  Route(name: 'c-p1-route-2', page: Text('c-p1-route-2')),
                ],
              ),
            ),
            Route(
              name: 'p-route-2',
              page: Navigator(
                key: Key('child-p2'),
                routes: [
                  Route(name: 'c-p2-route-1', page: Text('c-p2-route-1')),
                  Route(name: 'c-p2-route-2', page: Text('c-p2-route-2')),
                ],
              ),
            ),
            Route(
              name: 'p-route-3',
              page: Navigator(
                key: Key('child-p3'),
                routes: [
                  Route(name: 'c-p3-route-1', page: Text('c-p3-route-1')),
                  Route(name: 'c-p3-route-2', page: Text('c-p3-route-2')),
                ],
              ),
            ),
          ],
        )
      ],
      parentRenderElement: app!.appRenderElement,
    );
  }

  group('Navigator, back action tests:', () {
    test('should open previously visited route', () async {
      await build();

      state('parent').open(name: 'p-route-2');
      await Future.delayed(Duration(milliseconds: 100));

      app!.window.dispatchBackAction();
      await Future.delayed(Duration(milliseconds: 100));
      expect(state('parent').currentRouteName, 'p-route-1');
    });

    test(
      'should open previously visited route(two steps)',
      () async {
        await build();

        state('parent').open(name: 'p-route-2');

        state('parent').open(name: 'p-route-2');
        await Future.delayed(Duration(milliseconds: 100));

        state('parent').open(name: 'p-route-3');
        await Future.delayed(Duration(milliseconds: 100));

        app!.window.dispatchBackAction();
        await Future.delayed(Duration(milliseconds: 100));
        expect(state('parent').currentRouteName, 'p-route-2');

        app!.window.dispatchBackAction();
        await Future.delayed(Duration(milliseconds: 100));
        expect(state('parent').currentRouteName, 'p-route-1');
      },
    );
  });

  group('Navigator, forward action tests:', () {
    test(
      'should open previously opened route',
      () async {
        await build();

        state('parent').open(name: 'p-route-3');
        await Future.delayed(Duration(milliseconds: 100));

        app!.window.dispatchBackAction();
        await Future.delayed(Duration(milliseconds: 100));

        app!.window.dispatchForwardAction();
        await Future.delayed(Duration(milliseconds: 100));
        expect(state('parent').currentRouteName, 'p-route-3');
      },
    );

    test(
      'should open previously opened route(two steps)',
      () async {
        await build();

        state('parent').open(name: 'p-route-2');
        await Future.delayed(Duration(milliseconds: 100));

        state('parent').open(name: 'p-route-3');
        await Future.delayed(Duration(milliseconds: 100));

        app!.window.dispatchBackAction();
        await Future.delayed(Duration(milliseconds: 100));

        app!.window.dispatchBackAction();
        await Future.delayed(Duration(milliseconds: 100));

        app!.window.dispatchForwardAction();
        await Future.delayed(Duration(milliseconds: 100));
        expect(state('parent').currentRouteName, 'p-route-2');

        app!.window.dispatchForwardAction();
        await Future.delayed(Duration(milliseconds: 100));
        expect(state('parent').currentRouteName, 'p-route-3');
      },
    );
  });

  group('Navigator, forward/backward action mixed tests:', () {
    test(
      'should consume back/forward action only on nested navigator '
      'without leaving nested route',
      () async {
        await build();

        state('parent').open(name: 'p-route-3');
        await Future.delayed(Duration(milliseconds: 100));

        var child = state('child-p3');

        child.open(name: 'c-p3-route-2');
        await Future.delayed(Duration(milliseconds: 100));
        child.open(name: 'c-p3-route-1');
        await Future.delayed(Duration(milliseconds: 100));

        app!.window.dispatchBackAction(); // should go to c-route-2
        expect(child.currentRouteName, 'c-p3-route-2');
        expect(state('parent').currentRouteName, 'p-route-3');

        app!.window.dispatchForwardAction(); // should go to c-route-1
        expect(child.currentRouteName, 'c-p3-route-1');
        expect(state('parent').currentRouteName, 'p-route-3');
      },
    );

    test(
      'should consume back/forward action only on nested navigator '
      'when doing a revisit',
      () async {
        await build();

        var parent = state('parent');

        parent.open(name: 'p-route-2');
        await Future.delayed(Duration(milliseconds: 100));

        var child = state('child-p2');
        child.open(name: 'c-p2-route-2');
        await Future.delayed(Duration(milliseconds: 100));
        child.open(name: 'c-p2-route-1');
        await Future.delayed(Duration(milliseconds: 100));

        parent.open(name: 'p-route-1');
        await Future.delayed(Duration(milliseconds: 100));

        parent.open(name: 'p-route-2');
        await Future.delayed(Duration(milliseconds: 100));

        child.open(name: 'c-p2-route-2');
        await Future.delayed(Duration(milliseconds: 100));

        parent.open(name: 'p-route-1');
        await Future.delayed(Duration(milliseconds: 100));

        app!.window.dispatchBackAction(); // should go to p-route-2, c-route-2

        expect(child.currentRouteName, 'c-p2-route-2');
        expect(parent.currentRouteName, 'p-route-2');

        app!.window.dispatchBackAction(); // should go to p-route-2, c-route-1
        expect(child.currentRouteName, 'c-p2-route-1');
        expect(parent.currentRouteName, 'p-route-2');
      },
    );

    test(
      'should go back and forth according to dispatched action',
      () async {
        await build();

        var parent = state('parent');

        // should be on p-route-1

        parent.open(name: 'p-route-3');
        await Future.delayed(Duration(milliseconds: 100));

        // should be on p-route-3

        app!.window.dispatchBackAction();
        await Future.delayed(Duration(milliseconds: 100));

        // should be on p-route-1

        parent.open(name: 'p-route-2');
        await Future.delayed(Duration(milliseconds: 100));

        // should be on p-route-2

        parent.open(name: 'p-route-3');
        await Future.delayed(Duration(milliseconds: 100));

        // should be on p-route-3

        app!.window.dispatchBackAction();
        await Future.delayed(Duration(milliseconds: 100));

        // should be on p-route-2

        app!.window.dispatchForwardAction();
        await Future.delayed(Duration(milliseconds: 100));
        expect(parent.currentRouteName, 'p-route-3');

        // should be on p-route-3

        app!.window.dispatchBackAction();
        await Future.delayed(Duration(milliseconds: 100));
        expect(parent.currentRouteName, 'p-route-2');
      },
    );
  });

  group('Navigator, replacement tests', () {
    test(
      'should push correct replacement '
      'when moving from non-nested to nested route',
      () async {
        await build();

        var parent = state('parent');

        parent.open(name: 'p-route-3');
        await Future.delayed(Duration(milliseconds: 100));

        app!.assertMatchPathStack([
          // '/p-route-1', // should replace this
          '/p-route-1/c-p1-route-1',
          // '/p-route-3', // should replace this
          '/p-route-3/c-p3-route-1',
        ]);
      },
    );

    test(
      'should push correct replacement '
      'when moving from non-nested to nested route(two steps)',
      () async {
        await build();

        var parent = state('parent');

        parent.open(name: 'p-route-3');
        await Future.delayed(Duration(milliseconds: 100));

        parent.open(name: 'p-route-1');
        await Future.delayed(Duration(milliseconds: 100));

        parent.open(name: 'p-route-3');
        await Future.delayed(Duration(milliseconds: 100));

        app!.assertMatchPathStack([
          // '/p-route-1', // should replace this
          '/p-route-1/c-p1-route-1',
          // '/p-route-3', // should replace this
          '/p-route-3/c-p3-route-1',
          '/p-route-1/c-p1-route-1',
          // '/p-route-3', // should replace this
          '/p-route-3/c-p3-route-1',
        ]);
      },
    );

    test(
      'should push correct replacement '
      'when moving from non-nested to nested route(two steps, with open on child)',
      () async {
        await build();

        var parent = app!.navigatorState('parent');

        parent.open(name: 'p-route-3');
        await Future.delayed(Duration(milliseconds: 100));

        var child = app!.navigatorState('child-p3');
        child.open(name: 'c-p3-route-2');
        await Future.delayed(Duration(milliseconds: 100));

        parent.open(name: 'p-route-1');
        await Future.delayed(Duration(milliseconds: 100));

        parent.open(name: 'p-route-3');
        await Future.delayed(Duration(milliseconds: 100));

        app!.assertMatchPathStack([
          // '/p-route-1', // should replace this
          '/p-route-1/c-p1-route-1',
          // '/p-route-3', // should replace this
          '/p-route-3/c-p3-route-1',
          '/p-route-3/c-p3-route-2',
          // '/p-route-1', // should replace this
          '/p-route-1/c-p1-route-1',
          // '/p-route-3',
          '/p-route-3/c-p3-route-2',
        ]);
      },
    );
  });
}
