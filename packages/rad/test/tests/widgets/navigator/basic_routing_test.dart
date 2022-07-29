// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '../../../test_imports.dart';

void main() {
  /*
  |--------------------------------------------------------------------------
  | Navigator routing tests | Default route tests
  |--------------------------------------------------------------------------
  */

  group('Navigator, routing to default tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('should consider first route as default', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: Key('navigator'),
            routes: [
              Route(name: 'route-1', page: Text('route-1')),
              Route(name: 'route-2', page: Text('route-2')),
            ],
          )
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var state = app!.navigatorState('navigator');

      expect(state.currentRouteName, 'route-1');
    });

    test('should consider first route as default(sync first)', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: Key('navigator'),
            routes: [
              Route(name: 'route-1', page: Text('route-1')),
              AsyncRoute(name: 'route-2', page: () => Text('route-2')),
            ],
          )
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var state = app!.navigatorState('navigator');

      expect(state.currentRouteName, 'route-1');
    });

    test('should consider first route as default(async first)', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: Key('navigator'),
            routes: [
              AsyncRoute(name: 'route-2', page: () => Text('route-2')),
              Route(name: 'route-1', page: Text('route-1')),
            ],
          )
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var state = app!.navigatorState('navigator');

      expect(state.currentRouteName, 'route-2');
    });
  });

  /*
  |--------------------------------------------------------------------------
  | Navigator routing tests | Matched routes
  |--------------------------------------------------------------------------
  */

  group('Navigator, routing to matched routes:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('should open matched route', () async {
      //
      await app!.setPath('/route-1/some/val');

      await app!.buildChildren(
        widgets: [
          Navigator(
            key: Key('navigator'),
            routes: [
              Route(name: 'route-1', page: Text('route-1')),
              Route(name: 'route-2', page: Text('route-2')),
            ],
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var state = app!.navigatorState('navigator');

      expect(state.currentRouteName, 'route-1');
      expect(RT_TestBed.rootDomNode, RT_hasContents('route-1'));
    });

    test('should open matched child route without trailers', () async {
      //
      await app!.setPath('/route-1');

      await app!.buildChildren(
        widgets: [
          Navigator(
            key: Key('navigator'),
            routes: [
              Route(name: 'route-1', page: Text('route-1')),
              Route(name: 'route-2', page: Text('route-2')),
            ],
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var state = app!.navigatorState('navigator');

      expect(state.currentRouteName, 'route-1');
      expect(RT_TestBed.rootDomNode, RT_hasContents('route-1'));
    });

    test('should open matched child route ignoring values in path', () async {
      //
      await app!.setPath('something/route-1/something/value');

      await app!.buildChildren(
        widgets: [
          Navigator(
            key: Key('navigator'),
            routes: [
              Route(name: 'route-1', page: Text('route-1')),
              Route(name: 'route-2', page: Text('route-2')),
            ],
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var state = app!.navigatorState('navigator');

      expect(state.currentRouteName, 'route-1');
      expect(RT_TestBed.rootDomNode, RT_hasContents('route-1'));
    });
  });
}
