// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Auto-generated file
//
// Sources of these tests can be found in /test/templates folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_widgets_test.dart';

void widget_navigator_test() {
  group('Widget specific tests for Navigator widget:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('Navigator widget - description test', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          Navigator(
            key: Key('widget'),
            routes: [
              Route(name: 'name', page: Text('hw')),
            ],
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByKeyValue('widget');

      expect(domNode.getComputedStyle().display, equals('contents'));
    });

    test('should return true from shouldUpdateWidgetChildren', () {
      var shouldUpdateWidgetChildren = true;

      var oldWidget = Navigator(routes: []);
      var newWidget = Navigator(routes: []);

      shouldUpdateWidgetChildren = newWidget.shouldUpdateWidgetChildren(
        oldWidget,
        false,
      );
      expect(shouldUpdateWidgetChildren, equals(false));

      shouldUpdateWidgetChildren = newWidget.shouldUpdateWidgetChildren(
        oldWidget,
        true,
      );
      expect(shouldUpdateWidgetChildren, equals(false));
    });
  });
}
