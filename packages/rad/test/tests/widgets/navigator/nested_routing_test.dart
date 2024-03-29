// Copyright (c) 2022, H. Singh <hamsbrar@gmail.com>. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '../../../test_imports.dart';

void main() {
  /*
  |--------------------------------------------------------------------------
  | Navigator routing tests | Default routes
  |--------------------------------------------------------------------------
  */

  group('Navigator, routing to default routes:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('should open default route in the tree', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: Key('parent'),
            routes: [
              Route(
                name: 'p-route-1',
                page: Navigator(
                  key: Key('child'),
                  routes: [
                    Route(name: 'c-route-1', page: Text('c-route-1')),
                    Route(name: 'c-route-2', page: Text('c-route-2')),
                  ],
                ),
              ),
              Route(name: 'p-route-2', page: Text('p-route-2')),
            ],
          )
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var parent = app!.navigatorState('parent');
      var child = app!.navigatorState('child');

      expect(parent.currentRouteName, 'p-route-1');
      expect(child.currentRouteName, 'c-route-1');
    });

    test(
      'should open default route in the tree '
      'even if navigators are not in a direct relationship',
      () async {
        await app!.buildChildren(
          widgets: [
            Navigator(
              key: Key('parent'),
              routes: [
                Route(
                  name: 'p-route-1',
                  page: Division(
                    children: [
                      Navigator(
                        key: Key('child'),
                        routes: [
                          Route(name: 'c-route-1', page: Text('c-route-1')),
                          Route(name: 'c-route-2', page: Text('c-route-2')),
                        ],
                      ),
                    ],
                  ),
                ),
                Route(name: 'p-route-2', page: Text('p-route-2')),
              ],
            )
          ],
          parentRenderElement: app!.appRenderElement,
        );

        var parent = app!.navigatorState('parent');
        var child = app!.navigatorState('child');

        expect(parent.currentRouteName, 'p-route-1');
        expect(child.currentRouteName, 'c-route-1');
      },
    );

    test('(lvl-3) should open default route in the tree', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: Key('g-parent'),
            routes: [
              Route(
                name: 'g-p-route-1',
                page: Navigator(
                  key: Key('parent'),
                  routes: [
                    Route(
                      name: 'p-route-1',
                      page: Navigator(
                        key: Key('child'),
                        routes: [
                          Route(name: 'c-route-1', page: Text('c-route-1')),
                          Route(name: 'c-route-2', page: Text('c-route-2')),
                        ],
                      ),
                    ),
                    Route(name: 'p-route-2', page: Text('p-route-2')),
                  ],
                ),
              ),
              Route(name: 'g-p-route-2', page: Text('g-p-route-2')),
            ],
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var gParent = app!.navigatorState('g-parent');
      var parent = app!.navigatorState('parent');
      var child = app!.navigatorState('child');

      expect(gParent.currentRouteName, 'g-p-route-1');
      expect(parent.currentRouteName, 'p-route-1');
      expect(child.currentRouteName, 'c-route-1');
    });

    test(
      '(lvl-3) should open default route in the tree '
      'even if navigators are not in a direct relationship',
      () async {
        await app!.buildChildren(
          widgets: [
            Navigator(
              key: Key('g-parent'),
              routes: [
                Route(
                  name: 'g-p-route-1',
                  page: Division(
                    children: [
                      Navigator(
                        key: Key('parent'),
                        routes: [
                          Route(
                            name: 'p-route-1',
                            page: Division(
                              children: [
                                Navigator(
                                  key: Key('child'),
                                  routes: [
                                    Route(
                                      name: 'c-route-1',
                                      page: Text('c-rt-1'),
                                    ),
                                    Route(
                                      name: 'c-route-2',
                                      page: Text('c-rt-2'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Route(name: 'p-route-2', page: Text('p-route-2')),
                        ],
                      ),
                    ],
                  ),
                ),
                Route(name: 'g-p-route-2', page: Text('g-p-route-2')),
              ],
            ),
          ],
          parentRenderElement: app!.appRenderElement,
        );

        var gParent = app!.navigatorState('g-parent');
        var parent = app!.navigatorState('parent');
        var child = app!.navigatorState('child');

        expect(gParent.currentRouteName, 'g-p-route-1');
        expect(parent.currentRouteName, 'p-route-1');
        expect(child.currentRouteName, 'c-route-1');
      },
    );

    test('should open default route in child if parent not matched', () async {
      // should not match with this,
      await app!.setPath('/p-route-mis1/c-route-2');

      await app!.buildChildren(
        widgets: [
          Navigator(
            key: Key('parent'),
            routes: [
              Route(
                name: 'p-route-1',
                page: Navigator(
                  key: Key('child'),
                  routes: [
                    Route(name: 'c-route-1', page: Text('c-route-1')),
                    Route(name: 'c-route-2', page: Text('c-route-2')),
                  ],
                ),
              ),
              Route(name: 'p-route-2', page: Text('p-route-2')),
            ],
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var parent = app!.navigatorState('parent');
      expect(parent.currentRouteName, 'p-route-1');

      var child = app!.navigatorState('child');
      expect(child.currentRouteName, 'c-route-1');
    });

    test(
      'should open default route in child if parent not matched '
      'with interleaving values',
      () async {
        // should not match with this,
        await app!.setPath('/p-route-mis1/some/value/c-route-2/something');

        await app!.buildChildren(
          widgets: [
            Navigator(
              key: Key('parent'),
              routes: [
                Route(
                  name: 'p-route-1',
                  page: Navigator(
                    key: Key('child'),
                    routes: [
                      Route(name: 'c-route-1', page: Text('c-route-1')),
                      Route(name: 'c-route-2', page: Text('c-route-2')),
                    ],
                  ),
                ),
                Route(name: 'p-route-2', page: Text('p-route-2')),
              ],
            ),
          ],
          parentRenderElement: app!.appRenderElement,
        );

        var parent = app!.navigatorState('parent');
        expect(parent.currentRouteName, 'p-route-1');

        var child = app!.navigatorState('child');
        expect(child.currentRouteName, 'c-route-1');
      },
    );

    test(
      '(lvl-3) should open default route in child if parent not matched ',
      () async {
        // should not match with this,
        await app!.setPath('/g-p-route-1s/p-route-2/c-route-2');

        await app!.buildChildren(
          widgets: [
            Navigator(
              key: Key('g-parent'),
              routes: [
                Route(
                  name: 'g-p-route-1',
                  page: Navigator(
                    key: Key('parent'),
                    routes: [
                      Route(
                        name: 'p-route-1',
                        page: Navigator(
                          key: Key('child'),
                          routes: [
                            Route(name: 'c-route-1', page: Text('c-route-1')),
                            Route(name: 'c-route-2', page: Text('c-route-2')),
                          ],
                        ),
                      ),
                      Route(name: 'p-route-2', page: Text('p-route-2')),
                    ],
                  ),
                ),
                Route(name: 'g-p-route-2', page: Text('g-p-route-2')),
              ],
            ),
          ],
          parentRenderElement: app!.appRenderElement,
        );

        var gParent = app!.navigatorState('g-parent');
        expect(gParent.currentRouteName, 'g-p-route-1');

        var parent = app!.navigatorState('parent');
        expect(parent.currentRouteName, 'p-route-1');

        var child = app!.navigatorState('child');
        expect(child.currentRouteName, 'c-route-1');
      },
    );

    test(
      '(lvl-3) should open default route in child if parent not matched '
      'with interleaving values',
      () async {
        // should not match with this,
        await app!.setPath('/g-p-route-1s/p-route-1/some/value/c-route-2/some');

        await app!.buildChildren(
          widgets: [
            Navigator(
              key: Key('g-parent'),
              routes: [
                Route(
                  name: 'g-p-route-1',
                  page: Navigator(
                    key: Key('parent'),
                    routes: [
                      Route(
                        name: 'p-route-1',
                        page: Navigator(
                          key: Key('child'),
                          routes: [
                            Route(name: 'c-route-1', page: Text('c-route-1')),
                            Route(name: 'c-route-2', page: Text('c-route-2')),
                          ],
                        ),
                      ),
                      Route(name: 'p-route-2', page: Text('p-route-2')),
                    ],
                  ),
                ),
                Route(name: 'g-p-route-2', page: Text('g-p-route-2')),
              ],
            ),
          ],
          parentRenderElement: app!.appRenderElement,
        );

        var gParent = app!.navigatorState('g-parent');
        expect(gParent.currentRouteName, 'g-p-route-1');

        var parent = app!.navigatorState('parent');
        expect(parent.currentRouteName, 'p-route-1');

        var child = app!.navigatorState('child');
        expect(child.currentRouteName, 'c-route-1');
      },
    );
  });

  /*
  |--------------------------------------------------------------------------
  | Navigator routing tests | Routing path tests
  |--------------------------------------------------------------------------
  */

  group('Navigator, routing path tests:', () {
    test('should set routing path', () async {
      var app = createTestApp(
        routerOptions: RouterOptions(
          path: '/some-path',
          enableHashBasedRouting: false,
        ),
      )..start();

      await app.buildChildren(
        widgets: [
          Navigator(
            routes: [
              Route(name: 'test', page: Text('hw')),
            ],
          ),
        ],
        parentRenderElement: app.appRenderElement,
      );

      app.assertMatchPath('some-path/test');
    });

    test(
      'should add hash after routing path when routing is hash based',
      () async {
        var app = createTestApp(
          routerOptions: RouterOptions(
            path: '/some-path',
            enableHashBasedRouting: true,
          ),
        )..start();

        await app.buildChildren(
          widgets: [
            Navigator(
              routes: [
                Route(name: 'test', page: Text('hw')),
              ],
            ),
          ],
          parentRenderElement: app.appRenderElement,
        );

        app.assertMatchFullPath('some-path/#/test');
      },
    );
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

    test('should open matched child route', () async {
      //
      await app!.setPath('/p-route-1/c-route-2/');

      await app!.buildChildren(
        widgets: [
          Navigator(
            key: Key('parent'),
            routes: [
              Route(
                name: 'p-route-1',
                page: Navigator(
                  key: Key('child'),
                  routes: [
                    Route(name: 'c-route-1', page: Text('c-route-1')),
                    Route(name: 'c-route-2', page: Text('c-route-2')),
                  ],
                ),
              ),
              Route(name: 'p-route-2', page: Text('p-route-2')),
            ],
          )
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var parent = app!.navigatorState('parent');
      var child = app!.navigatorState('child');

      expect(parent.currentRouteName, 'p-route-1');
      expect(child.currentRouteName, 'c-route-2');
    });

    test('should open matched child route without trailing slash', () async {
      //
      await app!.setPath('/p-route-1/c-route-2');

      await app!.buildChildren(
        widgets: [
          Navigator(
            key: Key('parent'),
            routes: [
              Route(
                name: 'p-route-1',
                page: Navigator(
                  key: Key('child'),
                  routes: [
                    Route(name: 'c-route-1', page: Text('c-route-1')),
                    Route(name: 'c-route-2', page: Text('c-route-2')),
                  ],
                ),
              ),
              Route(name: 'p-route-2', page: Text('p-route-2')),
            ],
          )
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var parent = app!.navigatorState('parent');
      var child = app!.navigatorState('child');

      expect(parent.currentRouteName, 'p-route-1');
      expect(child.currentRouteName, 'c-route-2');
    });

    test(
      'should open matched child route with interleaving values',
      () async {
        //
        await app!.setPath('/p-route-1/something/c-route-2/something');

        await app!.buildChildren(
          widgets: [
            Navigator(
              key: Key('parent'),
              routes: [
                Route(
                  name: 'p-route-1',
                  page: Navigator(
                    key: Key('child'),
                    routes: [
                      Route(name: 'c-route-1', page: Text('c-route-1')),
                      Route(name: 'c-route-2', page: Text('c-route-2')),
                    ],
                  ),
                ),
                Route(name: 'p-route-2', page: Text('p-route-2')),
              ],
            )
          ],
          parentRenderElement: app!.appRenderElement,
        );

        var parent = app!.navigatorState('parent');
        var child = app!.navigatorState('child');

        expect(parent.currentRouteName, 'p-route-1');
        expect(child.currentRouteName, 'c-route-2');
      },
    );

    test(
      'should open matched child route with interleaving special values',
      () async {
        //
        await app!.setPath('/p-route-1/some%%thing/c-route-2/something');

        await app!.buildChildren(
          widgets: [
            Navigator(
              key: Key('parent'),
              routes: [
                Route(
                  name: 'p-route-1',
                  page: Navigator(
                    key: Key('child'),
                    routes: [
                      Route(name: 'c-route-1', page: Text('c-route-1')),
                      Route(name: 'c-route-2', page: Text('c-route-2')),
                    ],
                  ),
                ),
                Route(name: 'p-route-2', page: Text('p-route-2')),
              ],
            )
          ],
          parentRenderElement: app!.appRenderElement,
        );

        var parent = app!.navigatorState('parent');
        var child = app!.navigatorState('child');

        expect(parent.currentRouteName, 'p-route-1');
        expect(child.currentRouteName, 'c-route-2');
      },
    );

    test('(lvl-3) should open matched child route', () async {
      //
      await app!.setPath('/g-p-route-2/p-route-1/c-route-2/');

      await app!.buildChildren(
        widgets: [
          Navigator(
            key: Key('g-parent'),
            routes: [
              Route(name: 'g-p-route-1', page: Text('g-p-route-2')),
              Route(
                name: 'g-p-route-2',
                page: Navigator(
                  key: Key('parent'),
                  routes: [
                    Route(
                      name: 'p-route-1',
                      page: Navigator(
                        key: Key('child'),
                        routes: [
                          Route(name: 'c-route-1', page: Text('c-route-1')),
                          Route(name: 'c-route-2', page: Text('c-route-2')),
                        ],
                      ),
                    ),
                    Route(name: 'p-route-2', page: Text('p-route-2')),
                  ],
                ),
              ),
            ],
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var gParent = app!.navigatorState('g-parent');
      expect(gParent.currentRouteName, 'g-p-route-2');

      var parent = app!.navigatorState('parent');
      expect(parent.currentRouteName, 'p-route-1');

      var child = app!.navigatorState('child');
      expect(child.currentRouteName, 'c-route-2');
    });

    test(
      '(lvl-3) should open matched child route with interleaving values',
      () async {
        //
        await app!.setPath('/g-p-route-2/some/val/p-route-1/s/c-route-2/s/');

        await app!.buildChildren(
          widgets: [
            Navigator(
              key: Key('g-parent'),
              routes: [
                Route(name: 'g-p-route-1', page: Text('g-p-route-2')),
                Route(
                  name: 'g-p-route-2',
                  page: Navigator(
                    key: Key('parent'),
                    routes: [
                      Route(
                        name: 'p-route-1',
                        page: Navigator(
                          key: Key('child'),
                          routes: [
                            Route(name: 'c-route-1', page: Text('c-route-1')),
                            Route(name: 'c-route-2', page: Text('c-route-2')),
                          ],
                        ),
                      ),
                      Route(name: 'p-route-2', page: Text('p-route-2')),
                    ],
                  ),
                ),
              ],
            ),
          ],
          parentRenderElement: app!.appRenderElement,
        );

        var gParent = app!.navigatorState('g-parent');
        expect(gParent.currentRouteName, 'g-p-route-2');

        var parent = app!.navigatorState('parent');
        expect(parent.currentRouteName, 'p-route-1');

        var child = app!.navigatorState('child');
        expect(child.currentRouteName, 'c-route-2');
      },
    );

    test(
      'should open matched child route with values similar to paths',
      () async {
        //
        await app!.setPath(
          '/g-p-route-2/p-route-1-val/p-route-1/p-route-1-val-2/c-route-2/val-p-route-1-val-2/s/',
        );

        await app!.buildChildren(
          widgets: [
            Navigator(
              key: Key('g-parent'),
              routes: [
                Route(name: 'g-p-route-1', page: Text('g-p-route-2')),
                Route(
                  name: 'g-p-route-2',
                  page: Navigator(
                    key: Key('parent'),
                    routes: [
                      Route(
                        name: 'p-route-1',
                        page: Navigator(
                          key: Key('child'),
                          routes: [
                            Route(name: 'c-route-1', page: Text('c-route-1')),
                            Route(name: 'c-route-2', page: Text('c-route-2')),
                          ],
                        ),
                      ),
                      Route(name: 'p-route-2', page: Text('p-route-2')),
                    ],
                  ),
                ),
              ],
            ),
          ],
          parentRenderElement: app!.appRenderElement,
        );

        var gParent = app!.navigatorState('g-parent');
        expect(gParent.currentRouteName, 'g-p-route-2');

        var parent = app!.navigatorState('parent');
        expect(parent.currentRouteName, 'p-route-1');

        var child = app!.navigatorState('child');
        expect(child.currentRouteName, 'c-route-2');
      },
    );
  });

  /*
  |--------------------------------------------------------------------------
  | Navigator routing tests | Multiple navigators at same level
  |--------------------------------------------------------------------------
  */

  group('Navigator, routing to multiple navigators at same level:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    NavigatorState state(String key) => app!.navigatorState(key);

    Future<void> build(String setPath) async {
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
            ],
          )
        ],
        parentRenderElement: app!.appRenderElement,
      );
    }

    test('should open default in parent', () async {
      for (final path in [
        '/',
        '/p-something',
        'p-something/',
        '///',
        '//p-route-1/',
      ]) {
        await build(path);
        expect(state('parent').currentRouteName, 'p-route-1');
      }
    });

    test('should open matched parent', () async {
      for (final path in [
        'p-route-1',
        '/p-route-1',
        'p-route-1/',
        '/p-route-1/',
        '/p-route-1/cat',
        'p-route-1/bird',
        '/p-route-1/c-p1-route-1',
        '/p-route-1/c-p1-route-2',
        '/p-route-1/c-p2-route-2',
        '/p-route-1/c-p2-route-1',
      ]) {
        await build(path);
        expect(state('parent').currentRouteName, 'p-route-1');
      }

      for (final path in [
        'p-route-2',
        '/p-route-2',
        'p-route-2/',
        '/p-route-2/',
        '/p-route-2/cat',
        'p-route-2/bird',
        '/p-route-2/c-p2-route-1',
        '/p-route-2/c-p2-route-2',
        '/p-route-2/c-p1-route-2',
        '/p-route-2/c-p1-route-1',
      ]) {
        await build(path);
        expect(state('parent').currentRouteName, 'p-route-2');
      }
    });

    test('should open default child', () async {
      for (final path in [
        '/p-route-1/',
        '/p-route-1/p-something',
        '/p-route-1/p-something/',
        '/p-route-1///',
        '/p-route-1//butterfly/',
        '/p-route-1//c-p1-route-1/',
      ]) {
        await build(path);
        expect(state('child-p1').currentRouteName, 'c-p1-route-1');
      }

      for (final path in [
        '/p-route-2/',
        '/p-route-2/p-something',
        '/p-route-2/p-something/',
        '/p-route-2///',
        '/p-route-2//butterfly/',
        '/p-route-2//c-p1-route-1/',
        '/p-route-2//c-p2-route-1/',
      ]) {
        await build(path);
        expect(state('child-p2').currentRouteName, 'c-p2-route-1');
      }
    });

    test('should open matched child', () async {
      for (final path in [
        '/p-route-1/c-p1-route-2',
        '/p-route-1/c-p1-route-2/',
        '/p-route-1///c-p1-route-2/',
        '/p-route-1/bird/c-p1-route-2/',
        '/p-route-1/c-p1-route-2/cat/',
        '/p-route-1///c-p1-route-2/cat',
        '/p-route-1///c-p1-route-2/cat/',
      ]) {
        await build(path);
        expect(state('child-p1').currentRouteName, 'c-p1-route-2');
      }

      for (final path in [
        '/p-route-2/c-p2-route-2',
        '/p-route-2/c-p2-route-2/',
        '/p-route-2///c-p2-route-2/',
        '/p-route-2/bird//c-p2-route-2/',
        '/p-route-2/c-p2-route-2/cat/',
        '/p-route-2///c-p2-route-2/cat',
        '/p-route-2///c-p2-route-2/cat/',
      ]) {
        await build(path);
        expect(state('child-p2').currentRouteName, 'c-p2-route-2');
      }
    });
  });

  group('Navigator, path change tests', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    Future<void> buildPath(String path) async {
      await app!.setPath(path);
      await app!.buildChildren(
        widgets: [
          Navigator(
            key: Key('g-parent'),
            routes: [
              Route(name: 'g-p-route-1', page: Text('g-p-route-1')),
              Route(
                name: 'g-p-route-2',
                page: Navigator(
                  key: Key('parent'),
                  routes: [
                    Route(
                      name: 'p-route-1',
                      page: Navigator(
                        key: Key('child'),
                        routes: [
                          Route(name: 'c-route-1', page: Text('c-route-1')),
                          Route(name: 'c-route-2', page: Text('c-route-2')),
                        ],
                      ),
                    ),
                    Route(name: 'p-route-2', page: Text('p-route-2')),
                  ],
                ),
              ),
              Route(
                name: 'g-p-route-3',
                page: Navigator(
                  routes: [
                    Route(name: 'p-route-1', page: Text('p-route-1')),
                    Route(name: 'p-route-2', page: Text('p-route-2')),
                  ],
                ),
              ),
            ],
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );
    }

    test(
      'should keep value segments intact during child ops',
      () async {
        //
        await app!.setPath('/p-route-1/some-val/c-page-1/');

        await app!.buildChildren(
          widgets: [
            Navigator(
              key: Key('parent'),
              routes: [
                Route(
                  name: 'p-route-1',
                  page: Navigator(
                    key: Key('child'),
                    routes: [
                      Route(name: 'c-page-1', page: Text('page-1')),
                      Route(name: 'c-page-2', page: Text('page-2')),
                      Route(name: 'c-page-3', page: Text('page-3')),
                    ],
                  ),
                ),
              ],
            ),
          ],
          parentRenderElement: app!.appRenderElement,
        );

        var child = app!.navigatorState('child');

        app!.assertMatchPath('/p-route-1/some-val/c-page-1');

        child.open(name: 'c-page-2');
        await Future.delayed(Duration(milliseconds: 100));
        app!.assertMatchPath('/p-route-1/some-val/c-page-2');

        child.open(name: 'c-page-1', values: {'some-var': 'some-val'});
        await Future.delayed(Duration(milliseconds: 100));
        app!.assertMatchPath('/p-route-1/some-val/c-page-1/some-var/some-val');

        child.open(name: 'c-page-2');
        await Future.delayed(Duration(milliseconds: 100));
        app!.assertMatchPath('/p-route-1/some-val/c-page-2');
      },
    );

    // these tests fails on in actual browser environment(window obj).
    // for now, we've fixed these issue. but it seems our router needs a
    // re-write(just internals + requires unit tests).

    test(
      'should change only the inner path if open called on inner navigator',
      () async {
        //
        await app!.setPath('/p-route-1/c-page-1/');

        await app!.buildChildren(
          widgets: [
            Navigator(
              key: Key('parent'),
              routes: [
                Route(
                  name: 'p-route-1',
                  page: Navigator(
                    key: Key('child'),
                    routes: [
                      Route(name: 'c-page-1', page: Text('page-1')),
                      Route(name: 'c-page-2', page: Text('page-2')),
                      Route(name: 'c-page-3', page: Text('page-3')),
                    ],
                  ),
                ),
              ],
            ),
          ],
          parentRenderElement: app!.appRenderElement,
        );

        var child = app!.navigatorState('child');

        app!.assertMatchPath('/p-route-1/c-page-1');

        child.open(name: 'c-page-2');
        await Future.delayed(Duration(milliseconds: 100));
        app!.assertMatchPath('/p-route-1/c-page-2');

        child.open(name: 'c-page-3', values: {'some-var': 'some-value'});
        await Future.delayed(Duration(milliseconds: 100));
        app!.assertMatchPath('/p-route-1/c-page-3/some-var/some-value');

        child.open(name: 'c-page-1');
        await Future.delayed(Duration(milliseconds: 100));
        app!.assertMatchPath('/p-route-1/c-page-1');
      },
    );

    test('should not change path if matched', () async {
      await buildPath('/g-p-route-1');
      app!.assertMatchPath('/g-p-route-1');

      await buildPath('/g-p-route-1/som/val');
      app!.assertMatchPath('/g-p-route-1/som/val');

      await buildPath('/g-p-route-3/p-route-1');
      app!.assertMatchPath('/g-p-route-3/p-route-1');

      await buildPath('/g-p-route-3/p-route-2');
      app!.assertMatchPath('/g-p-route-3/p-route-2');

      await buildPath('/g-p-route-3/som/val/p-route-2');
      app!.assertMatchPath('/g-p-route-3/som/val/p-route-2');

      await buildPath('/g-p-route-2/p-route-1/c-route-2/s/');
      app!.assertMatchPath('/g-p-route-2/p-route-1/c-route-2/s/');

      await buildPath('/g-p-route-2/some/val/p-route-1/s/c-route-2/s/');
      app!.assertMatchPath('/g-p-route-2/some/val/p-route-1/s/c-route-2/s/');
    });
  });
}
