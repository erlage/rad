// Copyright (c) 2022, the Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '../../../test_imports.dart';

void main() {
  /*
  |--------------------------------------------------------------------------
  | Tests for Browser actions(back-forward and state replacements)
  |--------------------------------------------------------------------------
  */

  group('Navigator, back action tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test(
      'should open previously visited route',
      () async {
        await app!.buildChildren(
          widgets: [
            Navigator(
              key: GlobalKey('navigator'),
              routes: [
                Route(name: 'route-1', page: Text('route-1')),
                Route(name: 'route-2', page: Text('route-2')),
                Route(name: 'route-3', page: Text('route-3')),
              ],
            )
          ],
          parentRenderElement: app!.appRenderElement,
        );

        var state = app!.navigatorState('navigator');

        state.open(name: 'route-3');
        await Future.delayed(Duration(milliseconds: 100));

        app!.window.dispatchBackAction();
        await Future.delayed(Duration(milliseconds: 100));
        expect(state.currentRouteName, 'route-1');
      },
    );

    test(
      'should open previously visited route(two steps)',
      () async {
        await app!.buildChildren(
          widgets: [
            Navigator(
              key: GlobalKey('navigator'),
              routes: [
                Route(name: 'route-1', page: Text('route-1')),
                Route(name: 'route-2', page: Text('route-2')),
                Route(name: 'route-3', page: Text('route-3')),
              ],
            )
          ],
          parentRenderElement: app!.appRenderElement,
        );

        var state = app!.navigatorState('navigator');

        state.open(name: 'route-2');
        await Future.delayed(Duration(milliseconds: 100));

        state.open(name: 'route-3');
        await Future.delayed(Duration(milliseconds: 100));

        app!.window.dispatchBackAction();
        await Future.delayed(Duration(milliseconds: 100));
        expect(state.currentRouteName, 'route-2');

        app!.window.dispatchBackAction();
        await Future.delayed(Duration(milliseconds: 100));
        expect(state.currentRouteName, 'route-1');
      },
    );
  });

  group('Navigator, forward action tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test(
      'should open previously opened route',
      () async {
        await app!.buildChildren(
          widgets: [
            Navigator(
              key: GlobalKey('navigator'),
              routes: [
                Route(name: 'route-1', page: Text('route-1')),
                Route(name: 'route-2', page: Text('route-2')),
                Route(name: 'route-3', page: Text('route-3')),
              ],
            )
          ],
          parentRenderElement: app!.appRenderElement,
        );

        var state = app!.navigatorState('navigator');

        state.open(name: 'route-3');
        await Future.delayed(Duration(milliseconds: 100));

        app!.window.dispatchBackAction();
        await Future.delayed(Duration(milliseconds: 100));

        app!.window.dispatchForwardAction();
        await Future.delayed(Duration(milliseconds: 100));
        expect(state.currentRouteName, 'route-3');
      },
    );

    test(
      'should open previously opened route(two steps)',
      () async {
        await app!.buildChildren(
          widgets: [
            Navigator(
              key: GlobalKey('navigator'),
              routes: [
                Route(name: 'route-1', page: Text('route-1')),
                Route(name: 'route-2', page: Text('route-2')),
                Route(name: 'route-3', page: Text('route-3')),
              ],
            )
          ],
          parentRenderElement: app!.appRenderElement,
        );

        var state = app!.navigatorState('navigator');

        state.open(name: 'route-2');
        await Future.delayed(Duration(milliseconds: 100));

        state.open(name: 'route-3');
        await Future.delayed(Duration(milliseconds: 100));

        app!.window.dispatchBackAction();
        await Future.delayed(Duration(milliseconds: 100));

        app!.window.dispatchBackAction();
        await Future.delayed(Duration(milliseconds: 100));

        app!.window.dispatchForwardAction();
        await Future.delayed(Duration(milliseconds: 100));
        expect(state.currentRouteName, 'route-2');

        app!.window.dispatchForwardAction();
        await Future.delayed(Duration(milliseconds: 100));
        expect(state.currentRouteName, 'route-3');
      },
    );
  });

  group('Navigator, forward/backward action mixed tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test(
      'should consume back/forward action only on nested navigator '
      'without leaving nested route',
      () async {
        await app!.buildChildren(
          widgets: [
            Navigator(
              key: GlobalKey('parent'),
              routes: [
                Route(name: 'p-route-1', page: Text('route-1')),
                Route(name: 'p-route-2', page: Text('route-2')),
                Route(
                  name: 'p-route-3',
                  page: Navigator(
                    key: GlobalKey('child'),
                    routes: [
                      Route(name: 'c-route-1', page: Text('route-1')),
                      Route(name: 'c-route-2', page: Text('route-2')),
                      Route(name: 'c-route-3', page: Text('route-2')),
                    ],
                  ),
                ),
              ],
            )
          ],
          parentRenderElement: app!.appRenderElement,
        );

        var parent = app!.navigatorState('parent');

        parent.open(name: 'p-route-3');
        await Future.delayed(Duration(milliseconds: 100));

        var child = app!.navigatorState('child');
        child.open(name: 'c-route-2');
        await Future.delayed(Duration(milliseconds: 100));
        child.open(name: 'c-route-1');
        await Future.delayed(Duration(milliseconds: 100));

        app!.window.dispatchBackAction(); // should go to c-route-2
        expect(child.currentRouteName, 'c-route-2');
        expect(parent.currentRouteName, 'p-route-3');

        app!.window.dispatchForwardAction(); // should go to c-route-1
        expect(child.currentRouteName, 'c-route-1');
        expect(parent.currentRouteName, 'p-route-3');
      },
    );

    test(
      'should consume back/forward action only on nested navigator '
      'when doing a revisit',
      () async {
        await app!.buildChildren(
          widgets: [
            Navigator(
              key: GlobalKey('parent'),
              routes: [
                Route(name: 'p-route-1', page: Text('route-1')),
                Route(name: 'p-route-2', page: Text('route-2')),
                Route(
                  name: 'p-route-3',
                  page: Navigator(
                    key: GlobalKey('child'),
                    routes: [
                      Route(name: 'c-route-1', page: Text('route-1')),
                      Route(name: 'c-route-2', page: Text('route-2')),
                    ],
                  ),
                ),
              ],
            )
          ],
          parentRenderElement: app!.appRenderElement,
        );

        var parent = app!.navigatorState('parent');

        parent.open(name: 'p-route-3');
        await Future.delayed(Duration(milliseconds: 100));

        var child = app!.navigatorState('child');
        child.open(name: 'c-route-2');
        await Future.delayed(Duration(milliseconds: 100));
        child.open(name: 'c-route-1');
        await Future.delayed(Duration(milliseconds: 100));

        parent.open(name: 'p-route-1');
        await Future.delayed(Duration(milliseconds: 100));

        parent.open(name: 'p-route-3');
        await Future.delayed(Duration(milliseconds: 100));

        child.open(name: 'c-route-2');
        await Future.delayed(Duration(milliseconds: 100));

        parent.open(name: 'p-route-1');
        await Future.delayed(Duration(milliseconds: 100));

        app!.window.dispatchBackAction(); // should go to p-route-3, c-route-2

        expect(child.currentRouteName, 'c-route-2');
        expect(parent.currentRouteName, 'p-route-3');

        app!.window.dispatchBackAction(); // should go to p-route-3, c-route-1
        expect(child.currentRouteName, 'c-route-1');
        expect(parent.currentRouteName, 'p-route-3');
      },
    );

    test(
      'should go back and forth according to dispatched action',
      () async {
        await app!.buildChildren(
          widgets: [
            Navigator(
              key: GlobalKey('navigator'),
              routes: [
                Route(name: 'route-1', page: Text('route-1')),
                Route(name: 'route-2', page: Text('route-2')),
                Route(name: 'route-3', page: Text('route-3')),
              ],
            )
          ],
          parentRenderElement: app!.appRenderElement,
        );

        var state = app!.navigatorState('navigator');

        // should be on route-1

        state.open(name: 'route-3');
        await Future.delayed(Duration(milliseconds: 100));

        // should be on route-3

        app!.window.dispatchBackAction();
        await Future.delayed(Duration(milliseconds: 100));

        // should be on route-1

        state.open(name: 'route-2');
        await Future.delayed(Duration(milliseconds: 100));

        // should be on route-2

        state.open(name: 'route-3');
        await Future.delayed(Duration(milliseconds: 100));

        // should be on route-3

        app!.window.dispatchBackAction();
        await Future.delayed(Duration(milliseconds: 100));

        // should be on route-2

        app!.window.dispatchForwardAction();
        await Future.delayed(Duration(milliseconds: 100));
        expect(state.currentRouteName, 'route-3');

        // should be on route-3

        app!.window.dispatchBackAction();
        await Future.delayed(Duration(milliseconds: 100));
        expect(state.currentRouteName, 'route-2');
      },
    );
  });

  group('Navigator, replacement tests', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test(
      'should push correct replacement '
      'when moving from non-nested to nested route',
      () async {
        await app!.buildChildren(
          widgets: [
            Navigator(
              key: GlobalKey('parent'),
              routes: [
                Route(name: 'p-route-1', page: Text('route-1')),
                Route(name: 'p-route-2', page: Text('route-2')),
                Route(
                  name: 'p-route-3',
                  page: Navigator(
                    key: GlobalKey('child'),
                    routes: [
                      Route(name: 'c-route-1', page: Text('route-1')),
                      Route(name: 'c-route-2', page: Text('route-2')),
                    ],
                  ),
                ),
              ],
            )
          ],
          parentRenderElement: app!.appRenderElement,
        );

        var parent = app!.navigatorState('parent');

        parent.open(name: 'p-route-3');
        await Future.delayed(Duration(milliseconds: 100));

        app!.assertMatchPathStack([
          '/p-route-1',
          // '/p-route-3', // child navigator should replace this entry
          '/p-route-3/c-route-1',
        ]);
      },
    );

    test(
      'should push correct replacement '
      'when moving from non-nested to nested route(two steps)',
      () async {
        await app!.buildChildren(
          widgets: [
            Navigator(
              key: GlobalKey('parent'),
              routes: [
                Route(name: 'p-route-1', page: Text('route-1')),
                Route(name: 'p-route-2', page: Text('route-2')),
                Route(
                  name: 'p-route-3',
                  page: Navigator(
                    key: GlobalKey('child'),
                    routes: [
                      Route(name: 'c-route-1', page: Text('route-1')),
                      Route(name: 'c-route-2', page: Text('route-2')),
                    ],
                  ),
                ),
              ],
            )
          ],
          parentRenderElement: app!.appRenderElement,
        );

        var parent = app!.navigatorState('parent');

        parent.open(name: 'p-route-3');
        await Future.delayed(Duration(milliseconds: 100));

        parent.open(name: 'p-route-1');
        await Future.delayed(Duration(milliseconds: 100));

        parent.open(name: 'p-route-3');
        await Future.delayed(Duration(milliseconds: 100));

        app!.assertMatchPathStack([
          '/p-route-1',
          // '/p-route-3', // child navigator should replace this entry
          '/p-route-3/c-route-1',
          '/p-route-1',
          // '/p-route-3',
          '/p-route-3/c-route-1',
        ]);
      },
    );

    test(
      'should push correct replacement '
      'when moving from non-nested to nested route(two steps, with open on child)',
      () async {
        await app!.buildChildren(
          widgets: [
            Navigator(
              key: GlobalKey('parent'),
              routes: [
                Route(name: 'p-route-1', page: Text('route-1')),
                Route(name: 'p-route-2', page: Text('route-2')),
                Route(
                  name: 'p-route-3',
                  page: Navigator(
                    key: GlobalKey('child'),
                    routes: [
                      Route(name: 'c-route-1', page: Text('route-1')),
                      Route(name: 'c-route-2', page: Text('route-2')),
                    ],
                  ),
                ),
              ],
            )
          ],
          parentRenderElement: app!.appRenderElement,
        );

        var parent = app!.navigatorState('parent');

        parent.open(name: 'p-route-3');
        await Future.delayed(Duration(milliseconds: 100));

        var child = app!.navigatorState('child');
        child.open(name: 'c-route-2');
        await Future.delayed(Duration(milliseconds: 100));

        parent.open(name: 'p-route-1');
        await Future.delayed(Duration(milliseconds: 100));

        parent.open(name: 'p-route-3');
        await Future.delayed(Duration(milliseconds: 100));

        app!.assertMatchPathStack([
          '/p-route-1',
          // '/p-route-3', // child navigator should replace this entry
          '/p-route-3/c-route-1',
          '/p-route-3/c-route-2',
          '/p-route-1',
          // '/p-route-3',
          '/p-route-3/c-route-2',
        ]);
      },
    );
  });
}
