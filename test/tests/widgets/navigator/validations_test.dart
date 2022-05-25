// ignore_for_file: camel_case_types

import '../../../test_imports.dart';

void main() {
  /*
  |--------------------------------------------------------------------------
  | Dev mode tests
  |--------------------------------------------------------------------------
  */

  group('Navigator widget dev mode tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp(
        debugOptions: DebugOptions(
          routerLogs: true,
          additionalChecks: true,
        ),
      )..start();
    });

    tearDown(() => app!.stop());

    test('should throw if name is empty', () {
      expect(
        () => app!.buildChildren(
          widgets: [
            Navigator(
              routes: [
                Route(name: '', page: Text('route')),
              ],
            ),
          ],
          parentContext: app!.appContext,
        ),
        throwsA(
          predicate(
            (e) => '$e'.startsWith(
              "Exception: Navigator's Route's name can't be empty.",
            ),
          ),
        ),
      );
    });

    test('should throw if name is empty(space test)', () {
      expect(
        () => app!.buildChildren(
          widgets: [
            Navigator(
              routes: [
                Route(name: ' ', path: 'asd', page: Text('route')),
              ],
            ),
          ],
          parentContext: app!.appContext,
        ),
        throwsA(
          predicate(
            (e) => '$e'.startsWith(
              "Exception: Navigator's Route's name cannot contain empty spaces.",
            ),
          ),
        ),
      );
    });

    test('should throw if path is empty', () {
      expect(
        () => app!.buildChildren(
          widgets: [
            Navigator(
              routes: [
                Route(name: 'asd', path: '', page: Text('route')),
              ],
            ),
          ],
          parentContext: app!.appContext,
        ),
        throwsA(
          predicate(
            (e) => '$e'.startsWith(
              "Exception: Navigator's Route's path can't be empty.",
            ),
          ),
        ),
      );
    });

    test('should throw if path is empty(space test)', () {
      expect(
        () => app!.buildChildren(
          widgets: [
            Navigator(
              routes: [
                Route(name: 'asd', path: ' ', page: Text('route')),
              ],
            ),
          ],
          parentContext: app!.appContext,
        ),
        throwsA(
          predicate(
            (e) => '$e'.startsWith(
              "Exception: Navigator's Route can contains only",
            ),
          ),
        ),
      );
    });

    test('should throw if found illegal characters in route path(space)', () {
      expect(
        () => app!.buildChildren(
          widgets: [
            Navigator(
              routes: [
                Route(name: 'route 1', path: 's s', page: Text('route')),
              ],
            ),
          ],
          parentContext: app!.appContext,
        ),
        throwsA(
          predicate(
            (e) => '$e'.startsWith(
              "Exception: Navigator's Route can contains only",
            ),
          ),
        ),
      );
    });

    test('should throw if found illegal characters in route path(special)', () {
      expect(
        () => app!.buildChildren(
          widgets: [
            Navigator(
              routes: [
                Route(name: 'route .', path: 's.s', page: Text('route')),
              ],
            ),
          ],
          parentContext: app!.appContext,
        ),
        throwsA(
          predicate(
            (e) => '$e'.startsWith(
              "Exception: Navigator's Route can contains only",
            ),
          ),
        ),
      );
    });

    test('should throw if found a duplicate route', () {
      expect(
        () => app!.buildChildren(
          widgets: [
            Navigator(
              routes: [
                Route(name: 'route-1', page: Text('route-1')),
                Route(name: 'route-1', page: Text('route-2')),
              ],
            ),
          ],
          parentContext: app!.appContext,
        ),
        throwsA(
          predicate(
            (e) => '$e'.startsWith('Exception: Please remove Duplicate'),
          ),
        ),
      );
    });

    test('should throw if found a duplicate route (mixed test)', () {
      expect(
        () => app!.buildChildren(
          widgets: [
            Navigator(
              routes: [
                Route(name: 'route-1', page: Text('route-1')),
                AsyncRoute(name: 'route-1', page: () async => Text('route-2')),
              ],
            ),
          ],
          parentContext: app!.appContext,
        ),
        throwsA(
          predicate(
            (e) => '$e'.startsWith('Exception: Please remove Duplicate'),
          ),
        ),
      );
    });

    test('should throw if found a duplicate route(path test)', () {
      expect(
        () => app!.buildChildren(
          widgets: [
            Navigator(
              routes: [
                Route(name: 'route-1', page: Text('route-1')),
                Route(
                  name: 'route-2',
                  path: 'route-1',
                  page: Text('route-2'),
                ),
              ],
            ),
          ],
          parentContext: app!.appContext,
        ),
        throwsA(
          predicate(
            (e) => '$e'.startsWith('Exception: Please remove Duplicate'),
          ),
        ),
      );
    });
  });

  /*
  |--------------------------------------------------------------------------
  | Prod mode tests
  |--------------------------------------------------------------------------
  */

  group('Navigator widget prod mode tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp(
        debugOptions: DebugOptions(
          routerLogs: true,
          additionalChecks: false,
        ),
      )..start();
    });

    tearDown(() => app!.stop());

    test('should not throw if name is empty', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            routes: [
              Route(name: '', page: Text('route')),
            ],
          ),
        ],
        parentContext: app!.appContext,
      );
    });

    test('should not throw if name is empty(space test)', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            routes: [
              Route(name: ' ', path: 'asd', page: Text('route')),
            ],
          ),
        ],
        parentContext: app!.appContext,
      );
    });

    test('should not throw if path is empty', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            routes: [
              Route(name: 'asd', path: '', page: Text('route')),
            ],
          ),
        ],
        parentContext: app!.appContext,
      );
    });

    test('should not throw if path is empty(space test)', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            routes: [
              Route(name: 'asd', path: ' ', page: Text('route')),
            ],
          ),
        ],
        parentContext: app!.appContext,
      );
    });

    test('should not throw if found illegal characters in route path(space)',
        () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            routes: [
              Route(name: 'route 1', path: 's s', page: Text('route')),
            ],
          ),
        ],
        parentContext: app!.appContext,
      );
    });

    test(
      'should not throw if found illegal characters in route path(special)',
      () async {
        await app!.buildChildren(
          widgets: [
            Navigator(
              routes: [
                Route(name: 'route .', path: 's.s', page: Text('route')),
              ],
            ),
          ],
          parentContext: app!.appContext,
        );
      },
    );

    test('should not throw if found a duplicate route', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            routes: [
              Route(name: 'route-1', page: Text('route-1')),
              Route(name: 'route-1', page: Text('route-2')),
            ],
          ),
        ],
        parentContext: app!.appContext,
      );
    });

    test('should not throw if found a duplicate route (mixed test)', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            routes: [
              Route(name: 'route-1', page: Text('route-1')),
              AsyncRoute(name: 'route-1', page: () async => Text('route-2')),
            ],
          ),
        ],
        parentContext: app!.appContext,
      );
    });

    test('should not throw if found a duplicate route(path test)', () async {
      await app!.buildChildren(
        widgets: [
          Navigator(
            routes: [
              Route(name: 'route-1', page: Text('route-1')),
              Route(
                name: 'route-2',
                path: 'route-1',
                page: Text('route-2'),
              ),
            ],
          ),
        ],
        parentContext: app!.appContext,
      );
    });
  });
}
