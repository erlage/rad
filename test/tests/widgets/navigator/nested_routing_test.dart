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
            key: GlobalKey('parent'),
            routes: [
              Route(
                name: 'p-route-1',
                page: Navigator(
                  key: GlobalKey('child'),
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
        parentContext: app!.appContext,
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
              key: GlobalKey('parent'),
              routes: [
                Route(
                  name: 'p-route-1',
                  page: Division(
                    children: [
                      Navigator(
                        key: GlobalKey('child'),
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
          parentContext: app!.appContext,
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
            key: GlobalKey('g-parent'),
            routes: [
              Route(
                name: 'g-p-route-1',
                page: Navigator(
                  key: GlobalKey('parent'),
                  routes: [
                    Route(
                      name: 'p-route-1',
                      page: Navigator(
                        key: GlobalKey('child'),
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
        parentContext: app!.appContext,
      );

      var gparent = app!.navigatorState('g-parent');
      var parent = app!.navigatorState('parent');
      var child = app!.navigatorState('child');

      expect(gparent.currentRouteName, 'g-p-route-1');
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
              key: GlobalKey('g-parent'),
              routes: [
                Route(
                  name: 'g-p-route-1',
                  page: Division(
                    child: Navigator(
                      key: GlobalKey('parent'),
                      routes: [
                        Route(
                          name: 'p-route-1',
                          page: Division(
                            child: Navigator(
                              key: GlobalKey('child'),
                              routes: [
                                Route(name: 'c-route-1', page: Text('c-rt-1')),
                                Route(name: 'c-route-2', page: Text('c-rt-2')),
                              ],
                            ),
                          ),
                        ),
                        Route(name: 'p-route-2', page: Text('p-route-2')),
                      ],
                    ),
                  ),
                ),
                Route(name: 'g-p-route-2', page: Text('g-p-route-2')),
              ],
            ),
          ],
          parentContext: app!.appContext,
        );

        var gparent = app!.navigatorState('g-parent');
        var parent = app!.navigatorState('parent');
        var child = app!.navigatorState('child');

        expect(gparent.currentRouteName, 'g-p-route-1');
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
            key: GlobalKey('parent'),
            routes: [
              Route(
                name: 'p-route-1',
                page: Navigator(
                  key: GlobalKey('child'),
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
        parentContext: app!.appContext,
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
              key: GlobalKey('parent'),
              routes: [
                Route(
                  name: 'p-route-1',
                  page: Navigator(
                    key: GlobalKey('child'),
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
          parentContext: app!.appContext,
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
              key: GlobalKey('g-parent'),
              routes: [
                Route(
                  name: 'g-p-route-1',
                  page: Navigator(
                    key: GlobalKey('parent'),
                    routes: [
                      Route(
                        name: 'p-route-1',
                        page: Navigator(
                          key: GlobalKey('child'),
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
          parentContext: app!.appContext,
        );

        var gparent = app!.navigatorState('g-parent');
        expect(gparent.currentRouteName, 'g-p-route-1');

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
              key: GlobalKey('g-parent'),
              routes: [
                Route(
                  name: 'g-p-route-1',
                  page: Navigator(
                    key: GlobalKey('parent'),
                    routes: [
                      Route(
                        name: 'p-route-1',
                        page: Navigator(
                          key: GlobalKey('child'),
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
          parentContext: app!.appContext,
        );

        var gparent = app!.navigatorState('g-parent');
        expect(gparent.currentRouteName, 'g-p-route-1');

        var parent = app!.navigatorState('parent');
        expect(parent.currentRouteName, 'p-route-1');

        var child = app!.navigatorState('child');
        expect(child.currentRouteName, 'c-route-1');
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
            key: GlobalKey('parent'),
            routes: [
              Route(
                name: 'p-route-1',
                page: Navigator(
                  key: GlobalKey('child'),
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
        parentContext: app!.appContext,
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
            key: GlobalKey('parent'),
            routes: [
              Route(
                name: 'p-route-1',
                page: Navigator(
                  key: GlobalKey('child'),
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
        parentContext: app!.appContext,
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
              key: GlobalKey('parent'),
              routes: [
                Route(
                  name: 'p-route-1',
                  page: Navigator(
                    key: GlobalKey('child'),
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
          parentContext: app!.appContext,
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
              key: GlobalKey('parent'),
              routes: [
                Route(
                  name: 'p-route-1',
                  page: Navigator(
                    key: GlobalKey('child'),
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
          parentContext: app!.appContext,
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
            key: GlobalKey('g-parent'),
            routes: [
              Route(name: 'g-p-route-1', page: Text('g-p-route-2')),
              Route(
                name: 'g-p-route-2',
                page: Navigator(
                  key: GlobalKey('parent'),
                  routes: [
                    Route(
                      name: 'p-route-1',
                      page: Navigator(
                        key: GlobalKey('child'),
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
        parentContext: app!.appContext,
      );

      var gparent = app!.navigatorState('g-parent');
      expect(gparent.currentRouteName, 'g-p-route-2');

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
              key: GlobalKey('g-parent'),
              routes: [
                Route(name: 'g-p-route-1', page: Text('g-p-route-2')),
                Route(
                  name: 'g-p-route-2',
                  page: Navigator(
                    key: GlobalKey('parent'),
                    routes: [
                      Route(
                        name: 'p-route-1',
                        page: Navigator(
                          key: GlobalKey('child'),
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
          parentContext: app!.appContext,
        );

        var gparent = app!.navigatorState('g-parent');
        expect(gparent.currentRouteName, 'g-p-route-2');

        var parent = app!.navigatorState('parent');
        expect(parent.currentRouteName, 'p-route-1');

        var child = app!.navigatorState('child');
        expect(child.currentRouteName, 'c-route-2');
      },
    );
  });
}
