// Auto-generated file
//
// Sources of these tests can be found in /test/templates folder

// ignore_for_file: non_constant_identifier_names

part of '../_index_widgets_tests.dart';

void widget_table_body_test() {
  group('Widget specific tests for TableBody widget:', () {
    RT_AppRunner? app;

    setUp(() {
      app = createTestApp()..start();
    });

    tearDown(() => app!.stop());

    test('TableBody widget - widgetType override test', () {
      expect(TableBody().widgetType, equals('$TableBody'));
    });
  });
}