// Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '../../../test_imports.dart';

void main() {
  /*
  |--------------------------------------------------------------------------
  | State API | Opening route tests
  |--------------------------------------------------------------------------
  */

  group('Navigator, opening route tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test("should throw if route doesn't exists", () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: Key('navigator'),
            routes: [
              Route(name: 'some-route', page: Text('some route')),
            ],
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var state = app!.navigatorState('navigator');

      expect(
        () => state.open(name: 'other-route'),
        throwsA(
          predicate(
            (e) => '$e'.startsWith(
              "Exception: Router: Route with name: 'other-route' is not declared",
            ),
          ),
        ),
      );
    });

    test('should ignore duplicate open requests', () async {
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
            key: Key('navigator'),
            routes: [
              Route(name: 'route-1', page: Text('route-1')),
              Route(name: 'route-2', page: Text('route-2')),
            ],
          )
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await Future.delayed(Duration(milliseconds: 100));
      expect(RT_TestBed.rootDomNode, RT_hasContents('route-1'));

      var state = app!.navigatorState('navigator');

      state.open(name: 'route-2');
      await Future.delayed(Duration(milliseconds: 100));

      expect(RT_TestBed.rootDomNode, RT_hasContents('route-1|route-2'));
    });

    test('should open a route and update navigator current name', () async {
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
            key: Key('navigator'),
            routes: [
              Route(
                name: 'route-1',
                page: RT_TestWidget(
                  roEventRender: () => testStack.push('render-1'),
                  roEventUpdate: () => testStack.push('update-1'),
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
                  roEventRender: () => testStack.push('render-3'),
                  roEventUpdate: () => testStack.push('update-3'),
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
        parentRenderElement: app!.appRenderElement,
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

    test('should add route.path to history', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: Key('navigator'),
            routes: [
              Route(
                  name: 'route-1', path: 'route-path-1', page: Text('route-1')),
              Route(
                  name: 'route-2', path: 'route-path-2', page: Text('route-2')),
            ],
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var state = app!.navigatorState('navigator');

      state.open(name: 'route-2');
      await Future.delayed(Duration(milliseconds: 100));
      app!.assertMatchPath('/route-path-2');

      state.open(name: 'route-1');
      await Future.delayed(Duration(milliseconds: 100));
      app!.assertMatchPath('/route-path-1');

      state.open(name: 'route-2');
      await Future.delayed(Duration(milliseconds: 100));
      app!.assertMatchPath('/route-path-2');
    });

    test('should add route.path(implicitly from name) to history', () async {
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
  | State API | Can go back tests
  |--------------------------------------------------------------------------
  */

  group('Navigator, can go back to previous route tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test(
      'should return false if history is empty(no previous route)',
      () async {
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

        expect(state.canGoBack(), equals(false));
      },
    );

    test('should return true if history is non-empty', () async {
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

      state.open(name: 'route-2');
      await Future.delayed(Duration(milliseconds: 100));

      expect(state.canGoBack(), equals(true));
    });
  });

  /*
  |--------------------------------------------------------------------------
  | State API | Going back tests
  |--------------------------------------------------------------------------
  */

  group('Navigator, going to previous route tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('should throw if history is empty(no previous route)', () async {
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

      await Future.delayed(Duration(milliseconds: 100));

      var state = app!.navigatorState('navigator');

      expect(
        () => state.back(),
        throwsA(
          predicate(
            (e) => '$e'.startsWith(
              'Exception: Router: No previous route to go back',
            ),
          ),
        ),
      );
    });

    test('should operate history stack on going back', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: Key('navigator'),
            routes: [
              Route(name: 'default', page: Text('default')),
              Route(name: 'route-1', page: Text('route-1')),
              Route(name: 'route-2', page: Text('route-2')),
            ],
          ),
        ],
        parentRenderElement: app!.appRenderElement,
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
            key: Key('navigator'),
            routes: [
              Route(name: 'default', page: Text('default')),
              Route(name: 'route-1', page: Text('route-1')),
              Route(name: 'route-2', page: Text('route-2')),
            ],
          ),
        ],
        parentRenderElement: app!.appRenderElement,
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
  | State API | Look up tests
  |--------------------------------------------------------------------------
  */

  group('Navigator, state look up tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('should throw if no navigator in ancestors', () async {
      await app!.buildChildren(
        widgets: [
          Route(
            name: 'route',
            page: RT_StatefulTestWidget(
              stateHookBuild: (state) {
                expect(
                  () => Navigator.of(state.context),
                  throwsA(
                    predicate(
                      (e) => '$e'.startsWith(
                        'Exception: Navigator operation requested with a',
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );
    });

    test('should match the ancestor navigator', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: Key('nav'),
            routes: [
              Route(
                name: 'route',
                page: RT_StatefulTestWidget(
                  stateHookBuild: (state) {
                    var navigatorState = Navigator.of(state.context);

                    expect(navigatorState.widget.key?.frameworkValue,
                        equals('nav'));
                  },
                ),
              ),
            ],
          )
        ],
        parentRenderElement: app!.appRenderElement,
      );
    });

    test('should match the closest ancestor navigator by default', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: Key('parent'),
            routes: [
              Route(
                name: 'route',
                page: Navigator(
                  key: Key('child'),
                  routes: [
                    Route(
                      name: 'route',
                      page: RT_StatefulTestWidget(
                        stateHookBuild: (state) {
                          var navigatorState = Navigator.of(state.context);

                          expect(
                            navigatorState.widget.key?.frameworkValue,
                            equals('child'),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );
    });

    test('should match the keyed ancestor navigator if requested', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: Key('parent'),
            routes: [
              Route(
                name: 'route',
                page: Navigator(
                  key: Key('child'),
                  routes: [
                    Route(
                      name: 'route',
                      page: RT_StatefulTestWidget(
                        stateHookBuild: (state) {
                          var navigatorState1 = Navigator.of(
                            state.context,
                            byKey: Key('child'),
                          );

                          var navigatorState2 = Navigator.of(
                            state.context,
                            byKey: Key('parent'),
                          );

                          expect(
                            navigatorState1.widget.key?.frameworkValue,
                            equals('child'),
                          );

                          expect(
                            navigatorState2.widget.key?.frameworkValue,
                            equals('parent'),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );
    });
  });

  /*
  |--------------------------------------------------------------------------
  | State API | onInit tests
  |--------------------------------------------------------------------------
  */

  group('Navigator, onInit tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    Future<void> build(Function(NavigatorState) onInitCallback) async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: Key('navigator'),
            onInit: onInitCallback,
            routes: [
              Route(name: 'p1', page: Text('page one')),
              Route(name: 'p2', page: Text('page two')),
              Route(name: 'p3', page: Text('page three')),
            ],
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );
    }

    test('should have current route information available', () async {
      await build((state) {
        expect(state.currentRouteName, equals('p1'));
      });
    });

    test('should get called before rendering default route', () async {
      await build((_) {
        expect(app!.appDomNode, RT_hasContents(''));
      });

      expect(app!.appDomNode, RT_hasContents('page one'));
    });

    test('should handle .open inside onInit', () async {
      await build((state) {
        state.open(name: 'p3');
      });

      expect(app!.navigatorState('navigator').currentRouteName, equals('p3'));
    });

    test('should handle multiple .open inside onInit', () async {
      await build((state) {
        state.open(name: 'p2');
        state.open(name: 'p1');
        state.open(name: 'p3');
      });

      var routesSel = '.${Constants.classRoute}:not(.${Constants.classHidden})';
      var routeNodes = document.querySelectorAll(routesSel);
      expect(routeNodes.map((n) => n.text).join('|'), equals('page three'));
    });
  });

  /*
  |--------------------------------------------------------------------------
  | State API | onDispose tests
  |--------------------------------------------------------------------------
  */

  group('Navigator, onDispose tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    Future<void> build(Function(NavigatorState) onDisposeCallback) async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: Key('navigator'),
            onDispose: onDisposeCallback,
            routes: [
              Route(name: 'p1', page: Text('page 1')),
              Route(name: 'p2', page: Text('page 2')),
              Route(name: 'p3', page: Text('page 3')),
              Route(name: 'p4', page: Text('page 4')),
            ],
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );
    }

    Future<void> update(Function(NavigatorState) onDisposeCallback) async {
      await app!.updateChildren(
        widgets: [
          Navigator(
            key: Key('navigator'),
            onDispose: onDisposeCallback,
            routes: [
              Route(name: 'p1', page: Text('page 1')),
              Route(name: 'p2', page: Text('page 2')),
              Route(name: 'p3', page: Text('page 3')),
              Route(name: 'p4', page: Text('page 4')),
            ],
          ),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );
    }

    Future<void> dispose() async {
      await app!.updateChildren(
        widgets: [],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );
    }

    test('should have current route information available', () async {
      await build((state) {
        expect(state.currentRouteName, equals('p1'));
      });

      await dispose();
    });

    test('should get called after actual dispose', () async {
      await build((_) {
        expect(app!.appDomNode, RT_hasContents(''));
      });

      await dispose();
      expect(app!.appDomNode, RT_hasContents(''));
    });

    test('should call latest callback exactly once', () async {
      var testStack = RT_TestStack();

      await build((_) => testStack.push('0'));

      await update((_) => testStack.push('1'));
      await update((_) => testStack.push('2'));
      await update((_) => testStack.push('3'));
      await update((_) => testStack.push('4'));

      await dispose();

      expect(testStack.popFromStart(), equals('4'));
      expect(testStack.canPop(), equals(false));
    });

    test('should throw, open() inside onDispose', () async {
      await build((state) {
        expect(
          () => state.open(name: 'p2'),
          throwsA(
            predicate(
              (e) => '$e'.startsWith(
                'Exception: Cannot call open() after state is disposed off.',
              ),
            ),
          ),
        );
      });

      await dispose();
    });

    test('should throw, back() inside onDispose', () async {
      await build((state) {
        expect(
          () => state.back(),
          throwsA(
            predicate(
              (e) => '$e'.startsWith(
                'Exception: Cannot call back() after state is disposed off.',
              ),
            ),
          ),
        );
      });

      await dispose();
    });

    test('should throw, canGoBack() inside onDispose', () async {
      await build((state) {
        expect(
          () => state.canGoBack(),
          throwsA(
            predicate(
              (e) => '$e'.startsWith(
                'Exception: Cannot call canGoBack() after state is disposed off.',
              ),
            ),
          ),
        );
      });

      await dispose();
    });

    test('should throw, getValue() inside onDispose', () async {
      await build((state) {
        expect(
          () => state.getValue('some-key'),
          throwsA(
            predicate(
              (e) => '$e'.startsWith(
                'Exception: Cannot call getValue() after state is disposed off.',
              ),
            ),
          ),
        );
      });

      await dispose();
    });
  });

  /*
  |--------------------------------------------------------------------------
  | State API | Getting value tests
  |--------------------------------------------------------------------------
  */

  group('Navigator, getting values tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('should return empty string if value is not set', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: Key('navigator'),
            routes: [
              Route(name: 'route-1', page: Text('route-1')),
            ],
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      expect(app!.navigatorState('navigator').getValue('something'), '');
    });

    test('should return value if set', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: Key('navigator'),
            routes: [
              Route(name: 'route-1', page: Text('route-1')),
            ],
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var state = app!.navigatorState('navigator');

      state.open(name: 'route-1', values: {'something': 'value'});
      await Future.delayed(Duration(milliseconds: 100));

      expect(state.getValue('something'), 'value');
    });

    test(
      'should return segment following the current route if getValue '
      'is called using current route',
      () async {
        await app!.buildChildren(
          widgets: [
            Navigator(
              key: Key('navigator'),
              routes: [
                Route(name: 'route-1', page: Text('route-1')),
              ],
            ),
          ],
          parentRenderElement: app!.appRenderElement,
        );

        var state = app!.navigatorState('navigator');

        state.open(name: 'route-1', values: {'': 'value'});
        await Future.delayed(Duration(milliseconds: 100));

        expect(app!.navigatorState('navigator').getValue('route-1'), 'value');
      },
    );

    test(
      'should return segment following the current route if getValue '
      'is called using empty string',
      () async {
        await app!.buildChildren(
          widgets: [
            Navigator(
              key: Key('navigator'),
              routes: [
                Route(name: 'route-1', page: Text('route-1')),
              ],
            ),
          ],
          parentRenderElement: app!.appRenderElement,
        );

        var state = app!.navigatorState('navigator');

        state.open(name: 'route-1', values: {'something': 'value'});
        await Future.delayed(Duration(milliseconds: 100));

        expect(app!.navigatorState('navigator').getValue(''), 'something');
      },
    );

    test('should return value only if previously if set', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: Key('navigator'),
            routes: [
              Route(name: 'route-1', page: Text('route-1')),
            ],
          ),
        ],
        parentRenderElement: app!.appRenderElement,
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
            key: Key('navigator'),
            routes: [
              Route(name: 'route-1', page: Text('route-1')),
            ],
          ),
        ],
        parentRenderElement: app!.appRenderElement,
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
            key: Key('navigator'),
            routes: [
              Route(name: 'route-1', page: Text('route-1')),
            ],
          ),
        ],
        parentRenderElement: app!.appRenderElement,
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
