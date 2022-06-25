// Copyright (c) 2022, the Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Auto-generated file
//
// Sources of these tests can be found in /test/templates folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_widgets_test.dart';

void widget_gesture_detector_test() {
  group('Widget specific tests for GestureDetector widget:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('GestureDetector widget - widgetType override test', () {
      var widget = GestureDetector(child: Text('hw'));

      expect(widget.widgetType, equals('$GestureDetector'));
    });

    test('GestureDetector widget - description test', () async {
      var pap = app!;

      await pap.buildChildren(
        widgets: [
          GestureDetector(key: GlobalKey('widget'), child: Text('hw')),
        ],
        parentRenderElement: pap.appRenderElement,
      );

      var domNode = pap.domNodeByGlobalKey('widget');

      expect(domNode.getComputedStyle().display, equals('contents'));
    });

    test('should return false from shouldUpdateWidgetChildren', () {
      var shouldUpdateWidgetChildren = false;

      var oldWidget = GestureDetector(child: Text('hw'));
      var newWidget = GestureDetector(child: Text('hw'));

      shouldUpdateWidgetChildren = newWidget.shouldUpdateWidgetChildren(
        oldWidget,
        false,
      );
      expect(shouldUpdateWidgetChildren, equals(true));

      shouldUpdateWidgetChildren = newWidget.shouldUpdateWidgetChildren(
        oldWidget,
        true,
      );
      expect(shouldUpdateWidgetChildren, equals(true));
    });
  });
}
