// ignore_for_file: camel_case_types

import '../../test_imports.dart';

void main() {
  // AsyncRoute always want to check router state and issue navigator updates
  // such as causing a route to be opened, implicitly. Like most of the other
  // pieces of the framework we're testing async route at a high-level.

  group('AsyncRoute widget tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp(debugOptions: DebugOptions(routerLogs: true))
        ..start();
    });

    tearDown(() => app!.stop());

    test('should render route', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(routes: [
            AsyncRoute(name: 'some', page: () async => Text('contents')),
          ]),
        ],
        parentContext: app!.appContext,
      );

      expect(RT_TestBed.rootElement, RT_hasContents('contents'));
    });

    test('should set route name', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(routes: [
            AsyncRoute(
              key: GlobalKey('a'),
              name: 'some',
              page: () async => Text('a'),
            ),
          ]),
        ],
        parentContext: app!.appContext,
      );

      var widget = app!.widgetObjectByGlobalKey('a').widget as AsyncRoute;

      expect(widget.name, equals('some'));
    });

    test('should set route path', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(routes: [
            AsyncRoute(
              key: GlobalKey('a'),
              name: 'some',
              path: 'path',
              page: () async => Text('a'),
            ),
          ]),
        ],
        parentContext: app!.appContext,
      );

      var widget = app!.widgetObjectByGlobalKey('a').widget as AsyncRoute;

      expect(widget.path, equals('path'));
    });

    test('should show a placeholder widget when waiting', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(routes: [
            AsyncRoute(
              name: 'some',
              waitingPlaceholderWidget: Text('waiting widget contents'),
              page: () async {
                await Future.delayed(Duration(milliseconds: 100));
                return Text('loaded contents');
              },
            ),
          ]),
        ],
        parentContext: app!.appContext,
      );

      expect(RT_TestBed.rootElement, RT_hasContents('waiting widget contents'));

      await Future.delayed(Duration(milliseconds: 200));

      expect(RT_TestBed.rootElement, RT_hasContents('loaded contents'));
    });

    test('should show a error widget when failed', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(routes: [
            AsyncRoute(
              name: 'some',
              errorPlaceholderWidget: Text('error widget contents'),
              page: () async {
                throw Exception('failed');
              },
            ),
          ]),
        ],
        parentContext: app!.appContext,
      );

      expect(RT_TestBed.rootElement, RT_hasContents('error widget contents'));
    });

    test('should open waiting route when waiting', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: GlobalKey('navigator'),
            routes: [
              AsyncRoute(
                name: 'async-route',
                waitingRoute: 'waiting-route',
                page: () async {
                  await Future.delayed(Duration(milliseconds: 100));
                  return Text('loaded');
                },
              ),
              Route(
                name: 'waiting-route',
                page: Text('waiting route contents'),
              ),
            ],
          ),
        ],
        parentContext: app!.appContext,
      );

      var wo = app!.widgetObjectByGlobalKey('navigator');
      var state = (wo.renderObject as NavigatorRenderObject).state;

      expect(state.currentRouteName, equals('waiting-route'));

      await Future.delayed(Duration(milliseconds: 200));

      expect(state.currentRouteName, equals('async-route'));
    });

    test('should open error route when failed', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: GlobalKey('navigator'),
            routes: [
              AsyncRoute(
                name: 'async-route',
                errorRoute: 'error-route',
                page: () async => throw Exception(),
              ),
              Route(name: 'error-route', page: Text('error route contents')),
            ],
          ),
        ],
        parentContext: app!.appContext,
      );

      var wo = app!.widgetObjectByGlobalKey('navigator');
      var state = (wo.renderObject as NavigatorRenderObject).state;

      expect(state.currentRouteName, equals('error-route'));
    });

    test('should open error route even if error placeholder is set', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: GlobalKey('navigator'),
            routes: [
              AsyncRoute(
                name: 'async-route',
                errorRoute: 'error-route',
                errorPlaceholderWidget: Text('error widget contents'),
                page: () async => throw Exception(),
              ),
              Route(name: 'error-route', page: Text('error route contents')),
            ],
          ),
        ],
        parentContext: app!.appContext,
      );

      var wo = app!.widgetObjectByGlobalKey('navigator');
      var state = (wo.renderObject as NavigatorRenderObject).state;

      expect(state.currentRouteName, equals('error-route'));
    });

    test(
      'should open waiting route even if waiting placeholder is set',
      () async {
        await app!.buildChildren(
          widgets: [
            Navigator(
              key: GlobalKey('navigator'),
              routes: [
                AsyncRoute(
                  name: 'async-route',
                  waitingRoute: 'waiting-route',
                  waitingPlaceholderWidget: Text('waiting widget contents'),
                  page: () async {
                    await Future.delayed(Duration(milliseconds: 100));
                    return Text('loaded contents');
                  },
                ),
                Route(
                  name: 'waiting-route',
                  page: Text('waiting route contents'),
                ),
              ],
            ),
          ],
          parentContext: app!.appContext,
        );

        var wo = app!.widgetObjectByGlobalKey('navigator');
        var state = (wo.renderObject as NavigatorRenderObject).state;

        expect(state.currentRouteName, equals('waiting-route'));

        await Future.delayed(Duration(milliseconds: 200));

        expect(state.currentRouteName, equals('async-route'));
      },
    );

    test('should not add error history if disabled', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: GlobalKey('navigator'),
            routes: [
              AsyncRoute(
                name: 'async-route',
                enableErrorHistory: false,
                errorRoute: 'error-route',
                page: () async => throw Exception(),
              ),
              Route(name: 'error-route', page: Text('error route contents')),
            ],
          ),
        ],
        parentContext: app!.appContext,
      );

      var wo = app!.widgetObjectByGlobalKey('navigator');
      var state = (wo.renderObject as NavigatorRenderObject).state;

      expect(state.getValue('error-route'), equals(''));
    });

    test('should add error history if enabled', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: GlobalKey('navigator'),
            routes: [
              AsyncRoute(
                name: 'async-route',
                enableErrorHistory: true,
                errorRoute: 'error-route',
                page: () async => throw Exception(),
              ),
              Route(name: 'error-route', page: Text('error route contents')),
            ],
          ),
        ],
        parentContext: app!.appContext,
      );

      var wo = app!.widgetObjectByGlobalKey('navigator');
      var state = (wo.renderObject as NavigatorRenderObject).state;

      // this value tells on which route failure occured so that app can
      // rreopen that route if it want
      expect(state.getValue('error-route'), equals('async-route'));
    });

    test('should not add waiting history if disabled', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: GlobalKey('navigator'),
            routes: [
              AsyncRoute(
                name: 'async-route',
                enableWaitingHistory: false,
                waitingRoute: 'waiting-route',
                page: () async {
                  await Future.delayed(Duration(milliseconds: 100));
                  return Text('loaded');
                },
              ),
              Route(
                name: 'waiting-route',
                page: Text('waiting route contents'),
              ),
            ],
          ),
        ],
        parentContext: app!.appContext,
      );

      var wo = app!.widgetObjectByGlobalKey('navigator');
      var state = (wo.renderObject as NavigatorRenderObject).state;

      expect(state.getValue('waiting-route'), equals(''));
    });

    test('should add waiting history if enabled', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: GlobalKey('navigator'),
            routes: [
              AsyncRoute(
                name: 'async-route',
                enableWaitingHistory: true,
                waitingRoute: 'waiting-route',
                page: () async {
                  await Future.delayed(Duration(milliseconds: 100));
                  return Text('loaded');
                },
              ),
              Route(
                name: 'waiting-route',
                page: Text('waiting route contents'),
              ),
            ],
          ),
        ],
        parentContext: app!.appContext,
      );

      var wo = app!.widgetObjectByGlobalKey('navigator');
      var state = (wo.renderObject as NavigatorRenderObject).state;

      expect(state.getValue('waiting-route'), equals('async-route'));
    });

    test('should retry build if failed and retry is enabled', () async {
      var testStack = RT_TestStack();

      var hasFailed = false;

      await app!.buildChildren(
        widgets: [
          Navigator(
            key: GlobalKey('navigator'),
            routes: [
              Route(name: 'default-route', page: Text('default contents')),
              AsyncRoute(
                name: 'async-route',
                errorRoute: 'error-route',
                retryFailedBuilder: true,
                page: () async {
                  testStack.push('trying');

                  if (!hasFailed) {
                    hasFailed = true;

                    testStack.push('failed');

                    throw Exception();
                  }

                  testStack.push('loaded');

                  return Text('loaded');
                },
              ),
              Route(name: 'error-route', page: Text('error route contents')),
            ],
          ),
        ],
        parentContext: app!.appContext,
      );

      var wo = app!.widgetObjectByGlobalKey('navigator');
      var state = (wo.renderObject as NavigatorRenderObject).state;

      // try open
      state.open(name: 'async-route');
      await Future.delayed(Duration(milliseconds: 100));

      // should fail and open error route
      expect(state.currentRouteName, equals('error-route'));

      // retry open
      state.open(name: 'async-route');
      await Future.delayed(Duration(milliseconds: 100));

      // should succeed in opening second time
      expect(state.currentRouteName, equals('async-route'));

      // check stack

      expect(testStack.popFromStart(), equals('trying'));
      expect(testStack.popFromStart(), equals('failed'));
      expect(testStack.popFromStart(), equals('trying'));
      expect(testStack.popFromStart(), equals('loaded'));

      expect(testStack.canPop(), equals(false));
    });
  });
}
