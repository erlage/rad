// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Auto-generated file
//
// Sources of these tests can be found in /test/templates folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_widgets_test.dart';

void widget_event_detector_test() {
  group('Widget specific tests for EventDetector widget:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('should return false from shouldUpdateWidgetChildren', () {
      var shouldUpdateWidgetChildren = false;

      var oldWidget = EventDetector(child: Text('hw'));
      var newWidget = EventDetector(child: Text('hw'));

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
