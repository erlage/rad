import '../../../test_imports.dart';

void main() {
  /*
  |--------------------------------------------------------------------------
  | API | Default route tests
  |--------------------------------------------------------------------------
  */

  group('Navigator, default route tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp(
        debugOptions: DebugOptions(routerLogs: true),
      )..start();
    });

    tearDown(() => app!.stop());

    test('should consider first route as default', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: GlobalKey('navigator'),
            routes: [
              Route(name: 'route-1', page: Text('route-1')),
              Route(name: 'route-2', page: Text('route-2')),
            ],
          )
        ],
        parentContext: app!.appContext,
      );

      var state = app!.navigatorState('navigator');

      expect(state.currentRouteName, 'route-1');
    });

    test('should consider first route as default(sync first)', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: GlobalKey('navigator'),
            routes: [
              Route(name: 'route-1', page: Text('route-1')),
              AsyncRoute(name: 'route-2', page: () => Text('route-2')),
            ],
          )
        ],
        parentContext: app!.appContext,
      );

      var state = app!.navigatorState('navigator');

      expect(state.currentRouteName, 'route-1');
    });

    test('should consider first route as default(async first)', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: GlobalKey('navigator'),
            routes: [
              AsyncRoute(name: 'route-2', page: () => Text('route-2')),
              Route(name: 'route-1', page: Text('route-1')),
            ],
          )
        ],
        parentContext: app!.appContext,
      );

      var state = app!.navigatorState('navigator');

      expect(state.currentRouteName, 'route-2');
    });
  });

  /*
  |--------------------------------------------------------------------------
  | API | Opening route tests
  |--------------------------------------------------------------------------
  */

  group('Navigator, opening route tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp(
        debugOptions: DebugOptions(routerLogs: true),
      )..start();
    });

    tearDown(() => app!.stop());

    test("should throw if route doesn't exists", () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: GlobalKey('navigator'),
            routes: [
              Route(name: 'some-route', page: Text('some route')),
            ],
          ),
        ],
        parentContext: app!.appContext,
      );

      var state = app!.navigatorState('navigator');

      expect(
        () => state.open(name: 'other-route'),
        throwsA(
          predicate(
            (e) => '$e'.startsWith(
              "Exception: Navigator: Route 'other-route' is not declared",
            ),
          ),
        ),
      );
    });

    test('should ignore duplicate open requests', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: GlobalKey('navigator'),
            routes: [
              Route(name: 'route-1', page: Text('route-1')),
              Route(name: 'route-2', page: Text('route-2')),
            ],
          )
        ],
        parentContext: app!.appContext,
      );

      var state = app!.navigatorState('navigator');

      state.open(name: 'route-1'); // should ignore
      state.open(name: 'route-1'); // should ignore
      state.open(name: 'route-1'); // should ignore
      await Future.delayed(Duration(milliseconds: 100));
      expect(state.canGoBack(), equals(false));
    });

    test('should ignore open request if possible', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: GlobalKey('navigator'),
            routes: [
              Route(name: 'route-1', page: Text('route-1')),
              Route(name: 'route-2', page: Text('route-2')),
            ],
          )
        ],
        parentContext: app!.appContext,
      );

      var state = app!.navigatorState('navigator');

      state.open(name: 'route-1'); // should ignore
      await Future.delayed(Duration(milliseconds: 100));
      expect(state.canGoBack(), equals(false));

      state.open(name: 'route-1', values: {'a': 'b'}); // should process
      await Future.delayed(Duration(milliseconds: 100));
      expect(state.canGoBack(), equals(true));

      state.open(name: 'route-1', values: {'a': 'b'}); // should ignore
      await Future.delayed(Duration(milliseconds: 100));

      state.back();
      await Future.delayed(Duration(milliseconds: 100));
      expect(state.canGoBack(), equals(false));
    });

    test('should open a route only when requested', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: GlobalKey('navigator'),
            routes: [
              Route(name: 'route-1', page: Text('route-1')),
              Route(name: 'route-2', page: Text('route-2')),
            ],
          )
        ],
        parentContext: app!.appContext,
      );

      await Future.delayed(Duration(milliseconds: 100));
      expect(RT_TestBed.rootElement, RT_hasContents('route-1'));

      var state = app!.navigatorState('navigator');

      state.open(name: 'route-2');
      await Future.delayed(Duration(milliseconds: 100));

      expect(RT_TestBed.rootElement, RT_hasContents('route-1|route-2'));
    });

    test('should open a route and update navigator current name', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: GlobalKey('navigator'),
            routes: [
              Route(name: 'route-1', page: Text('route-1')),
              Route(name: 'route-2', page: Text('route-2')),
            ],
          )
        ],
        parentContext: app!.appContext,
      );
      await Future.delayed(Duration(milliseconds: 100));

      var state = app!.navigatorState('navigator');

      expect(state.currentRouteName, equals('route-1')); // default

      state.open(name: 'route-2');
      await Future.delayed(Duration(milliseconds: 100));

      expect(state.currentRouteName, equals('route-2'));
    });

    test('should build page only when its opened for the first time', () async {
      var testStack = RT_TestStack();

      await app!.buildChildren(
        widgets: [
          Navigator(
            key: GlobalKey('navigator'),
            routes: [
              Route(
                name: 'route-1',
                page: RT_TestWidget(
                  roEventHookRender: () => testStack.push('render-1'),
                  roEventHookUpdate: () => testStack.push('update-1'),
                  children: [Text('route-1')],
                ),
              ),
              AsyncRoute(
                name: 'route-2',
                page: () async {
                  testStack.push('render-2');
                  return Text('page contents');
                },
              ),
              Route(
                name: 'route-3',
                page: RT_TestWidget(
                  roEventHookRender: () => testStack.push('render-3'),
                  roEventHookUpdate: () => testStack.push('update-3'),
                  children: [Text('route-1')],
                ),
              ),
              AsyncRoute(
                name: 'route-4',
                page: () async {
                  testStack.push('render-4');
                  return Text('page contents');
                },
              ),
            ],
          ),
        ],
        parentContext: app!.appContext,
      );

      var state = app!.navigatorState('navigator');

      state.open(name: 'route-3');
      await Future.delayed(Duration(milliseconds: 100));

      state.open(name: 'route-1');
      await Future.delayed(Duration(milliseconds: 100));

      state.open(name: 'route-3');
      await Future.delayed(Duration(milliseconds: 100));

      state.open(name: 'route-2');
      await Future.delayed(Duration(milliseconds: 100));

      state.open(name: 'route-1');
      await Future.delayed(Duration(milliseconds: 100));

      expect(testStack.popFromStart(), equals('render-1'));
      expect(testStack.popFromStart(), equals('render-3'));
      expect(testStack.popFromStart(), equals('render-2'));

      expect(testStack.canPop(), equals(false));
    });

    test('should add route to history', () async {
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

      state.open(name: 'route-2');
      await Future.delayed(Duration(milliseconds: 100));
      app!.assertMatchPath('/route-2');

      state.open(name: 'route-1');
      await Future.delayed(Duration(milliseconds: 100));
      app!.assertMatchPath('/route-1');

      state.open(name: 'route-2');
      await Future.delayed(Duration(milliseconds: 100));
      app!.assertMatchPath('/route-2');
    });

    test('should add values to history', () async {
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

      state.open(name: 'route-2', values: {'s': 'a'});
      await Future.delayed(Duration(milliseconds: 100));
      app!.assertMatchPath('/route-2/s/a');

      state.open(name: 'route-1', values: {'': 'a'});
      await Future.delayed(Duration(milliseconds: 100));
      app!.assertMatchPath('/route-1/a');

      state.open(name: 'route-2', values: {'a + b': 'c + d'});
      await Future.delayed(Duration(milliseconds: 100));
      app!.assertMatchPath('/route-2/a%20%2B%20b/c%20%2B%20d');
    });
  });

  /*
  |--------------------------------------------------------------------------
  | API | Can go back tests
  |--------------------------------------------------------------------------
  */

  group('Navigator, can go back to previous route tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp(
        debugOptions: DebugOptions(routerLogs: true),
      )..start();
    });

    tearDown(() => app!.stop());

    test(
      'should return false if history is empty(no previous route)',
      () async {
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

        var wo = app!.widgetObjectByGlobalKey('navigator');
        var state = (wo.renderObject as NavigatorRenderObject).state;

        expect(state.canGoBack(), equals(false));
      },
    );

    test('should return true if history is non-empty', () async {
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

      state.open(name: 'route-2');
      await Future.delayed(Duration(milliseconds: 100));

      expect(state.canGoBack(), equals(true));
    });
  });

  /*
  |--------------------------------------------------------------------------
  | API | Going back tests
  |--------------------------------------------------------------------------
  */

  group('Navigator, going to previous route tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp(
        debugOptions: DebugOptions(routerLogs: true),
      )..start();
    });

    tearDown(() => app!.stop());

    test('should throw if history is empty(no previous route)', () async {
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

      await Future.delayed(Duration(milliseconds: 100));

      var state = app!.navigatorState('navigator');

      expect(
        () => state.back(),
        throwsA(
          predicate(
            (e) => '$e'.startsWith(
              'Exception: Navigator: No previous route to go back',
            ),
          ),
        ),
      );
    });

    test('should operate history stack on going back', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: GlobalKey('navigator'),
            routes: [
              Route(name: 'default', page: Text('default')),
              Route(name: 'route-1', page: Text('route-1')),
              Route(name: 'route-2', page: Text('route-2')),
            ],
          ),
        ],
        parentContext: app!.appContext,
      );

      await Future.delayed(Duration(milliseconds: 100));

      var state = app!.navigatorState('navigator');

      expect(state.canGoBack(), equals(false));
      expect(state.currentRouteName, 'default');

      state.open(name: 'route-2');
      await Future.delayed(Duration(milliseconds: 100));

      state.open(name: 'route-1');
      await Future.delayed(Duration(milliseconds: 100));

      state.open(name: 'route-2');
      await Future.delayed(Duration(milliseconds: 100));

      state.back();
      await Future.delayed(Duration(milliseconds: 100));
      expect(state.currentRouteName, 'route-1');

      state.back();
      await Future.delayed(Duration(milliseconds: 100));
      expect(state.currentRouteName, 'route-2');

      state.back();
      await Future.delayed(Duration(milliseconds: 100));

      expect(state.currentRouteName, 'default');
      expect(state.canGoBack(), equals(false));
    });

    test('should operate history stack on going back(same route)', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: GlobalKey('navigator'),
            routes: [
              Route(name: 'default', page: Text('default')),
              Route(name: 'route-1', page: Text('route-1')),
              Route(name: 'route-2', page: Text('route-2')),
            ],
          ),
        ],
        parentContext: app!.appContext,
      );

      await Future.delayed(Duration(milliseconds: 100));

      var state = app!.navigatorState('navigator');

      state.open(name: 'route-1', values: {'a': 'a'});
      await Future.delayed(Duration(milliseconds: 100));
      app!.assertMatchPath('/route-1/a/a');

      state.open(name: 'route-1', values: {'a': 'b'});
      await Future.delayed(Duration(milliseconds: 100));
      app!.assertMatchPath('/route-1/a/b');

      state.back();
      await Future.delayed(Duration(milliseconds: 100));
      app!.assertMatchPath('/route-1/a/a');
    });
  });

  /*
  |--------------------------------------------------------------------------
  | API | Getting value tests
  |--------------------------------------------------------------------------
  */

  group('Navigator, getting values tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp(
        debugOptions: DebugOptions(routerLogs: true),
      )..start();
    });

    tearDown(() => app!.stop());

    test('should return empty string if value isnt set', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: GlobalKey('navigator'),
            routes: [
              Route(name: 'route-1', page: Text('route-1')),
            ],
          ),
        ],
        parentContext: app!.appContext,
      );

      expect(app!.navigatorState('navigator').getValue('something'), '');
    });

    test('should return value if set', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: GlobalKey('navigator'),
            routes: [
              Route(name: 'route-1', page: Text('route-1')),
            ],
          ),
        ],
        parentContext: app!.appContext,
      );

      var state = app!.navigatorState('navigator');

      state.open(name: 'route-1', values: {'something': 'value'});
      await Future.delayed(Duration(milliseconds: 100));

      expect(state.getValue('something'), 'value');
    });

    test('should return value only if previously if set', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: GlobalKey('navigator'),
            routes: [
              Route(name: 'route-1', page: Text('route-1')),
            ],
          ),
        ],
        parentContext: app!.appContext,
      );

      var state = app!.navigatorState('navigator');

      state.open(name: 'route-1', values: {'something': 'value'});
      await Future.delayed(Duration(milliseconds: 100));

      state.open(name: 'route-1', values: {'changed': 'value'});
      await Future.delayed(Duration(milliseconds: 100));

      expect(state.getValue('something'), '');
      expect(state.getValue('changed'), 'value');
    });

    test('should return previous value if has gone back', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: GlobalKey('navigator'),
            routes: [
              Route(name: 'route-1', page: Text('route-1')),
            ],
          ),
        ],
        parentContext: app!.appContext,
      );

      var state = app!.navigatorState('navigator');

      state.open(name: 'route-1', values: {'something': 'value'});
      await Future.delayed(Duration(milliseconds: 100));

      state.open(name: 'route-1', values: {'changed': 'updated'});
      await Future.delayed(Duration(milliseconds: 100));
      expect(state.getValue('changed'), 'updated');

      state.back();
      await Future.delayed(Duration(milliseconds: 100));
      expect(state.getValue('something'), 'value');
    });

    test('should return value if set(special chars)', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: GlobalKey('navigator'),
            routes: [
              Route(name: 'route-1', page: Text('route-1')),
            ],
          ),
        ],
        parentContext: app!.appContext,
      );

      var state = app!.navigatorState('navigator');

      state.open(name: 'route-1', values: {'something': 'v a l'});
      await Future.delayed(Duration(milliseconds: 100));
      expect(state.getValue('something'), 'v a l');

      state.open(name: 'route-1', values: {'s o m e': 'v a l'});
      await Future.delayed(Duration(milliseconds: 100));
      expect(state.getValue('s o m e'), 'v a l');

      state.open(name: 'route-1', values: {
        r' / $ v .-;ol / \\': r'$ v.- ; o / \\',
      });
      await Future.delayed(Duration(milliseconds: 100));
      expect(state.getValue(r' / $ v .-;ol / \\'), r'$ v.- ; o / \\');
    });
  });
}
