// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Auto-generated file
//
// Sources of these tests can be found in /test/templates folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_widgets_test.dart';

void widget_strike_through_test() {
  group('Widget specific tests for StrikeThrough widget:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('StrikeThrough widget - widgetType override test', () {
      expect(StrikeThrough().widgetType, equals('$StrikeThrough'));
    });
  });
}
