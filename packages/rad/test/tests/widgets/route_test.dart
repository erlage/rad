// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: camel_case_types

import '../../test_imports.dart';

void main() {
  // Route widget is not concerned with its sibling routes.

  // A navigator or any other widget can add constraints over its child widgets
  // which means some parts of the behavior tested below might not work as
  // expected when a route widget is used under a navigator widget. Tests below
  // are just to ensure that widget properties are set and updated correctly.

  group('Route widget tests:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('should render page', () async {
      await app!.buildChildren(
        widgets: [
          Route(name: 'some-name', page: Text('page contents')),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents('page contents'));
    });

    test('should update page', () async {
      await app!.buildChildren(
        widgets: [
          Route(name: 'some-name', page: Text('contents')),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents('contents'));

      await app!.updateChildren(
        widgets: [
          Route(name: 'some-name', page: Text('updated')),
          Route(name: 'another-name', page: Text('appended')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents('updated|appended'));
    });

    test('should render duplicate routes', () async {
      await app!.buildChildren(
        widgets: [
          Route(name: 'duplicate-name', page: Text('1')),
          Route(name: 'duplicate-name', page: Text('2')),
          Route(name: 'duplicate-name', page: Text('3')),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents('1|2|3'));
    });

    test('should update duplicate routes', () async {
      await app!.buildChildren(
        widgets: [
          Route(name: 'duplicate-name', page: Text('1')),
          Route(name: 'duplicate-name', page: Text('2')),
          Route(name: 'duplicate-name', page: Text('3')),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      await app!.updateChildren(
        widgets: [
          Route(name: 'duplicate-name', page: Text('1')),
          Route(name: 'duplicate-name', page: Text('3')),
          Route(name: 'duplicate-name', page: Text('2')),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      expect(RT_TestBed.rootDomNode, RT_hasContents('1|3|2'));
    });

    test('should set route name', () async {
      await app!.buildChildren(
        widgets: [
          Route(
            key: Key('a'),
            name: 'some-name',
            page: Text('contents'),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var widget = app!.renderElementByKeyValue('a')!.widget as Route;

      expect(widget.name, equals('some-name'));
    });

    test('should set route path', () async {
      await app!.buildChildren(
        widgets: [
          Route(
            key: Key('a'),
            name: 'some-name',
            path: 'path',
            page: Text('contents'),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var widget = app!.renderElementByKeyValue('a')!.widget as Route;

      expect(widget.path, equals('path'));
    });

    test('should update route name if changed', () async {
      await app!.buildChildren(
        widgets: [
          Route(
            key: Key('a'),
            name: 'some-name',
            page: Text('contents'),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var widget = app!.renderElementByKeyValue('a')!.widget as Route;

      expect(widget.name, equals('some-name'));

      await app!.updateChildren(
        widgets: [
          Route(
            key: Key('a'),
            name: 'another-name',
            page: Text('contents'),
          ),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      widget = app!.renderElementByKeyValue('a')!.widget as Route;

      expect(widget.name, equals('another-name'));
    });

    test('should update route path if changed', () async {
      await app!.buildChildren(
        widgets: [
          Route(
            key: Key('a'),
            name: 'some-name',
            path: 'path',
            page: Text('contents'),
          ),
        ],
        parentRenderElement: app!.appRenderElement,
      );

      var widget = app!.renderElementByKeyValue('a')!.widget as Route;

      expect(widget.path, equals('path'));

      await app!.updateChildren(
        widgets: [
          Route(
            key: Key('a'),
            name: 'another-name',
            path: 'updated-path',
            page: Text('contents'),
          ),
        ],
        updateType: UpdateType.setState,
        parentRenderElement: app!.appRenderElement,
      );

      widget = app!.renderElementByKeyValue('a')!.widget as Route;

      expect(widget.path, equals('updated-path'));
    });

    test(
      'should act as normal widget(multiple instance, nesting etc)',
      () async {
        await app!.buildChildren(
          widgets: [
            Route(
              name: 'some-name',
              page: RT_TestWidget(
                children: [
                  Text('1'),
                  Route(name: 'another-name1', page: Text('2')),
                  Route(name: 'another-name2', page: Text('3')),
                  Route(name: 'another-name3', page: Text('4')),
                  Route(
                    name: 'another-name4',
                    page: RT_TestWidget(
                      children: [
                        Route(name: 'another-name1', page: Text('5')),
                        Route(name: 'another-name2', page: Text('6')),
                        Route(name: 'another-name3', page: Text('7')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
          parentRenderElement: app!.appRenderElement,
        );

        expect(RT_TestBed.rootDomNode, RT_hasContents('1|2|3|4|5|6|7'));

        await app!.updateChildren(
          widgets: [
            Route(
              name: 'some-name',
              page: RT_TestWidget(
                children: [
                  Text('1'),
                  Route(name: 'another-name1', page: Text('2')),
                  Route(name: 'another-name3', page: Text('4')),
                  Route(name: 'another-name2', page: Text('3')),
                  Route(
                    name: 'another-name4',
                    page: RT_TestWidget(
                      children: [
                        Route(name: 'another-name1', page: Text('5')),
                        Route(name: 'another-name3', page: Text('7')),
                        Route(name: 'another-name2', page: Text('6')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
          updateType: UpdateType.setState,
          parentRenderElement: app!.appRenderElement,
        );

        expect(RT_TestBed.rootDomNode, RT_hasContents('1|2|4|3|5|7|6'));
      },
    );
  });
}
