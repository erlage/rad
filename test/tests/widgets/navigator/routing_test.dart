import '../../../test_imports.dart';

void main() {
  /*
  |--------------------------------------------------------------------------
  | Navigator routing tests | Matched routes
  |--------------------------------------------------------------------------
  */

  group('Navigator, routing to matched routes:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp(
        debugOptions: DebugOptions(routerLogs: true),
      )..start();
    });

    tearDown(() => app!.stop());

    test('should open matched route', () async {
      //
      await app!.setPath('/route-1/some/val');

      await app!.buildChildren(
        widgets: [
          Navigator(
            key: GlobalKey('navigator'),
            routes: [
              Route(name: 'route-1', page: Text('route-1')),
              Route(name: 'route-2', page: Text('route-2')),
            ],
          ),
        ],
        parentContext: app!.appContext,
      );

      var state = app!.navigatorState('navigator');

      expect(state.currentRouteName, 'route-1');
      expect(RT_TestBed.rootElement, RT_hasContents('route-1'));
    });

    test('should open matched child route without trailers', () async {
      //
      await app!.setPath('/route-1');

      await app!.buildChildren(
        widgets: [
          Navigator(
            key: GlobalKey('navigator'),
            routes: [
              Route(name: 'route-1', page: Text('route-1')),
              Route(name: 'route-2', page: Text('route-2')),
            ],
          ),
        ],
        parentContext: app!.appContext,
      );

      var state = app!.navigatorState('navigator');

      expect(state.currentRouteName, 'route-1');
      expect(RT_TestBed.rootElement, RT_hasContents('route-1'));
    });

    test('should open matched child route with intre.values', () async {
      //
      await app!.setPath('something/route-1/something/value');

      await app!.buildChildren(
        widgets: [
          Navigator(
            key: GlobalKey('navigator'),
            routes: [
              Route(name: 'route-1', page: Text('route-1')),
              Route(name: 'route-2', page: Text('route-2')),
            ],
          ),
        ],
        parentContext: app!.appContext,
      );

      var state = app!.navigatorState('navigator');

      expect(state.currentRouteName, 'route-1');
      expect(RT_TestBed.rootElement, RT_hasContents('route-1'));
    });
  });
}
