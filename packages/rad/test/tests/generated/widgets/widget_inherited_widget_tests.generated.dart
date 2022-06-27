// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Auto-generated file
//
// Sources of these tests can be found in /test/templates folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_widgets_test.dart';

void widget_inherited_widget_test() {
  group('Widget specific tests for InheritedWidget widget:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('Inherited widget - widgetType override test', () {
      var widget = RT_InheritedWidget(child: Text('hw'));

      expect(widget.widgetType, equals('$InheritedWidget'));
    });

    test('should return false from shouldUpdateWidgetChildren', () {
      var shouldUpdateWidgetChildren = false;

      var oldWidget = RT_InheritedWidget(child: Text('hw'));
      var newWidget = RT_InheritedWidget(child: Text('hw'));

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
