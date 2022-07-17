// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: camel_case_types

import '../../test_imports.dart';

void main() {
  // AsyncRoute always want to check router state and issue navigator updates
  // such as causing a route to be opened, implicitly. Like most of the other
  // pieces of the framework we're testing async route at a high-level.

  group('AsyncRoute widget tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('should render route', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(routes: [
            AsyncRoute(name: 'some', page: () => Text('contents')),
          ]),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents('contents'));
    });

    test('should set route name', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(routes: [
            AsyncRoute(
              key: Key('a'),
              name: 'some',
              page: () => Text('a'),
            ),
          ]),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var widget = app!.renderElementByKeyValue('a')!.widget as AsyncRoute;

      expect(widget.name, equals('some'));
    });

    test('should set route path', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(routes: [
            AsyncRoute(
              key: Key('a'),
              name: 'some',
              path: 'path',
              page: () => Text('a'),
            ),
          ]),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var widget = app!.renderElementByKeyValue('a')!.widget as AsyncRoute;

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
        parentRenderElement: app!.appRenderElement,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents('waiting widget contents'));

      await Future.delayed(Duration(milliseconds: 200));

      expect(RT_TestBed.rootDomNode, RT_hasContents('loaded contents'));
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
        parentRenderElement: app!.appRenderElement,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents('error widget contents'));
    });

    test('should open waiting route when waiting', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: Key('navigator'),
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
        parentRenderElement: app!.appRenderElement,
      );

      var state = app!.navigatorState('navigator');

      expect(state.currentRouteName, equals('waiting-route'));

      await Future.delayed(Duration(milliseconds: 200));

      expect(state.currentRouteName, equals('async-route'));
    });

    test('should open error route when failed', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: Key('navigator'),
            routes: [
              AsyncRoute(
                name: 'async-route',
                errorRoute: 'error-route',
                page: () => throw Exception(),
              ),
              Route(name: 'error-route', page: Text('error route contents')),
            ],
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var state = app!.navigatorState('navigator');

      expect(state.currentRouteName, equals('error-route'));
    });

    test('should open error route even if error placeholder is set', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: Key('navigator'),
            routes: [
              AsyncRoute(
                name: 'async-route',
                errorRoute: 'error-route',
                errorPlaceholderWidget: Text('error widget contents'),
                page: () => throw Exception(),
              ),
              Route(name: 'error-route', page: Text('error route contents')),
            ],
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var state = app!.navigatorState('navigator');

      expect(state.currentRouteName, equals('error-route'));
    });

    test(
      'should open waiting route even if waiting placeholder is set',
      () async {
        await app!.buildChildren(
          widgets: [
            Navigator(
              key: Key('navigator'),
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
          parentRenderElement: app!.appRenderElement,
        );

        var state = app!.navigatorState('navigator');

        expect(state.currentRouteName, equals('waiting-route'));

        await Future.delayed(Duration(milliseconds: 200));

        expect(state.currentRouteName, equals('async-route'));
      },
    );

    test('should not add error history if disabled', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: Key('navigator'),
            routes: [
              AsyncRoute(
                name: 'async-route',
                enableErrorHistory: false,
                errorRoute: 'error-route',
                page: () => throw Exception(),
              ),
              Route(name: 'error-route', page: Text('error route contents')),
            ],
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var state = app!.navigatorState('navigator');

      expect(state.getValue('error-route'), equals(''));
    });

    test('should add error history if enabled', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: Key('navigator'),
            routes: [
              AsyncRoute(
                name: 'async-route',
                enableErrorHistory: true,
                errorRoute: 'error-route',
                page: () => throw Exception(),
              ),
              Route(name: 'error-route', page: Text('error route contents')),
            ],
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var state = app!.navigatorState('navigator');

      // this value tells on which route failure occured so that app can
      // rreopen that route if it want
      expect(state.getValue('error-route'), equals('async-route'));
    });

    test('should not add waiting history if disabled', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: Key('navigator'),
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
        parentRenderElement: app!.appRenderElement,
      );

      var state = app!.navigatorState('navigator');

      expect(state.getValue('waiting-route'), equals(''));
    });

    test('should add waiting history if enabled', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: Key('navigator'),
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
        parentRenderElement: app!.appRenderElement,
      );

      var state = app!.navigatorState('navigator');

      expect(state.getValue('waiting-route'), equals('async-route'));
    });

    test('should not update builder if keepInitialBuilder is true', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: Key('navigator'),
            routes: [
              AsyncRoute(
                name: 'async-route',
                keepInitialBuilder: true,
                page: () async {
                  await Future.delayed(Duration(seconds: 1));
                  return Text('loaded');
                },
              ),
            ],
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          AsyncRoute(
            name: 'async-route',
            keepInitialBuilder: true,
            page: () async {
              return Text('from updated builder');
            },
          ),
        ],
        parentRenderElement: app!.renderElementByKeyValue('navigator')!,
        updateType: UpdateType.setState,
      );

      await Future.delayed(Duration(seconds: 2));
      expect(RT_TestBed.rootDomNode, RT_hasContents('loaded'));
    });

    test('should update builder if keepInitialBuilder is false', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: Key('navigator'),
            routes: [
              AsyncRoute(
                name: 'async-route',
                keepInitialBuilder: false,
                page: () async {
                  await Future.delayed(Duration(seconds: 1));
                  return Text('loaded');
                },
              ),
            ],
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          AsyncRoute(
            name: 'async-route',
            keepInitialBuilder: false,
            page: () async {
              return Text('from updated builder');
            },
          ),
        ],
        parentRenderElement: app!.renderElementByKeyValue('navigator')!,
        updateType: UpdateType.setState,
      );

      await Future.delayed(Duration(seconds: 2));
      expect(RT_TestBed.rootDomNode, RT_hasContents('from updated builder'));
    });

    test('should not update builder if builder hasnt changed', () async {
      var stack = RT_TestStack();

      // ignore: prefer_function_declarations_over_variables
      var builder = () async {
        stack.push('called');
        await Future.delayed(Duration(seconds: 1));
        return Text('loaded');
      };

      await app!.buildChildren(
        widgets: [
          Navigator(
            key: Key('navigator'),
            routes: [
              AsyncRoute(
                name: 'async-route',
                keepInitialBuilder: false,
                page: builder,
              ),
            ],
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          AsyncRoute(
            name: 'async-route',
            keepInitialBuilder: false,
            page: builder,
          ),
        ],
        parentRenderElement: app!.renderElementByKeyValue('navigator')!,
        updateType: UpdateType.setState,
      );

      await Future.delayed(Duration(seconds: 2));
      expect(RT_TestBed.rootDomNode, RT_hasContents('loaded'));

      expect(stack.popFromStart(), equals('called'));
      expect(stack.canPop(), equals(false));
    });

    test('should retry build if failed and retry is enabled', () async {
      var testStack = RT_TestStack();

      var hasFailed = false;

      await app!.buildChildren(
        widgets: [
          Navigator(
            key: Key('navigator'),
            routes: [
              Route(name: 'default-route', page: Text('default contents')),
              AsyncRoute(
                name: 'async-route',
                errorRoute: 'error-route',
                shouldRetryFailedBuilder: true,
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
        parentRenderElement: app!.appRenderElement,
      );

      var state = app!.navigatorState('navigator');

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
