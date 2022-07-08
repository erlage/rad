// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Auto-generated file
//
// Sources of these tests can be found in /test/templates folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_widgets_test.dart';

void widget_route_test() {
  group('Widget specific tests for Route widget:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('Route widget - widgetType override test', () {
      var widget = Route(
        name: '',
        page: Text('hw'),
      );

      expect(widget.widgetType, equals('$Route'));
    });

    test('Route widget - description test', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          Route(
            key: Key('widget'),
            name: 'some-name',
            page: Text('hw'),
          ),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByKeyValue('widget');

      expect(domNode.getComputedStyle().display, equals('contents'));
    });
  });
}
