// Copyright (c) 2022, Rad developers. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Auto-generated file
//
// Sources of these tests can be found in /test/templates folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_widgets_test.dart';

void widget_keyboard_input_test() {
  group('Widget specific tests for KeyboardInput widget:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('KeyboardInput widget - widgetType override test', () {
      expect(KeyboardInput().widgetType, equals('$KeyboardInput'));
    });
  });
}
